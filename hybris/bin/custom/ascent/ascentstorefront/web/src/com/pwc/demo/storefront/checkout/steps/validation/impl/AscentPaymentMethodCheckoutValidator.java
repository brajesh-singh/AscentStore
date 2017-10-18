/**
 *
 */
package com.pwc.demo.storefront.checkout.steps.validation.impl;

import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.acceleratorstorefrontcommons.controllers.util.GlobalMessages;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BPaymentTypeData;
import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pwc.demo.storefront.checkout.steps.validation.AbstractAscentB2BCheckoutStepValidator;


/**
 * @author kyao011
 *
 */
public class AscentPaymentMethodCheckoutValidator extends AbstractAscentB2BCheckoutStepValidator
{

	/*
	 * (non-Javadoc)
	 *
	 * @see de.hybris.platform.b2bacceleratoraddon.checkout.steps.validation.impl.DefaultB2BPaymentCheckoutStepValidator#
	 * doValidateOnEnter(org.springframework.web.servlet.mvc.support.RedirectAttributes)
	 */
	@Override
	protected ValidationResults doValidateOnEnter(final RedirectAttributes redirectAttributes)
	{
		final B2BPaymentTypeData checkoutPaymentType = getCheckoutFacade().getCheckoutCart().getPaymentType();

		if (checkoutPaymentType == null)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.paymentType.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_TYPE;
		}

		if (CheckoutPaymentType.ACCOUNT.getCode().equals(checkoutPaymentType.getCode())
				&& getCheckoutFacade().getCheckoutCart().getCostCenter() == null)
		{
			GlobalMessages.addFlashMessage(redirectAttributes, GlobalMessages.INFO_MESSAGES_HOLDER,
					"checkout.multi.costCenter.notprovided");
			return ValidationResults.REDIRECT_TO_PAYMENT_TYPE;
		}

		// skip payment method step for account payment
		if (CheckoutPaymentType.ACCOUNT.getCode().equals(checkoutPaymentType.getCode()))
		{
			return ValidationResults.REDIRECT_TO_SUMMARY;
		}

		return ValidationResults.SUCCESS;
	}

}
