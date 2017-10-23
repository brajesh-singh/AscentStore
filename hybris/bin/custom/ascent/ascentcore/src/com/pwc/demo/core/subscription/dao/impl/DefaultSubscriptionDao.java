/**
 *
 */
package com.pwc.demo.core.subscription.dao.impl;

import de.hybris.platform.servicelayer.exceptions.ModelNotFoundException;
import de.hybris.platform.servicelayer.internal.dao.AbstractItemDao;
import de.hybris.platform.servicelayer.search.FlexibleSearchQuery;
import de.hybris.platform.servicelayer.util.ServicesUtil;
import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import javax.annotation.Nonnull;

import com.pwc.demo.core.subscription.dao.SubscriptionDao;


/**
 *
 */
public class DefaultSubscriptionDao extends AbstractItemDao implements SubscriptionDao
{
	private static final String GET_SUBSCRIPTION_BY_ID = "SELECT {pk} FROM {Subscription} where {id} = ?uid";

	/*
	 * (non-Javadoc)
	 *
	 * @see de.hybris.ascent.services.subscription.dao.SubscriptioinDao#getSubscriptionById(java.lang.String)
	 */
	@Override
	@Nonnull
	public SubscriptionModel getSubscriptionById(final String subscriptionId)
	{
		// YTODO Auto-generated method stub
		ServicesUtil.validateParameterNotNullStandardMessage("subscriptionId", subscriptionId);
		final FlexibleSearchQuery query = new FlexibleSearchQuery(GET_SUBSCRIPTION_BY_ID);
		query.addQueryParameter("uid", subscriptionId);
		SubscriptionModel subscriptionModel = null;
		try
		{
			subscriptionModel = (SubscriptionModel) searchUnique(query);
		}
		catch (final ModelNotFoundException e)
		{
			e.printStackTrace();
		}
		return subscriptionModel;
	}

}
