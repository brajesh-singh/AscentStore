/**
 *
 */
package com.pwc.demo.core.payment.commands.impl;

import de.hybris.platform.payment.commands.impl.GenericMockCommand;
import de.hybris.platform.payment.commands.request.AuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;
import de.hybris.platform.payment.dto.AvsStatus;
import de.hybris.platform.payment.dto.CvnStatus;
import de.hybris.platform.payment.dto.TransactionStatus;
import de.hybris.platform.payment.dto.TransactionStatusDetails;

import java.util.Calendar;
import java.util.Date;

import com.pwc.demo.core.payment.commands.AscentAuthorizationCommand;

/**
 * @author kyao011
 *
 */
public class AscentAuthorizationMockCommand extends GenericMockCommand implements AscentAuthorizationCommand
{

	@Override
	public AuthorizationResult perform(final AuthorizationRequest request)
	{
		final AuthorizationResult result = new AuthorizationResult();


		result.setCurrency(request.getCurrency());
		result.setTotalAmount(request.getTotalAmount());

		result.setAvsStatus(AvsStatus.NO_RESULT);
		result.setCvnStatus(CvnStatus.NOT_PROCESSED);

		result.setAuthorizationTime(new Date());


		final Calendar today = Calendar.getInstance();
		if (today.get(1) > request.getCard().getExpirationYear().intValue())
		{

			result.setTransactionStatus(TransactionStatus.REJECTED);
			result.setTransactionStatusDetails(TransactionStatusDetails.INVALID_CARD_EXPIRATION_DATE);

		}
		else if (today.get(1) == request.getCard().getExpirationYear().intValue()
				&& today.get(2) > request.getCard().getExpirationMonth().intValue())
		{


			result.setTransactionStatus(TransactionStatus.REJECTED);
			result.setTransactionStatusDetails(TransactionStatusDetails.INVALID_CARD_EXPIRATION_DATE);

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
