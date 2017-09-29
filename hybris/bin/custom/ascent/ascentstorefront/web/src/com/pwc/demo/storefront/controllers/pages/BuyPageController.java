/**
 *
 */
package com.pwc.demo.storefront.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * @author swu291 Controller for buy page
 */
@Controller
@RequestMapping(value = "/buy")
public class BuyPageController extends AbstractPageController
{
	private static final String BUY_PAGE = "ascentStoreBuyPage";

	@RequestMapping(method = RequestMethod.GET)
	public String showBuy(final Model model) throws CMSItemNotFoundException
	{
		storeCmsPageInModel(model, getContentPageForLabelOrId(BUY_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(BUY_PAGE));
		return getViewForPage(model);
	}

}
