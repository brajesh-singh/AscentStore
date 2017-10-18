/**
 *
 */
package com.pwc.demo.core.strategies.impl;

import de.hybris.platform.commerceservices.delivery.DeliveryService;
import de.hybris.platform.commerceservices.strategies.impl.DefaultDeliveryModeLookupStrategy;
import de.hybris.platform.core.model.c2l.CurrencyModel;
import de.hybris.platform.core.model.order.AbstractOrderModel;
import de.hybris.platform.core.model.order.delivery.DeliveryModeModel;
import de.hybris.platform.core.model.user.AddressModel;

import java.util.ArrayList;
import java.util.List;

import com.pwc.demo.core.constants.AscentCoreConstants;


/**
 * @author kyao011
 *
 */
public class AscentDeliveryModeLookupStrategy extends DefaultDeliveryModeLookupStrategy
{
	private DeliveryService deliveryService;

	@Override
	public List<DeliveryModeModel> getSelectableDeliveryModesForOrder(final AbstractOrderModel abstractOrderModel)
	{
		if (isPickUpOnlyOrder(abstractOrderModel))
		{
			return new ArrayList<DeliveryModeModel>(
					getPickupDeliveryModeDao().findPickupDeliveryModesForAbstractOrder(abstractOrderModel));
		}
		else
		{
			final List<DeliveryModeModel> deliveryModes = new ArrayList<DeliveryModeModel>();
			DeliveryModeModel defaultDeilvery = new DeliveryModeModel();
			defaultDeilvery = getDeliveryService().getDeliveryModeForCode(AscentCoreConstants.DEFAULT_DELIVERY_CODE);
			final AddressModel deliveryAddress = abstractOrderModel.getDeliveryAddress();
			final CurrencyModel currency = abstractOrderModel.getCurrency();
			if (currency != null && deliveryAddress != null && deliveryAddress.getCountry() != null)
			{
				deliveryModes.addAll(getCountryZoneDeliveryModeDao().findDeliveryModes(abstractOrderModel));
				if (!deliveryModes.contains(defaultDeilvery))
				{
					deliveryModes.add(defaultDeilvery);
				}
				return deliveryModes;
			}
			deliveryModes.add(defaultDeilvery);
			return deliveryModes;
		}
	}

	/**
	 * @return the deliveryService
	 */
	public DeliveryService getDeliveryService()
	{
		return deliveryService;
	}

	/**
	 * @param deliveryService
	 *           the deliveryService to set
	 */
	public void setDeliveryService(final DeliveryService deliveryService)
	{
		this.deliveryService = deliveryService;
	}


}
