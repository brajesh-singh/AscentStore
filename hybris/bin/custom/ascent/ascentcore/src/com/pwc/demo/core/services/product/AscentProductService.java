/**
 *
 */
package com.pwc.demo.core.services.product;

import de.hybris.platform.core.model.product.ProductModel;
import de.hybris.platform.product.ProductService;

import java.util.List;


/**
 * @author kyao011
 *
 */
public interface AscentProductService extends ProductService
{

	List<ProductModel> getSubscriptionProductModels(ProductModel productModel, final List<ProductModel> subProducts);

}
