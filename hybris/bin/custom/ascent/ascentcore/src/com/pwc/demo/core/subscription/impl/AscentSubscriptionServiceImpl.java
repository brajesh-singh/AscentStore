/**
 *
 */
package com.pwc.demo.core.subscription.impl;

import de.hybris.platform.servicelayer.model.ModelService;
import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import java.util.List;

import com.pwc.demo.core.subscription.AscentSubscriptionService;
import com.pwc.demo.core.subscription.dao.SubscriptionDao;


/**
 * @author kyao011
 *
 */
public class AscentSubscriptionServiceImpl implements AscentSubscriptionService
{
	private ModelService modelService;
	private SubscriptionDao subscriptionDao;

	/*
	 * (non-Javadoc)
	 *
	 * @see com.pwc.demo.core.subscription.AscentSubscriptionService#createSubscriptions(java.util.List)
	 */
	@Override
	public void createSubscriptions(final List<SubscriptionModel> subscriptions)
	{
		getModelService().saveAll(subscriptions);

	}

	/*
	 * (non-Javadoc)
	 *
	 * @see de.hybris.ascent.services.subscription.SubscriptionService#getSubscription(java.lang.String)
	 */
	@Override
	public SubscriptionModel getSubscription(final String subscriptionId)
	{
		return getSubscriptionDao().getSubscriptionById(subscriptionId);

	}

	/**
	 * @return the modelService
	 */
	public ModelService getModelService()
	{
		return modelService;
	}

	/**
	 * @param modelService
	 *           the modelService to set
	 */
	public void setModelService(final ModelService modelService)
	{
		this.modelService = modelService;
	}

	/**
	 * @return the subscriptionDao
	 */
	public SubscriptionDao getSubscriptionDao()
	{
		return subscriptionDao;
	}

	/**
	 * @param subscriptionDao
	 *           the subscriptionDao to set
	 */
	public void setSubscriptionDao(final SubscriptionDao subscriptionDao)
	{
		this.subscriptionDao = subscriptionDao;
	}

}
