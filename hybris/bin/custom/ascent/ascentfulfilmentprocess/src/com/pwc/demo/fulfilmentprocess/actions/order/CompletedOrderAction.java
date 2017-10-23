/**
 *
 */
package com.pwc.demo.fulfilmentprocess.actions.order;

import de.hybris.platform.core.enums.OrderStatus;
import de.hybris.platform.core.model.order.OrderModel;
import de.hybris.platform.orderprocessing.model.OrderProcessModel;
import de.hybris.platform.processengine.action.AbstractSimpleDecisionAction;

/**
 * @author kyao011
 *
 */
public class CompletedOrderAction extends AbstractSimpleDecisionAction<OrderProcessModel>
{

	/*
	 * (non-Javadoc)
	 * 
	 * @see de.hybris.platform.processengine.action.AbstractSimpleDecisionAction#executeAction(de.hybris.platform.
	 * processengine.model.BusinessProcessModel)
	 */
	@Override
	public Transition executeAction(final OrderProcessModel process)
	{
		final OrderModel order = process.getOrder();
		setOrderStatus(order, OrderStatus.COMPLETED);
		return Transition.OK;

	}


}
