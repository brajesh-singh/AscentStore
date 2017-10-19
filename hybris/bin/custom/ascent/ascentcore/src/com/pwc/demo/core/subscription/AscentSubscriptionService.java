/**
 *
 */
package com.pwc.demo.core.subscription;

import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import java.util.List;


/**
 * @author kyao011
 *
 */
public interface AscentSubscriptionService
{
	public void createSubscriptions(List<SubscriptionModel> subscriptions);
}
