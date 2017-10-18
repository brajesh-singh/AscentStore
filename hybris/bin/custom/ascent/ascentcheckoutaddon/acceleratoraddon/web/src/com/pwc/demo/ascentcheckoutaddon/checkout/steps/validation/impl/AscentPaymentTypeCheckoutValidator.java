/**
 *
 */
package com.pwc.demo.ascentcheckoutaddon.checkout.steps.validation.impl;

import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;
import de.hybris.platform.b2bacceleratoraddon.checkout.steps.validation.AbstractB2BCheckoutStepValidator;
import de.hybris.platform.b2bacceleratorfacades.order.data.B2BPaymentTypeData;
import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;




/**
 * @author kyao011
 *
 */
public class AscentPaymentTypeCheckoutValidator extends AbstractB2BCheckoutStepValidator
{
	@Override
	protected ValidationResults doValidateOnEnter(final RedirectAttributes redirectAttributes)
	{
		return ValidationResults.SUCCESS;
	}
	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * de.hybris.platform.b2bacceleratoraddon.checkout.steps.validation.impl.DefaultB2BPaymentTypeCheckoutStepValidator#
	 * validateOnExit()
	 */
	@Override
	public ValidationResults validateOnExit()
	{
		final B2BPaymentTypeData checkoutPaymentType = getCheckoutFacade().getCheckoutCart().getPaymentType();

		if (null == checkoutPaymentType)
		{
			return ValidationResults.REDIRECT_TO_PAYMENT_TYPE;
		}
		else if (CheckoutPaymentType.ACCOUNT.getCode().equals(checkoutPaymentType.getCode()))
		{
			return ValidationResults.REDIRECT_TO_SUMMARY;
		}
		return ValidationResults.SUCCESS;
	}

}
