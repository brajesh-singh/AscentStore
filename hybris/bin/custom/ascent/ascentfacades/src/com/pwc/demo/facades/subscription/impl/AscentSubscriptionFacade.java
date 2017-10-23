/**
 *
 */
package com.pwc.demo.facades.subscription.impl;

import de.hybris.platform.commercefacades.order.OrderFacade;
import de.hybris.platform.commercefacades.order.data.OrderData;
import de.hybris.platform.commercefacades.order.data.OrderEntryData;
import de.hybris.platform.commercefacades.order.data.OrderHistoryData;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.enums.OrderStatus;
import de.hybris.platform.core.model.order.OrderModel;
import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.product.ProductService;
import de.hybris.platform.servicelayer.dto.converter.Converter;
import de.hybris.platform.store.BaseStoreModel;
import de.hybris.platform.subscriptionfacades.data.OrderEntryPriceData;
import de.hybris.platform.subscriptionfacades.data.SubscriptionData;
import de.hybris.platform.subscriptionfacades.data.SubscriptionPaymentData;
import de.hybris.platform.subscriptionfacades.data.TermOfServiceFrequencyData;
import de.hybris.platform.subscriptionfacades.data.TermOfServiceRenewalData;
import de.hybris.platform.subscriptionfacades.exceptions.SubscriptionFacadeException;
import de.hybris.platform.subscriptionfacades.impl.DefaultSubscriptionFacade;
import de.hybris.platform.subscriptionservices.enums.TermOfServiceFrequency;
import de.hybris.platform.subscriptionservices.enums.TermOfServiceRenewal;
import de.hybris.platform.subscriptionservices.model.SubscriptionModel;
import de.hybris.platform.subscriptionservices.model.SubscriptionProductModel;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Nonnull;

import org.apache.log4j.Logger;

import com.pwc.demo.core.constants.AscentCoreConstants;
import com.pwc.demo.core.subscription.AscentSubscriptionService;


/**
 * @author kyao011
 *
 */
public class AscentSubscriptionFacade extends DefaultSubscriptionFacade
{
	private static final Logger LOG = Logger.getLogger(AscentSubscriptionFacade.class);
	private OrderFacade orderFacade;
	private AscentSubscriptionService subscriptionService;
	private ProductService productService;
	private Converter<SubscriptionModel, SubscriptionData> subscriptionConverter;
	private Converter<TermOfServiceRenewal, TermOfServiceRenewalData> termOfServiceRenewalConverter;
	private Converter<TermOfServiceFrequency, TermOfServiceFrequencyData> termOfServiceFrequencyConverter;

	@Override
	public SubscriptionPaymentData createSubscriptions(@Nonnull final OrderData order, final Map<String, String> parameters)
			throws SubscriptionFacadeException
	{
		final List<SubscriptionModel> subscriptions = new ArrayList<>();

		for (final OrderEntryData entry : order.getEntries())
		{
			final ProductData productData = entry.getProduct();
			final ProductModel productModel = productService.getProductForCode(productData.getCode());
			if (productModel instanceof SubscriptionProductModel)
			{
				final SubscriptionModel subscription = new SubscriptionModel();

				subscription.setBillingFrequency(((SubscriptionProductModel) productModel).getSubscriptionTerm().getBillingPlan()
						.getBillingFrequency().getCode());
				subscription.setCancellable(((SubscriptionProductModel) productModel).getSubscriptionTerm().getCancellable());
				subscription
						.setContractDuration(((SubscriptionProductModel) productModel).getSubscriptionTerm().getTermOfServiceNumber());


				final TermOfServiceFrequencyData termOfServiceFrequencyData = getTermOfServiceFrequencyConverter()
						.convert(((SubscriptionProductModel) productModel).getSubscriptionTerm().getTermOfServiceFrequency());
				subscription.setContractFrequency(termOfServiceFrequencyData.getName());

				subscription.setDescription(productModel.getDescription());

				subscription.setEndDate(getSubscriptionEndDate(productData, order.getCreated()));

				subscription.setEndDate(getSubscriptionEndDate(productData, order.getCreated()));

				subscription.setId(order.getCode() + entry.getEntryNumber());
				subscription.setName(productModel.getName());
				subscription.setOrderEntryNumber(entry.getEntryNumber());
				subscription.setOrderNumber(order.getCode());
				subscription.setPlacedOn(order.getCreated());
				subscription.setProductCode(productModel.getCode());

				final TermOfServiceRenewalData termOfServiceRenewalData = getTermOfServiceRenewalConverter()
						.convert(((SubscriptionProductModel) productModel).getSubscriptionTerm().getTermOfServiceRenewal());

				subscription.setRenewalType(termOfServiceRenewalData.getName());
				subscription.setStartDate(order.getCreated());

				final Date currentDate = new Date();

				if (currentDate.after(subscription.getEndDate()))
				{
					subscription.setSubscriptionStatus(AscentCoreConstants.SUBSCRIPTION_PRODUCT_STATUS_INVALID);
				}
				else
				{
					subscription.setSubscriptionStatus(AscentCoreConstants.SUBSCRIPTION_PRODUCT_STATUS_VALID);
				}

				subscription.setQuantity(entry.getQuantity());

				final BaseStoreModel baseStoreModel = getBaseStoreService().getCurrentBaseStore();
				final OrderModel orderModel = getCustomerAccountService().getOrderForCode(order.getCode(), baseStoreModel);

				subscription.setCurrency(orderModel.getCurrency());

				for (final OrderEntryPriceData orderEntryPrice : entry.getOrderEntryPrices())
				{
					if (orderEntryPrice.getTotalPrice().getValue().doubleValue() > 0)
					{
						subscription.setTotalPrice(Double.valueOf(orderEntryPrice.getTotalPrice().getValue().doubleValue()));
					}
				}

				subscriptions.add(subscription);
			}
		}
		getSubscriptionService().createSubscriptions(subscriptions);
		return null;
	}

