/**
 *
 */
package com.pwc.demo.core.subscription.dao;

import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import javax.annotation.Nonnull;


/**
 *
 */
public interface SubscriptionDao
{
	@Nonnull
	public abstract SubscriptionModel getSubscriptionById(String subscripionId);
}
