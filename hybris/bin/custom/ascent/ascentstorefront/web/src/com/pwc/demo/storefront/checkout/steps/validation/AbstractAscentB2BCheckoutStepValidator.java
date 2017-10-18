/**
 *
 */
package com.pwc.demo.storefront.checkout.steps.validation;

import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.AbstractCheckoutStepValidator;
import de.hybris.platform.acceleratorstorefrontcommons.checkout.steps.validation.ValidationResults;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;


/**
 * @author kyao011
 *
 */
public abstract class AbstractAscentB2BCheckoutStepValidator extends AbstractCheckoutStepValidator
{


	@Override
	public ValidationResults validateOnEnter(final RedirectAttributes redirectAttributes)
	{

		if (!getCheckoutFlowFacade().hasValidCart())
		{

			return ValidationResults.REDIRECT_TO_CART;
		}

		return doValidateOnEnter(redirectAttributes);
	}

	/**
	 * Performs implementation specific validation on entering a checkout step after the common validation has been
	 * performed in the abstract implementation.
	 *
	 * @param redirectAttributes
	 * @return {@link ValidationResults}
	 */
	protected abstract ValidationResults doValidateOnEnter(final RedirectAttributes redirectAttributes);


}
