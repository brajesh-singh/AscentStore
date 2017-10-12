/**
 *
 */
package com.pwc.demo.facades.populators;

import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.subscriptionfacades.data.SubscriptionPricePlanData;
import de.hybris.platform.subscriptionfacades.product.converters.populator.SubscriptionProductPricePlanPopulator;
import de.hybris.platform.subscriptionservices.model.SubscriptionPricePlanModel;


/**
 * @author kyao011
 *
 */
public class AscentSubscriptionProductPricePlanPopulator<SOURCE extends ProductModel, TARGET extends ProductData>
		extends SubscriptionProductPricePlanPopulator<SOURCE, TARGET>
{

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * de.hybris.platform.subscriptionfacades.product.converters.populator.SubscriptionProductPricePlanPopulator#populate
	 * (de.hybris.platform.core.model.product.ProductModel, de.hybris.platform.commercefacades.product.data.ProductData)
	 */
	@Override
	public void populate(final SOURCE source, final TARGET target) throws ConversionException
	{
		if (getSubscriptionProductService().isSubscription(source))
		{
			final SubscriptionPricePlanModel pricePlanModel = getCommercePriceService().getSubscriptionPricePlanForProduct(source);

			if (pricePlanModel != null)
			{
				final SubscriptionPricePlanData pricePlanData = getPricePlanUsageChargeConverter().convert(pricePlanModel);
				pricePlanData.setName(pricePlanModel.getName());
				getPricePlanOneTimeChargePopulator().populate(pricePlanModel, pricePlanData);
				getPricePlanRecurringChargePopulator().populate(pricePlanModel, pricePlanData);
				if (target.getPrice() != null)
				{
					pricePlanData.setCurrencyIso(target.getPrice().getCurrencyIso());
					pricePlanData.setFormattedValue(target.getPrice().getFormattedValue());
					pricePlanData.setPriceType(target.getPrice().getPriceType());
					pricePlanData.setMaxQuantity(target.getPrice().getMaxQuantity());
					pricePlanData.setMinQuantity(target.getPrice().getMinQuantity());
				}
				target.setPrice(pricePlanData);
			}
		}
	}

}
