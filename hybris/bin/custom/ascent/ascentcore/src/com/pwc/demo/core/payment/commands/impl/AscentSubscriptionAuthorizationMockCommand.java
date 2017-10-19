/**
 *
 */
package com.pwc.demo.core.payment.commands.impl;

import de.hybris.platform.payment.commands.impl.GenericMockCommand;
import de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;
import de.hybris.platform.payment.dto.AvsStatus;
import de.hybris.platform.payment.dto.CvnStatus;
import de.hybris.platform.payment.dto.TransactionStatus;
import de.hybris.platform.payment.dto.TransactionStatusDetails;

import java.util.Date;

import com.pwc.demo.core.payment.commands.AscentSubscriptionAuthorizationCommand;

/**
 * @author kyao011
 *
 */
public class AscentSubscriptionAuthorizationMockCommand extends GenericMockCommand
		implements AscentSubscriptionAuthorizationCommand
{
	public static final String INVALID = "invalid";

	@Override
	public AuthorizationResult perform(final SubscriptionAuthorizationRequest request)
	{
		final AuthorizationResult result = new AuthorizationResult();


		result.setCurrency(request.getCurrency());
		result.setTotalAmount(request.getTotalAmount());

		result.setAvsStatus(AvsStatus.NO_RESULT);
		result.setCvnStatus(CvnStatus.NOT_PROCESSED);

		result.setAuthorizationTime(new Date());


		if (request.getSubscriptionID().equalsIgnoreCase("invalid"))
		{

			result.setTransactionStatus(TransactionStatus.REJECTED);
			result.setTransactionStatusDetails(TransactionStatusDetails.INVALID_SUBSCRIPTION_ID);

		}
		else
		{
			result.setTransactionStatus(TransactionStatus.ACCEPTED);
			result.setTransactionStatusDetails(TransactionStatusDetails.SUCCESFULL);
		}

		this.genericPerform(request, result);

		return result;
	}

}
