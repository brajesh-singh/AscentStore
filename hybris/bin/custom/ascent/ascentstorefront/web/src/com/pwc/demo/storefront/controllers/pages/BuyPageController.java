/**
 *
 */
package com.pwc.demo.storefront.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.acceleratorstorefrontcommons.forms.AddToCartForm;
import de.hybris.platform.commercefacades.order.CartFacade;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * @author swu291 Controller for buy page
 */
@Controller
@Scope("tenant")
public class BuyPageController extends AbstractPageController
{
	private static final String BUY_PAGE = "ascentStoreBuyPage";

	@Resource(name = "cartFacade")
	private CartFacade cartFacade;


	@RequestMapping(value = "/buy/{productCode}", method = RequestMethod.POST, produces = "application/json")
	public String buy(@PathVariable("productCode") final String productCode, final Model model,
			@Valid @ModelAttribute("addToCartForm") final AddToCartForm form,
			final BindingResult bindingErrors, final HttpServletRequest request, final HttpSession session,
			@RequestParam(value = "subProductCode", required = false) final String subProductCode)
	{
		session.setAttribute("cancelUrl", request.getHeader("referer"));

		try
		{
			cartFacade.removeSessionCart();
			if (StringUtils.isNotBlank(subProductCode))
			{
				cartFacade.addToCart(subProductCode, form.getQty());
			}
			else
			{
				cartFacade.addToCart(productCode, form.getQty());
			}
		}
		catch (final CommerceCartModificationException ex)
		{
			ex.printStackTrace();
		}

		return REDIRECT_PREFIX + "/checkout";
	}

}