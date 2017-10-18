/**
 *
 */
package com.pwc.demo.storefront.checkout.steps.validation.impl;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BPaymentTypeData;
import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;
import de.hybris.platform.commercefacades.order.data.CartData;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pwc.demo.storefront.checkout.steps.validation.AbstractAscentB2BCheckoutStepValidator;


/**
 * @author kyao011
 *
 */
public class AscentSummaryCheckoutStepValidator extends AbstractAscentB2BCheckoutStepValidator
{

	/*
	 * (non-Javadoc)
	 *
	 * @see de.hybris.platform.b2bacceleratoraddon.checkout.steps.validation.impl.DefaultB2BSummaryCheckoutStepValidator#
	 * doValidateOnEnter(org.springframework.web.servlet.mvc.support.RedirectAttributes)
	 */
	@Override
	protected ValidationResults doValidateOnEnter(final RedirectAttributes redirectAttributes)
	{
		final CartData checkoutCart = getCheckoutFacade().getCheckoutCart();
		final B2BPaymentTypeData checkoutPaymentType = checkoutCart.getPaymentType();

		if (checkoutPaymentType == null)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.paymentType.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_TYPE;
		}

		if (CheckoutPaymentType.ACCOUNT.getCode().equals(checkoutPaymentType.getCode()) && checkoutCart.getCostCenter() == null)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.costCenter.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_TYPE;
		}

		if (getCheckoutFlowFacade().hasNoPaymentInfo())
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.paymentDetails.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_METHOD;
		}

		if (!getCheckoutFacade().hasShippingItems())
		{
			checkoutCart.setDeliveryAddress(null);
		}


		return ValidationResults.SUCCESS;
	}

}
