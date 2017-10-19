/**
 *
 */
package com.pwc.demo.core.payment.commands;

import de.hybris.platform.payment.commands.Command;
import de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;

/**
 * @author kyao011
 *
 */
public interface AscentSubscriptionAuthorizationCommand extends Command<SubscriptionAuthorizationRequest, AuthorizationResult>
{//
}
