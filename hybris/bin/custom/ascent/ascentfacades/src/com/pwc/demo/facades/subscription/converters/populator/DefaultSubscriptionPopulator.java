package com.pwc.demo.facades.subscription.converters.populator;

import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;
import de.hybris.platform.commercefacades.order.OrderFacade;
import de.hybris.platform.commercefacades.order.data.OrderData;
import de.hybris.platform.commercefacades.product.PriceDataFactory;
import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.converters.Populator;
import de.hybris.platform.servicelayer.dto.converter.ConversionException;
import de.hybris.platform.subscriptionfacades.data.SubscriptionData;
import de.hybris.platform.subscriptionservices.model.SubscriptionModel;

import org.springframework.beans.factory.annotation.Required;


public class DefaultSubscriptionPopulator implements Populator<SubscriptionModel, SubscriptionData>
{
	private ProductFacade productFacade;
	private OrderFacade orderFacade;
	private PriceDataFactory priceDataFactory;

	/*
	 * (non-Javadoc)
	 *
	 * @see de.hybris.platform.converters.Populator#populate(java.lang.Object, java.lang.Object)
	 */
	@Override
	public void populate(final SubscriptionModel source, final SubscriptionData target) throws ConversionException
	{
		target.setBillingFrequency(source.getBillingFrequency());
		target.setCancellable(source.getCancellable());
		target.setCancelledDate(source.getCancelledDate());
		target.setContractDuration(source.getContractDuration());
		target.setContractFrequency(source.getContractFrequency());
		target.setDescription(source.getDescription());
		target.setEndDate(source.getEndDate());
		target.setId(source.getId());
		target.setName(source.getName());
		target.setOrderEntryNumber(source.getOrderEntryNumber());
		target.setOrderNumber(source.getOrderNumber());
		//		target.setQuantity(source.getQuantity());

		final OrderData orderData = getOrderFacade().getOrderDetailsForCode(target.getOrderNumber());
		if (orderData.getPaymentType().getCode().equals(CheckoutPaymentType.ACCOUNT.getCode()))
		{
			target.setPaymentMethodId(orderData.getCostCenter().getName());
		}
		else
		{
			target.setPaymentMethodId(orderData.getPaymentInfo().getSubscriptionId());
		}

		target.setPlacedOn(source.getPlacedOn());
		target.setProductCode(source.getProductCode());

		final ProductData productData = getProductFacade().getProductForCodeAndOptions(target.getProductCode(), null);
		target.setProductUrl(productData.getUrl());

		target.setRenewalType(source.getRenewalType());
		target.setStartDate(source.getStartDate());
		target.setSubscriptionStatus(source.getSubscriptionStatus());

		//		final PriceData totalPrice = getPriceDataFactory().create(PriceDataType.BUY,
		//				BigDecimal.valueOf(source.getTotalPrice().doubleValue()), source.getCurrency());
		//		target.setTotalPrice(totalPrice);
	}

	/**
	 * @return the productFacade
	 */
	public ProductFacade getProductFacade()
	{
		return productFacade;
	}

	/**
	 * @param productFacade
	 *           the productFacade to set
	 */
	@Required
	public void setProductFacade(final ProductFacade productFacade)
	{
		this.productFacade = productFacade;
	}

	/**
	 * @return the orderFacade
	 */
	@Required
	public OrderFacade getOrderFacade()
	{
		return orderFacade;
	}

	/**
	 * @param orderFacade
	 *           the orderFacade to set
	 */
	public void setOrderFacade(final OrderFacade orderFacade)
	{
		this.orderFacade = orderFacade;
	}

	/**
	 * @return the priceDataFactory
	 */
	public PriceDataFactory getPriceDataFactory()
	{
		return priceDataFactory;
	}

	/**
	 * @param priceDataFactory
	 *           the priceDataFactory to set
	 */
	@Required
	public void setPriceDataFactory(final PriceDataFactory priceDataFactory)
	{
		this.priceDataFactory = priceDataFactory;
	}
}