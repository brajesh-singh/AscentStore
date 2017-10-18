/**
 *
 */
package com.pwc.demo.facades.order.impl;

import de.hybris.platform.b2bacceleratorfacades.order.impl.DefaultB2BAcceleratorCheckoutFacade;
import de.hybris.platform.commerceservices.service.data.CommerceCheckoutParameter;
import de.hybris.platform.core.model.order.CartModel;
import de.hybris.platform.core.model.order.delivery.DeliveryModeModel;

import com.pwc.demo.core.constants.AscentCoreConstants;
import com.pwc.demo.facades.order.AscentCheckoutFacade;

/**
 * @author kyao011
 *
 */
public class AscentCheckoutFacadeImpl extends DefaultB2BAcceleratorCheckoutFacade implements AscentCheckoutFacade
{
	/*
	 * (non-Javadoc)default
	 *
	 * @see com.pwc.demo.facades.order.AscentCheckoutFacade#setDefaultDeliveryMode()
	 */
	@Override
	public boolean setDefaultDeliveryMode()
	{

		final CartModel cartModel = getCart();
		if (cartModel != null && null == cartModel.getDeliveryMode())
		{
			final DeliveryModeModel deliveryModeModel = getDeliveryService()
					.getDeliveryModeForCode(AscentCoreConstants.DEFAULT_DELIVERY_CODE);
			if (deliveryModeModel != null)
			{
				final CommerceCheckoutParameter parameter = createCommerceCheckoutParameter(cartModel, true);
				parameter.setDeliveryMode(deliveryModeModel);
				return getCommerceCheckoutService().setDeliveryMode(parameter);
			}
		}
		return false;
	}

}
