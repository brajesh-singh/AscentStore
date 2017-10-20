/**
 *
 */
package com.pwc.demo.storefront.controllers.cms;

import de.hybris.platform.commercefacades.product.ProductFacade;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.core.model.product.ProductModel;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pwc.demo.core.model.cms2.components.ProductSpotlightComponentModel;
import com.pwc.demo.storefront.controllers.ControllerConstants;


/**
 * @author dyan019
 *
 */
@Controller("ProductSpotlightComponentController")
@Scope("tenant")
@RequestMapping(value = ControllerConstants.Actions.Cms.ProductSpotlightComponent)
public class ProductSpotlightComponentController extends AbstractAcceleratorCMSComponentController<ProductSpotlightComponentModel>
{

	@Resource(name = "productFacade")
	private ProductFacade productFacade;

	@Override
	protected void fillModel(final HttpServletRequest request, final Model model, final ProductSpotlightComponentModel component)
	{
		final List<ProductData> spotlightProductList = new ArrayList<ProductData>();

		if (component.getSpotlightProducts() != null)
		{
			for (final ProductModel product : component.getSpotlightProducts())
			{
				final ProductData data = productFacade.getProductForCodeAndOptions(product.getCode(),
						Arrays.asList(ProductOption.BASIC, ProductOption.PRICE));

				spotlightProductList.add(data);
			}
		}

		model.addAttribute("spotlightProductList", spotlightProductList);

	}

}
