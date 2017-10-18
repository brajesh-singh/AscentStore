/**
 *
 */
package com.pwc.demo.facades.order.impl;

import static de.hybris.platform.util.localization.Localization.getLocalizedString;

import de.hybris.platform.b2b.model.B2BCommentModel;
import de.hybris.platform.b2b.model.B2BCostCenterModel;
import de.hybris.platform.b2bacceleratorfacades.exception.EntityValidationException;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BPaymentTypeData;
import de.hybris.platform.b2bacceleratorfacades.order.impl.DefaultB2BCheckoutFacade;
import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.core.model.order.AbstractOrderEntryModel;
import de.hybris.platform.core.model.order.CartModel;

import java.util.Objects;


/**
 * @author kyao011
 *
 */
public class AscentB2BCheckoutFacade extends DefaultB2BCheckoutFacade
{
	private static final String CART_CHECKOUT_COSTCENTER_PAYMENTTYPE_INVALID = "cart.costcenter.paymenttypeInvalid";
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
}
