/**
 *
 */
package com.pwc.demo.facades.product.impl;

import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commercefacades.product.impl.DefaultProductFacade;
import de.hybris.platform.core.model.product.ProductModel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.pwc.demo.core.services.product.AscentProductService;
import com.pwc.demo.facades.product.AscentProductFacade;

/**
 * @author kyao011
 *
 */
public class AscentProductFacadeImpl extends DefaultProductFacade implements AscentProductFacade
{
	private AscentProductService productService;

	/* (non-Javadoc)
	 * @see com.pwc.demo.facades.product.AscentProductFacade#getSubscriptionProducts(de.hybris.platform.core.model.product.ProductModel)
	 */
	@Override
	public List<ProductData> getSubscriptionProducts(final ProductModel productModel)
	{

		final List<ProductData> products = new ArrayList<ProductData>();
		getProductService().getSubscriptionProductModels(productModel, new ArrayList<ProductModel>())
				.forEach(subProductModel -> buildProductData(subProductModel, products));


		return products;
	}

	void buildProductData(final ProductModel subProductModel, final List<ProductData> products)
	{
		final List<ProductOption> options = new ArrayList<>(
				Arrays.asList(ProductOption.BASIC, ProductOption.PRICE, ProductOption.SUMMARY, ProductOption.DESCRIPTION,
						ProductOption.GALLERY,
				ProductOption.REVIEW, ProductOption.STOCK));

		final ProductData productData = (ProductData) getProductConverter().convert(subProductModel);
		getProductConfiguredPopulator().populate(subProductModel,
				productData, options);
		products.add(productData);
	}


	/**
	 * @return the productService
	 */
	@Override
	public AscentProductService getProductService()
	{
		return productService;
	}

	/**
	 * @param productService
	 *           the productService to set
	 */
	public void setProductService(final AscentProductService productService)
	{
		this.productService = productService;
	}

}
