/**
 *
 */
package com.pwc.demo.facades.order.impl;

import static de.hybris.platform.util.localization.Localization.getLocalizedString;

import de.hybris.platform.b2b.model.B2BCommentModel;
import de.hybris.platform.b2b.model.B2BCostCenterModel;
import de.hybris.platform.b2bacceleratorfacades.checkout.data.PlaceOrderData;
import de.hybris.platform.b2bacceleratorfacades.exception.EntityValidationException;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BCommentData;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BPaymentTypeData;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BReplenishmentRecurrenceEnum;
import de.hybris.platform.b2bacceleratorfacades.order.data.TriggerData;
import de.hybris.platform.b2bacceleratorfacades.order.impl.DefaultB2BCheckoutFacade;
import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;
import de.hybris.platform.commercefacades.order.data.AbstractOrderData;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.OrderData;
import de.hybris.platform.core.model.order.AbstractOrderEntryModel;
import de.hybris.platform.core.model.order.CartModel;
import de.hybris.platform.core.model.order.OrderModel;
import de.hybris.platform.order.InvalidCartException;
import de.hybris.platform.payment.dto.TransactionStatus;
import de.hybris.platform.payment.enums.PaymentTransactionType;
import de.hybris.platform.payment.model.PaymentTransactionEntryModel;
import de.hybris.platform.payment.model.PaymentTransactionModel;
import de.hybris.platform.subscriptionfacades.SubscriptionFacade;
import de.hybris.platform.subscriptionfacades.exceptions.SubscriptionFacadeException;

import java.util.List;
import java.util.Objects;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;


/**
 * @author kyao011
 *
 */
public class AscentB2BCheckoutFacade extends DefaultB2BCheckoutFacade
{
	private static final Logger LOG = Logger.getLogger(AscentB2BCheckoutFacade.class);

	private SubscriptionFacade subscriptionFacade;

	private static final String CART_CHECKOUT_COSTCENTER_PAYMENTTYPE_INVALID = "cart.costcenter.paymenttypeInvalid";


	private static final String CART_CHECKOUT_DELIVERYMODE_INVALID = "cart.deliveryMode.invalid";

	private static final String CART_CHECKOUT_PAYMENTINFO_EMPTY = "cart.paymentInfo.empty";
	private static final String CART_CHECKOUT_NOT_CALCULATED = "cart.not.calculated";

	private static final String CART_CHECKOUT_TRANSACTION_NOT_AUTHORIZED = "cart.transation.notAuthorized";

	private static final String CART_CHECKOUT_TERM_UNCHECKED = "cart.term.unchecked";
	private static final String CART_CHECKOUT_NO_QUOTE_DESCRIPTION = "cart.no.quote.description";
	private static final String CART_CHECKOUT_REPLENISHMENT_NO_STARTDATE = "cart.replenishment.no.startdate";
	private static final String CART_CHECKOUT_REPLENISHMENT_NO_FREQUENCY = "cart.replenishment.no.frequency";
	@Override
	public CartData updateCheckoutCart(final CartData cartData)
	{
		final CartModel cartModel = getCart();
		if (cartModel == null)
		{
			return null;
		}
		// set payment type
		if (cartData.getPaymentType() != null)
		{
			final String newPaymentTypeCode = cartData.getPaymentType().getCode();

			// clear delivery address, delivery mode and payment details when changing payment type
			if (cartModel.getPaymentType() == null || !newPaymentTypeCode.equalsIgnoreCase(cartModel.getPaymentType().getCode()))
			{
				cartModel.setPaymentInfo(null);
			}

			setPaymentTypeForCart(newPaymentTypeCode, cartModel);
			// cost center need to be be cleared if using card
			if (CheckoutPaymentType.CARD.getCode().equals(newPaymentTypeCode))
			{
				setCostCenterForCart(null, cartModel);
			}
		}

		// set cost center
		if (cartData.getCostCenter() != null)
		{
			setCostCenterForCart(cartData.getCostCenter().getCode(), cartModel);
		}

		// set purchase order number
		if (cartData.getPurchaseOrderNumber() != null)
		{
			cartModel.setPurchaseOrderNumber(cartData.getPurchaseOrderNumber());
		}

		// set delivery address
		if (cartData.getDeliveryAddress() != null)
		{
			setDeliveryAddress(cartData.getDeliveryAddress());
		}

		// set quote request description
		if (cartData.getB2BComment() != null)
		{
			final B2BCommentModel b2bComment = getModelService().create(B2BCommentModel.class);
			b2bComment.setComment(cartData.getB2BComment().getComment());
			getB2bCommentService().addComment(cartModel, b2bComment);
		}

		getModelService().save(cartModel);
		return getCheckoutCart();

	}

