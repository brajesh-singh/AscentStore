/**
 *
 */
package com.pwc.demo.core.subscription.impl;

import de.hybris.platform.commerceservices.order.CommerceCartModificationException;
import de.hybris.platform.subscriptionservices.subscription.impl.DefaultSubscriptionCommerceCartService;

/**
 * @author kyao011
 *
 */
public class AscentSubscriptionCommerceCartServiceImpl extends DefaultSubscriptionCommerceCartService
{

	@Override
	protected void checkQuantityToAdd(final long quantityToAdd, final long maxQuantity) throws CommerceCartModificationException
	{
		if (quantityToAdd <1)
		{
			throw new CommerceCartModificationException("The given quantityToAdd (" + quantityToAdd
					+ ") below the min. allowed quantity (" + maxQuantity + ")");
		}
	}
}
