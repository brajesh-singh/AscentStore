/**
 *
 */
package com.pwc.demo.core.payment.impl;

import de.hybris.platform.payment.commands.request.AuthorizationRequest;
import de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;
import de.hybris.platform.payment.dto.BillingInfo;
import de.hybris.platform.payment.dto.CardInfo;
import de.hybris.platform.payment.enums.PaymentTransactionType;
import de.hybris.platform.payment.impl.DefaultPaymentServiceImpl;
import de.hybris.platform.payment.methods.CardPaymentService;
import de.hybris.platform.payment.model.PaymentTransactionEntryModel;
import de.hybris.platform.payment.model.PaymentTransactionModel;

import java.math.BigDecimal;
import java.util.Currency;
import java.util.Date;


/**
 * @author kyao011
 *
 */
public class AscentPaymentServiceImpl extends DefaultPaymentServiceImpl
{

	private CardPaymentService ascentCardPaymentService;

	@Override
	protected PaymentTransactionEntryModel authorizeInternal(final PaymentTransactionModel transaction, final BigDecimal amount,
			final Currency currency, final BillingInfo shippingInfo, final CardInfo card, final String subscriptionID,
			final String cv2, final String paymentProvider)
	{
		final PaymentTransactionType paymentTransactionType = PaymentTransactionType.AUTHORIZATION;
		final String newEntryCode = this.getNewPaymentTransactionEntryCode(transaction, paymentTransactionType);
		AuthorizationResult result;
		if (subscriptionID == null)
		{

			result = getAscentCardPaymentService()
					.authorize(new AuthorizationRequest(newEntryCode, card, currency, amount, shippingInfo));


		}
		else
		{
			result = getAscentCardPaymentService().authorize(new SubscriptionAuthorizationRequest(newEntryCode, subscriptionID,
					currency, amount, shippingInfo, cv2, paymentProvider));
		}

		transaction.setRequestId(result.getRequestId());
		transaction.setRequestToken(result.getRequestToken());
		transaction.setPaymentProvider(result.getPaymentProvider());
		this.getModelService().save(transaction);

		final PaymentTransactionEntryModel entry = (PaymentTransactionEntryModel) this.getModelService()
				.create(PaymentTransactionEntryModel.class);
		entry.setAmount(result.getTotalAmount());
		if (result.getCurrency() != null)
		{

			entry.setCurrency(this.getCommonI18NService().getCurrency(result.getCurrency().getCurrencyCode()));
		}
		entry.setType(paymentTransactionType);
		entry.setTime(result.getAuthorizationTime() == null ? new Date() : result.getAuthorizationTime());
		entry.setPaymentTransaction(transaction);
		entry.setRequestId(result.getRequestId());
		entry.setRequestToken(result.getRequestToken());
		entry.setTransactionStatus(result.getTransactionStatus().toString());
		entry.setTransactionStatusDetails(result.getTransactionStatusDetails().toString());
		entry.setCode(newEntryCode);
		if (subscriptionID != null)
		{

			entry.setSubscriptionID(subscriptionID);
		}
		this.getModelService().save(entry);
		this.getModelService().refresh(transaction);
		return entry;
	}

	/**
	 * @return the ascentCardPaymentService
	 */
	public CardPaymentService getAscentCardPaymentService()
	{
		return ascentCardPaymentService;
	}

	/**
	 * @param ascentCardPaymentService
	 *           the ascentCardPaymentService to set
	 */
	public void setAscentCardPaymentService(final CardPaymentService ascentCardPaymentService)
	{
		this.ascentCardPaymentService = ascentCardPaymentService;
	}

}
