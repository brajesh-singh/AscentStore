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
package com.pwc.demo.core.constants;

/**
 * Global class for all AscentCore constants. You can add global constants for your extension into this class.
 */
public final class AscentCoreConstants extends GeneratedAscentCoreConstants
{
	public static final String EXTENSIONNAME = "ascentcore";


	private AscentCoreConstants()
	{
		//empty
	}

	// implement here constants used by this extension
	public static final String QUOTE_BUYER_PROCESS = "quote-buyer-process";
	public static final String QUOTE_SALES_REP_PROCESS = "quote-salesrep-process";
	public static final String QUOTE_USER_TYPE = "QUOTE_USER_TYPE";
	public static final String QUOTE_SELLER_APPROVER_PROCESS = "quote-seller-approval-process";
	public static final String QUOTE_TO_EXPIRE_SOON_EMAIL_PROCESS = "quote-to-expire-soon-email-process";
	public static final String QUOTE_EXPIRED_EMAIL_PROCESS = "quote-expired-email-process";
	public static final String QUOTE_POST_CANCELLATION_PROCESS = "quote-post-cancellation-process";

	public final static String DEFAULT_DELIVERY_CODE = "free-standard-shipping";
	public static final String SUBSCRIPTION_PRODUCT_STATUS_VALID = "Valid";
	public static final String SUBSCRIPTION_PRODUCT_STATUS_INVALID = "Invalid";
}
