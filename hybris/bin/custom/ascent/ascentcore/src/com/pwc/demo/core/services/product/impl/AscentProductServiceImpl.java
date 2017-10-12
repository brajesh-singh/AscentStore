/**
 *
 */
package com.pwc.demo.core.services.product.impl;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.product.impl.DefaultProductService;
import de.hybris.platform.subscriptionservices.model.SubscriptionProductModel;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.util.Assert;

import com.pwc.demo.core.services.product.AscentProductService;

/**
 * @author kyao011
 *
 */
public class AscentProductServiceImpl extends DefaultProductService implements AscentProductService
{

	/* (non-Javadoc)
	 * @see com.pwc.demo.core.services.product.AscentProductService#getSubscriptionProductModels(de.hybris.platform.core.model.product.ProductModel)
	 */
	@Override
	public List<ProductModel> getSubscriptionProductModels(final ProductModel productModel, final List<ProductModel> subProducts)
	{
		Assert.notNull(productModel);
		Assert.notNull(productModel.getBundleTemplates());

		productModel.getBundleTemplates().forEach(bundleTemplate->{
			bundleTemplate.getParentTemplate().getChildTemplates().forEach(products -> {
						subProducts.addAll(products.getProducts().stream()
						.filter(product -> product instanceof SubscriptionProductModel && !product.equals(productModel))
						.collect(Collectors.toList()));
					});
		});

		return subProducts;
	}



}
