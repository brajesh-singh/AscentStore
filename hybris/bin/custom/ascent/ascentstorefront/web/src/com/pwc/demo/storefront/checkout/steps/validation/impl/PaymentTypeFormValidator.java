/**
 *
 */
package com.pwc.demo.storefront.checkout.steps.validation.impl;

import de.hybris.platform.b2bacceleratorservices.enums.CheckoutPaymentType;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.pwc.demo.storefront.controllers.pages.forms.PaymentTypeForm;



/**
 * Validator for {@link PaymentTypeForm}.
 */
@Component("paymentTypeFormValidator")
public class PaymentTypeFormValidator implements Validator
{

	@Override
	public boolean supports(final Class<?> clazz)
	{
		return PaymentTypeForm.class.equals(clazz);
	}

	@Override
	public void validate(final Object object, final Errors errors)
	{
		if (object instanceof PaymentTypeForm)
		{
			final PaymentTypeForm paymentTypeForm = (PaymentTypeForm) object;

			if (CheckoutPaymentType.ACCOUNT.getCode().equals(paymentTypeForm.getPaymentType())
					&& StringUtils.isBlank(paymentTypeForm.getCostCenterId()))
			{
				errors.rejectValue("costCenterId", "general.required");
			}
		}
	}

}
