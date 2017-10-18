/**
 *
 */
package com.pwc.demo.storefront.controllers.pages.forms;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;


/**
 * @author kyao011
 *
 */
public class PaymentTypeForm
{
	private String paymentType;
	private String costCenterId;
	private String purchaseOrderNumber;

	@NotNull(message = "{general.required}")
	@Size(min = 1, max = 255, message = "{general.required}")
	public String getPaymentType()
	{
		return paymentType;
	}

	public void setPaymentType(final String paymentType)
	{
		this.paymentType = paymentType;
	}

	public String getCostCenterId()
	{
		return costCenterId;
	}

	public void setCostCenterId(final String costCenterId)
	{
		this.costCenterId = costCenterId;
	}

	public String getPurchaseOrderNumber()
	{
		return purchaseOrderNumber;
	}

	public void setPurchaseOrderNumber(final String purchaseOrderNumber)
	{
		this.purchaseOrderNumber = purchaseOrderNumber;
	}
}