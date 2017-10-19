/**
 *
 */
package com.pwc.demo.core.payment;

import de.hybris.platform.payment.commands.request.AuthorizationRequest;
import de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;


/**
 * @author kyao011
 *
 */
public interface AscentCardPaymentService
{
	public AuthorizationResult authorize(AuthorizationRequest request);

	public AuthorizationResult authorize(SubscriptionAuthorizationRequest request);
}
