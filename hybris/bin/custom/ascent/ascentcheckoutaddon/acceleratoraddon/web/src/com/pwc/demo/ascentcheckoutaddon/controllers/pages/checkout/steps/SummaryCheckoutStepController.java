/**
 *
 */
package com.pwc.demo.ascentcheckoutaddon.controllers.pages.checkout.steps;

import de.hybris.platform.acceleratorservices.enums.CheckoutPciOptionEnum;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.PreValidateCheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.PreValidateQuoteCheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.annotations.RequireHardLogIn;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.CheckoutStep;
import de.hybris.platform.acceleratorstorefrontcommons.constants.WebConstants;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.pages.checkout.steps.AbstractCheckoutStepController;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.b2bacceleratoraddon.forms.PlaceOrderForm;
import de.hybris.platform.b2bacceleratorfacades.api.cart.CheckoutFacade;
import de.hybris.platform.b2bacceleratorfacades.checkout.data.PlaceOrderData;
import de.hybris.platform.b2bacceleratorfacades.exception.EntityValidationException;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.commercefacades.order.data.CartData;
import de.hybris.platform.commercefacades.order.data.OrderData;
import de.hybris.platform.commercefacades.order.data.OrderEntryData;
import de.hybris.platform.commercefacades.product.ProductOption;
import de.hybris.platform.commercefacades.product.data.ProductData;
import de.hybris.platform.commerceservices.order.CommerceCartModificationException;
import de.hybris.platform.order.InvalidCartException;
import de.hybris.platform.payment.AdapterException;

import java.util.Arrays;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pwc.demo.ascentcheckoutaddon.controllers.AscentcheckoutaddonControllerConstants;


/**
 * @author kyao011
 *
 */
@Controller
@RequestMapping(value = "/checkout/multi/summary")
public class SummaryCheckoutStepController extends AbstractCheckoutStepController
{
	private static final Logger LOGGER = Logger.getLogger(SummaryCheckoutStepController.class);

	private static final String SUMMARY = "summary";

	@Resource(name = "b2bCheckoutFacade")
	private CheckoutFacade ascentB2BCheckoutFacade;


