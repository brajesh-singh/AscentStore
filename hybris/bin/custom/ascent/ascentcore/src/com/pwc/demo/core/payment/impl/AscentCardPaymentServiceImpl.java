/**
 *
 */
package com.pwc.demo.core.payment.impl;

import de.hybris.platform.payment.AdapterException;
import de.hybris.platform.payment.commands.factory.CommandFactory;
import de.hybris.platform.payment.commands.factory.CommandFactoryRegistry;
import de.hybris.platform.payment.commands.factory.CommandNotSupportedException;
import de.hybris.platform.payment.commands.request.AuthorizationRequest;
import de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest;
import de.hybris.platform.payment.commands.result.AuthorizationResult;
import de.hybris.platform.payment.dto.BasicCardInfo;
import de.hybris.platform.payment.methods.impl.DefaultCardPaymentServiceImpl;

import com.pwc.demo.core.payment.commands.AscentAuthorizationCommand;
import com.pwc.demo.core.payment.commands.AscentSubscriptionAuthorizationCommand;


/**
 * @author kyao011
 *
 */
public class AscentCardPaymentServiceImpl extends DefaultCardPaymentServiceImpl
{
	private CommandFactoryRegistry ascentCommandFactoryRegistry;
	/* (non-Javadoc)
	 * @see com.pwc.demo.core.payment.AscentCardPaymentService#authorize(de.hybris.platform.payment.commands.request.AuthorizationRequest)
	 */
	@Override
	public AuthorizationResult authorize(final AuthorizationRequest request)
	{
		try
		{
			final CommandFactory e = this.ascentCommandFactoryRegistry.getFactory(request.getCard(), false);
			final AscentAuthorizationCommand command = e.createCommand(AscentAuthorizationCommand.class);
			final AuthorizationResult result = command.perform(request);
			result.setPaymentProvider(e.getPaymentProvider());

			return result;

		}
		catch (final CommandNotSupportedException arg4)
		{

			throw new AdapterException(arg4.getMessage(), arg4);
		}
	}

	/* (non-Javadoc)
	 * @see com.pwc.demo.core.payment.AscentCardPaymentService#authorize(de.hybris.platform.payment.commands.request.SubscriptionAuthorizationRequest)
	 */
	@Override
	public AuthorizationResult authorize(final SubscriptionAuthorizationRequest request)
	{
		try
		{
			CommandFactory e;
			if (request.getPaymentProvider() == null)
			{

				e = this.ascentCommandFactoryRegistry.getFactory((BasicCardInfo) null, false);


			}
			else
			{
				e = this.ascentCommandFactoryRegistry.getFactory(request.getPaymentProvider());
			}
			final AscentSubscriptionAuthorizationCommand command = e.createCommand(AscentSubscriptionAuthorizationCommand.class);
			final AuthorizationResult result = command.perform(request);
			result.setPaymentProvider(e.getPaymentProvider());

			return result;

		}
		catch (final CommandNotSupportedException arg4)
		{

			throw new AdapterException(arg4.getMessage(), arg4);
		}
	}

	/**
	 * @return the ascentCommandFactoryRegistry
	 */
	public CommandFactoryRegistry getAscentCommandFactoryRegistry()
	{
		return ascentCommandFactoryRegistry;
	}

	/**
	 * @param ascentCommandFactoryRegistry
	 *           the ascentCommandFactoryRegistry to set
	 */
	public void setAscentCommandFactoryRegistry(final CommandFactoryRegistry ascentCommandFactoryRegistry)
	{
		this.ascentCommandFactoryRegistry = ascentCommandFactoryRegistry;
	}



}