	@Override
	@Nonnull
	public Collection<SubscriptionData> getSubscriptions() throws SubscriptionFacadeException
	{
		// YTODO Auto-generated method stub
		final ArrayList<SubscriptionData> subscriptions = new ArrayList<>();
		//
		final List<OrderHistoryData> orderHistories = getOrderFacade().getOrderHistoryForStatuses(OrderStatus.APPROVED,
				OrderStatus.COMPLETED, OrderStatus.ASSIGNED_TO_ADMIN);
		//
		for (final OrderHistoryData orderHistory : orderHistories)
		{
			final OrderData order = orderFacade.getOrderDetailsForCode(orderHistory.getCode());
			for (final OrderEntryData entry : order.getEntries())
			{
				final ProductData productData = entry.getProduct();
				final ProductModel productModel = getProductService().getProductForCode(productData.getCode());
				if (productModel instanceof SubscriptionProductModel)
				{
					final String subscriptionId = order.getCode() + entry.getEntryNumber();

					final SubscriptionData subscription = getSubscription(subscriptionId);

					if (subscription != null)
					{
						subscriptions.add(subscription);
					}
				}
			}
		}
		return subscriptions;
	}

	@Override
	public SubscriptionData getSubscription(final String subscriptionId) throws SubscriptionFacadeException
	{
		LOG.info("Get Subscriptions");
		// YTODO Auto-generated method stub
		final SubscriptionModel subscriptionModel = getSubscriptionService().getSubscription(subscriptionId);
		if (subscriptionModel != null)
		{
			final SubscriptionData subscriptionData = getSubscriptionConverter().convert(subscriptionModel);

			return subscriptionData;
		}
		else
		{
			return null;
		}
	}

	/**
	 * @return the subscriptionService
	 */
	public AscentSubscriptionService getSubscriptionService()
	{
		return subscriptionService;
	}



	/**
	 * @param subscriptionService
	 *           the subscriptionService to set
	 */
	public void setSubscriptionService(final AscentSubscriptionService subscriptionService)
	{
		this.subscriptionService = subscriptionService;
	}



	/**
	 * @return the productService
	 */
	public ProductService getProductService()
	{
		return productService;
	}

	/**
	 * @param productService
	 *           the productService to set
	 */
	public void setProductService(final ProductService productService)
	{
		this.productService = productService;
	}

	/**
	 * @return the termOfServiceRenewalConverter
	 */
	public Converter<TermOfServiceRenewal, TermOfServiceRenewalData> getTermOfServiceRenewalConverter()
	{
		return termOfServiceRenewalConverter;
	}

	/**
	 * @param termOfServiceRenewalConverter
	 *           the termOfServiceRenewalConverter to set
	 */
	public void setTermOfServiceRenewalConverter(
			final Converter<TermOfServiceRenewal, TermOfServiceRenewalData> termOfServiceRenewalConverter)
	{
		this.termOfServiceRenewalConverter = termOfServiceRenewalConverter;
	}

	/**
	 * @return the termOfServiceFrequencyConverter
	 */
	public Converter<TermOfServiceFrequency, TermOfServiceFrequencyData> getTermOfServiceFrequencyConverter()
	{
		return termOfServiceFrequencyConverter;
	}

	/**
	 * @param termOfServiceFrequencyConverter
	 *           the termOfServiceFrequencyConverter to set
	 */
	public void setTermOfServiceFrequencyConverter(
			final Converter<TermOfServiceFrequency, TermOfServiceFrequencyData> termOfServiceFrequencyConverter)
	{
		this.termOfServiceFrequencyConverter = termOfServiceFrequencyConverter;
	}

	/**
	 * @return the orderFacade
	 */
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
	 * @return the subscriptionConverter
	 */
	public Converter<SubscriptionModel, SubscriptionData> getSubscriptionConverter()
	{
		return subscriptionConverter;
	}

	/**
	 * @param subscriptionConverter
	 *           the subscriptionConverter to set
	 */
	public void setSubscriptionConverter(final Converter<SubscriptionModel, SubscriptionData> subscriptionConverter)
	{
		this.subscriptionConverter = subscriptionConverter;
	}


}