	@RequestMapping(value = "/view", method = RequestMethod.GET)
	@RequireHardLogIn
	@Override
	@PreValidateQuoteCheckoutStep
	@PreValidateCheckoutStep(checkoutStep = SUMMARY)
	public String enterStep(final Model model, final RedirectAttributes redirectAttributes) throws CMSItemNotFoundException, // NOSONAR
			CommerceCartModificationException
	{
		final CartData cartData = getCheckoutFacade().getCheckoutCart();
		if (cartData.getEntries() != null && !cartData.getEntries().isEmpty())
		{
			for (final OrderEntryData entry : cartData.getEntries())
			{
				final String productCode = entry.getProduct().getCode();
				final ProductData product = getProductFacade().getProductForCodeAndOptions(productCode, Arrays.asList(
						ProductOption.BASIC, ProductOption.PRICE, ProductOption.VARIANT_MATRIX_BASE, ProductOption.PRICE_RANGE));
				entry.setProduct(product);
			}
		}

		model.addAttribute("cartData", cartData);
		model.addAttribute("allItems", cartData.getEntries());
		model.addAttribute("deliveryAddress", cartData.getDeliveryAddress());
		model.addAttribute("deliveryMode", cartData.getDeliveryMode());
		model.addAttribute("paymentInfo", cartData.getPaymentInfo());

		// Only request the security code if the SubscriptionPciOption is set to Default.
		final boolean requestSecurityCode = CheckoutPciOptionEnum.DEFAULT
				.equals(getCheckoutFlowFacade().getSubscriptionPciOption());
		model.addAttribute("requestSecurityCode", Boolean.valueOf(requestSecurityCode));

		model.addAttribute(new PlaceOrderForm());

		storeCmsPageInModel(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		setUpMetaDataForContentPage(model, getContentPageForLabelOrId(MULTI_CHECKOUT_SUMMARY_CMS_PAGE_LABEL));
		model.addAttribute(WebConstants.BREADCRUMBS_KEY,
				getResourceBreadcrumbBuilder().getBreadcrumbs("checkout.multi.summary.breadcrumb"));
		model.addAttribute("metaRobots", "noindex,nofollow");
		setCheckoutStepLinksForModel(model, getCheckoutStep());
		return AscentcheckoutaddonControllerConstants.Views.Pages.MultiStepCheckout.CheckoutSummaryPage;
	}


	@RequestMapping(value = "/placeOrder")
	@PreValidateQuoteCheckoutStep
	@RequireHardLogIn
	public String placeOrder(@ModelAttribute("placeOrderForm") final PlaceOrderForm placeOrderForm, final Model model,
			final RedirectAttributes redirectModel)
			throws CMSItemNotFoundException, InvalidCartException, CommerceCartModificationException
	{
		if (validateOrderForm(placeOrderForm, model))
		{
			return enterStep(model, redirectModel);
		}

		// authorize, if failure occurs don't allow to place the order
		boolean isPaymentAuthorized = false;
		try
		{
			isPaymentAuthorized = getCheckoutFacade().authorizePayment(placeOrderForm.getSecurityCode());
		}
		catch (final AdapterException ae)
		{
			// handle a case where a wrong paymentProvider configurations on the store see getCommerceCheckoutService().getPaymentProvider()
			LOGGER.error(ae.getMessage(), ae);
		}
		if (!isPaymentAuthorized)
		{
			GlobalMessages.addErrorMessage(model, "checkout.error.authorization.failed");
			return enterStep(model, redirectModel);
		}

		final PlaceOrderData placeOrderData = new PlaceOrderData();
		placeOrderData.setNDays(placeOrderForm.getnDays());
		placeOrderData.setNDaysOfWeek(placeOrderForm.getnDaysOfWeek());
		placeOrderData.setNthDayOfMonth(placeOrderForm.getNthDayOfMonth());
		placeOrderData.setNWeeks(placeOrderForm.getnWeeks());
		placeOrderData.setReplenishmentOrder(Boolean.valueOf(placeOrderForm.isReplenishmentOrder()));
		placeOrderData.setReplenishmentRecurrence(placeOrderForm.getReplenishmentRecurrence());
		placeOrderData.setReplenishmentStartDate(placeOrderForm.getReplenishmentStartDate());
		placeOrderData.setSecurityCode(placeOrderForm.getSecurityCode());
		placeOrderData.setTermsCheck(Boolean.valueOf(placeOrderForm.isTermsCheck()));

		final OrderData orderData;
		try
		{
			orderData = getAscentB2BCheckoutFacade().placeOrder(placeOrderData);
		}
		catch (final EntityValidationException e)
		{
			LOGGER.error("Failed to place Order", e);
			GlobalMessages.addErrorMessage(model, e.getLocalizedMessage());

			placeOrderForm.setTermsCheck(false);
			model.addAttribute(placeOrderForm);

			return enterStep(model, redirectModel);
		}
		catch (final Exception e)
		{
			LOGGER.error("Failed to place Order", e);
			GlobalMessages.addErrorMessage(model, "checkout.placeOrder.failed");
			return enterStep(model, redirectModel);
		}

		return redirectToOrderConfirmationPage(orderData);
	}


	/**
	 * Validates the order form before to filter out invalid order states
	 *
	 * @param placeOrderForm
	 *           The spring form of the order being submitted
	 * @param model
	 *           A spring Model
	 * @return True if the order form is invalid and false if everything is valid.
	 */
	protected boolean validateOrderForm(final PlaceOrderForm placeOrderForm, final Model model)
	{
		final String securityCode = placeOrderForm.getSecurityCode();
		boolean invalid = false;

		if (getCheckoutFlowFacade().hasNoDeliveryMode())
		{
			GlobalMessages.addErrorMessage(model, "checkout.deliveryMethod.notSelected");
			invalid = true;
		}

		if (getCheckoutFlowFacade().hasNoPaymentInfo())
		{
			GlobalMessages.addErrorMessage(model, "checkout.paymentMethod.notSelected");
			invalid = true;
		}
		else
		{
			// Only require the Security Code to be entered on the summary page if the SubscriptionPciOption is set to Default.
			if (CheckoutPciOptionEnum.DEFAULT.equals(getCheckoutFlowFacade().getSubscriptionPciOption())
					&& StringUtils.isBlank(securityCode))
			{
				GlobalMessages.addErrorMessage(model, "checkout.paymentMethod.noSecurityCode");
				invalid = true;
			}
		}

		if (!placeOrderForm.isTermsCheck())
		{
			GlobalMessages.addErrorMessage(model, "checkout.error.terms.not.accepted");
			invalid = true;
			return invalid;
		}
		final CartData cartData = getCheckoutFacade().getCheckoutCart();

		if (!getCheckoutFacade().containsTaxValues())
		{
			LOGGER.error(String.format(
					"Cart %s does not have any tax values, which means the tax cacluation was not properly done, placement of order can't continue",
					cartData.getCode()));
			GlobalMessages.addErrorMessage(model, "checkout.error.tax.missing");
			invalid = true;
		}

		if (!cartData.isCalculated())
		{
			LOGGER.error(
					String.format("Cart %s has a calculated flag of FALSE, placement of order can't continue", cartData.getCode()));
			GlobalMessages.addErrorMessage(model, "checkout.error.cart.notcalculated");
			invalid = true;
		}

		return invalid;
	}

	@RequestMapping(value = "/back", method = RequestMethod.GET)
	@RequireHardLogIn
	@Override
	public String back(final RedirectAttributes redirectAttributes)
	{
		return getCheckoutStep().previousStep();
	}

	@RequestMapping(value = "/next", method = RequestMethod.GET)
	@RequireHardLogIn
	@Override
	public String next(final RedirectAttributes redirectAttributes)
	{
		return getCheckoutStep().nextStep();
	}

	protected CheckoutStep getCheckoutStep()
	{
		return getCheckoutStep(SUMMARY);
	}


	/**
	 * @return the ascentB2BCheckoutFacade
	 */
	public CheckoutFacade getAscentB2BCheckoutFacade()
	{
		return ascentB2BCheckoutFacade;
	}


	/**
	 * @param ascentB2BCheckoutFacade
	 *           the ascentB2BCheckoutFacade to set
	 */
	public void setAscentB2BCheckoutFacade(final CheckoutFacade ascentB2BCheckoutFacade)
	{
		this.ascentB2BCheckoutFacade = ascentB2BCheckoutFacade;
	}


}