	@Override
	protected void setCostCenterForCart(final String costCenterCode, final CartModel cartModel)
	{
		final B2BPaymentTypeData paymentType = getCheckoutCart().getPaymentType();
		if (paymentType.getCode().equals("CARD") && costCenterCode != null)
		{
			throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_COSTCENTER_PAYMENTTYPE_INVALID));
		}

		B2BCostCenterModel costCenterModel = null;
		if (costCenterCode != null)
		{
			costCenterModel = getB2bCostCenterService().getCostCenterForCode(costCenterCode);
		}

		for (final AbstractOrderEntryModel abstractOrderEntry : cartModel.getEntries())
		{
			if (!Objects.equals(abstractOrderEntry.getCostCenter(), costCenterModel))
			{
				abstractOrderEntry.setCostCenter(costCenterModel);
				getModelService().save(abstractOrderEntry);
			}
		}

	}

	@Override
	protected void afterPlaceOrder(final CartModel cartModel, final OrderModel orderModel)
	{
		super.afterPlaceOrder(cartModel, orderModel);
		final OrderData orderDate = getOrderConverter().convert(orderModel);
		try
		{
			getSubscriptionFacade().createSubscriptions(orderDate, null);
		}
		catch (final SubscriptionFacadeException e)
		{
			LOG.error("Create subscription error:" + e.getMessage());
		}
		// Retrieve a session cart.
		getCartService().getSessionCart();
	}

	@Override
	public <T extends AbstractOrderData> T placeOrder(final PlaceOrderData placeOrderData) throws InvalidCartException
	{
		// term must be checked
		if (!placeOrderData.getTermsCheck().equals(Boolean.TRUE))
		{
			throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_TERM_UNCHECKED));
		}

		// for CARD type, transaction must be authorized before placing order
		final boolean isCardtPaymentType = CheckoutPaymentType.CARD.getCode().equals(getCart().getPaymentType().getCode());
		if (isCardtPaymentType)
		{
			final List<PaymentTransactionModel> transactions = getCart().getPaymentTransactions();
			boolean authorized = false;
			for (final PaymentTransactionModel transaction : transactions)
			{
				for (final PaymentTransactionEntryModel entry : transaction.getEntries())
				{
					if (entry.getType().equals(PaymentTransactionType.AUTHORIZATION)
							&& TransactionStatus.ACCEPTED.name().equals(entry.getTransactionStatus()))
					{
						authorized = true;
						break;
					}
				}
			}
			if (!authorized)
			{
				// FIXME - change error message
				throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_TRANSACTION_NOT_AUTHORIZED));
			}
		}

		if (isValidCheckoutCart(placeOrderData))
		{
			// validate quote negotiation
			if (placeOrderData.getNegotiateQuote() != null && placeOrderData.getNegotiateQuote().equals(Boolean.TRUE))
			{
				if (StringUtils.isBlank(placeOrderData.getQuoteRequestDescription()))
				{
					throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_NO_QUOTE_DESCRIPTION));
				}
				else
				{
					final B2BCommentData b2BComment = new B2BCommentData();
					b2BComment.setComment(placeOrderData.getQuoteRequestDescription());

					final CartData cartData = new CartData();
					cartData.setB2BComment(b2BComment);

					updateCheckoutCart(cartData);
				}
			}

			// validate replenishment
			if (placeOrderData.getReplenishmentOrder() != null && placeOrderData.getReplenishmentOrder().equals(Boolean.TRUE))
			{
				if (placeOrderData.getReplenishmentStartDate() == null)
				{
					throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_REPLENISHMENT_NO_STARTDATE));
				}

				if (placeOrderData.getReplenishmentRecurrence().equals(B2BReplenishmentRecurrenceEnum.WEEKLY)
						&& CollectionUtils.isEmpty(placeOrderData.getNDaysOfWeek()))
				{
					throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_REPLENISHMENT_NO_FREQUENCY));
				}

				final TriggerData triggerData = new TriggerData();
				populateTriggerDataFromPlaceOrderData(placeOrderData, triggerData);

				return (T) scheduleOrder(triggerData);
			}

			return (T) super.placeOrder();
		}

		return null;
	}
	@Override
	protected boolean isValidCheckoutCart(final PlaceOrderData placeOrderData)
	{
		final CartData cartData = getCheckoutCart();
		final boolean valid = true;

		if (!cartData.isCalculated())
		{
			throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_NOT_CALCULATED));
		}

		if (cartData.getDeliveryMode() == null)
		{
			throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_DELIVERYMODE_INVALID));
		}

		final boolean accountPaymentType = CheckoutPaymentType.ACCOUNT.getCode().equals(cartData.getPaymentType().getCode());
		if (!accountPaymentType && cartData.getPaymentInfo() == null)
		{
			throw new EntityValidationException(getLocalizedString(CART_CHECKOUT_PAYMENTINFO_EMPTY));
		}

		return valid;
	}
	/**
	 * @return the subscriptionFacade
	 */
	public SubscriptionFacade getSubscriptionFacade()
	{
		return subscriptionFacade;
	}

	/**
	 * @param subscriptionFacade
	 *           the subscriptionFacade to set
	 */
	public void setSubscriptionFacade(final SubscriptionFacade subscriptionFacade)
	{
		this.subscriptionFacade = subscriptionFacade;
	}

}
