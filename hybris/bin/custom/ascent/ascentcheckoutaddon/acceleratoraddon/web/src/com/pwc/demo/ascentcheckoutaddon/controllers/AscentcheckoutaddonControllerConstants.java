/*
 * [y] hybris Platform
 *
 * Copyright (c) 2017 SAP SE or an SAP affiliate company.  All rights reserved.
 *
 * This software is the confidential and proprietary information of SAP
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with SAP.
 */
package com.pwc.demo.ascentcheckoutaddon.controllers;

/**
 */
public interface AscentcheckoutaddonControllerConstants
{
	static final String ADDON_PREFIX = "addon:/ascentcheckoutaddon/";
	static final String STOREFRONT_PREFIX = "/";

	interface Views
	{
		interface Pages
		{
			interface MultiStepCheckout
			{
				String ChoosePaymentTypePage = STOREFRONT_PREFIX + "pages/checkout/multi/choosePaymentTypePage";
				String CheckoutSummaryPage = STOREFRONT_PREFIX + "pages/checkout/multi/checkoutSummaryPage";
				String AddPaymentMethodPage = STOREFRONT_PREFIX + "pages/checkout/multi/addPaymentMethodPage";
				String SilentOrderPostPage = STOREFRONT_PREFIX + "pages/checkout/multi/silentOrderPostPage";
				String HostedOrderPostPage = STOREFRONT_PREFIX + "pages/checkout/multi/hostedOrderPostPage";
			}
		}
	}
}
