/**
 *
 */
package com.pwc.demo.facades.product;

import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.model.product.ProductModel;

import java.util.List;


/**
 * @author kyao011
 *
 */
public interface AscentProductFacade extends ProductFacade
{

	List<ProductData> getSubscriptionProducts(ProductModel productModel);

}
