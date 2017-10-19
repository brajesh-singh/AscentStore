/**
 *
 */
package com.pwc.demo.core.subscription.impl;

import de.hybris.platform.servicelayer.model.ModelService;
import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import java.util.List;

import com.pwc.demo.core.subscription.AscentSubscriptionService;

/**
 * @author kyao011
 *
 */
public class AscentSubscriptionServiceImpl implements AscentSubscriptionService
{
	private ModelService modelService;
	/* (non-Javadoc)
	 * @see com.pwc.demo.core.subscription.AscentSubscriptionService#createSubscriptions(java.util.List)
	 */
	@Override
	public void createSubscriptions(final List<SubscriptionModel> subscriptions)
	{
		getModelService().saveAll(subscriptions);

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

}
