/**
 *
 */
package com.pwc.demo.storefront.controllers.pages;

import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.AbstractPageController;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.user.UserFacade;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * @author swu291 Controller for download page
 */
@Controller
@RequestMapping(value = "/download")
public class DownloadPageController extends AbstractPageController
{
	private static final String DOWNLOAD_PAGE = "downloadPage";
	private static final String REDIRECT_LOGIN = "redirect:/login";

	@Resource(name = "userFacade")
	private UserFacade userFacade;

	@RequestMapping(method = RequestMethod.GET)
	public String showBuy(final Model model) throws CMSItemNotFoundException
	{

		if (userFacade.isAnonymousUser())
		{
			return REDIRECT_LOGIN;
		}
		storeCmsPageInModel(model, getContentPageForLabelOrId(DOWNLOAD_PAGE));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(DOWNLOAD_PAGE));
		return getViewForPage(model);
	}

}
