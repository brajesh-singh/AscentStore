/**
 *
 */
package com.pwc.demo.core.delivery.impl;

import static de.hybris.platform.servicelayer.util.ServicesUtil.validateParameterNotNull;

import de.hybris.platform.commerceservices.delivery.impl.DefaultDeliveryService;
import de.hybris.platform.core.model.order.AbstractOrderModel;
import de.hybris.platform.core.model.order.delivery.DeliveryModeModel;
import de.hybris.platform.jalo.order.AbstractOrder;
import de.hybris.platform.jalo.order.delivery.DeliveryMode;
import de.hybris.platform.jalo.order.delivery.JaloDeliveryModeException;
import de.hybris.platform.util.PriceValue;

/**
 * @author kyao011
 *
 */
public class AscentDeliveryService extends DefaultDeliveryService
{

	@Override
	public PriceValue getDeliveryCostForDeliveryModeAndAbstractOrder(final DeliveryModeModel deliveryMode,
			final AbstractOrderModel abstractOrder)
	{
		validateParameterNotNull(deliveryMode, "deliveryMode model cannot be null");
		validateParameterNotNull(abstractOrder, "abstractOrder model cannot be null");

		final DeliveryMode deliveryModeSource = getModelService().getSource(deliveryMode);
		try
		{
			final AbstractOrder abstractOrderSource = getModelService().getSource(abstractOrder);
			return deliveryModeSource.getCost(abstractOrderSource);
		}
		catch (final JaloDeliveryModeException e)
		{
			return new PriceValue(abstractOrder.getCurrency().getIsocode(), 0.00d, true);
		}

	}
}
