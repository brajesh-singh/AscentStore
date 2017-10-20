<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<spring:url value="/checkout/multi/summary/placeOrder" var="placeOrderUrl"/>
<spring:url value="/checkout/multi/termsAndConditions" var="getTermsAndConditionsUrl"/>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">
<c:forEach items="${cartData.entries}" var="entry">
	<product:productHeader productName="${entry.product.name}" />
</c:forEach>
<div class="row">
    <div>
    	<div class="checkout-headline container">
    		<%-- <span class="glyphicon glyphicon-lock"></span>
            <spring:theme code="checkout.multi.secure.checkout" /> --%>
        </div>
		<multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
			<%-- <ycommerce:testId code="checkoutStepFour">
				<div class="checkout-review hidden-xs">
                    <div class="checkout-order-summary">
                        <multi-checkout:orderTotals cartData="${cartData}" showTaxEstimate="${showTaxEstimate}" showTax="${showTax}" subtotalsCssClasses="dark"/>
                    </div>
                </div>
                <div class="place-order-form hidden-xs">
                    <form:form action="${placeOrderUrl}" id="placeOrderForm1" commandName="placeOrderForm">
                        <div class="checkbox">
                            <label> <form:checkbox id="Terms1" path="termsCheck" />
                                <spring:theme code="checkout.summary.placeOrder.readTermsAndConditions" arguments="${getTermsAndConditionsUrl}" text="Terms and Conditions"/>
                            </label>
                        </div>

                        <button id="placeOrder" type="submit" class="btn btn-primary btn-place-order btn-block">
                            <spring:theme code="checkout.summary.placeOrder" text="Place Order"/>
                        </button>
                    </form:form>
                </div>
			</ycommerce:testId> --%>
		</multi-checkout:checkoutSteps>
		<div role="tabpanel" class="tab-pane active">
			<section id="pricing" class="content-block">
				<ycommerce:testId code="checkoutStepFour">
					<div class="container">
						<div class="row">
							<div class="col-sm-6 wow fadeInLeft">
								<div id="checkout-order-summary-product">
       								<multi-checkout:deliveryCartItems cartData="${cartData}" showDeliveryAddress="${showDeliveryAddress}" />
								</div>
							</div>
							<div class="col-sm-6 wow fadeInLeft">
			                    <div class="checkout-order-summary">
			                    	<multi-checkout:paymentInfo cartData="${cartData}" paymentInfo="${cartData.paymentInfo}" showPaymentInfo="true" />
			                        <multi-checkout:orderTotals cartData="${cartData}" showTaxEstimate="${showTaxEstimate}" showTax="${showTax}" subtotalsCssClasses="dark"/>
			                    </div>
		                    </div>
		                </div>
		                <div class="place-order-form hidden-xs">
		                <form:form action="${placeOrderUrl}" id="placeOrderForm1" commandName="placeOrderForm">
								<div class="row">
									<div class="col-sm-6 wow fadeInLeft">
									</div>
									<div class="col-sm-6 wow fadeInLeft">
										<div class="checkbox">
				                            <label> <form:checkbox id="Terms1" path="termsCheck" />
				                                <spring:theme code="checkout.summary.placeOrder.readTermsAndConditions" arguments="${getTermsAndConditionsUrl}" text="Terms and Conditions"/>
				                            </label>
				                        </div>
				
				                        <button id="placeOrder" type="submit" class="btn btn-warning btn-primary btn-place-order btn-block">
				                            <spring:theme code="checkout.summary.placeOrder" text="Place Order"/>
				                        </button>
									</div>
								</div>
							<!-- <button href="buy.html" class="btn btn-warning">BUY NOW</button> -->
						</form:form>
						</div>
					</div>
				</ycommerce:testId>
			</section>
		</div>
<%-- 		<ycommerce:testId code="checkoutStepFour">
				<div class="checkout-review hidden-xs">
                    <div class="checkout-order-summary">
                        <multi-checkout:orderTotals cartData="${cartData}" showTaxEstimate="${showTaxEstimate}" showTax="${showTax}" subtotalsCssClasses="dark"/>
                    </div>
                </div>
                <div class="place-order-form hidden-xs">
                    <form:form action="${placeOrderUrl}" id="placeOrderForm1" commandName="placeOrderForm">
                        <div class="checkbox">
                            <label> <form:checkbox id="Terms1" path="termsCheck" />
                                <spring:theme code="checkout.summary.placeOrder.readTermsAndConditions" arguments="${getTermsAndConditionsUrl}" text="Terms and Conditions"/>
                            </label>
                        </div>

                        <button id="placeOrder" type="submit" class="btn btn-primary btn-place-order btn-block">
                            <spring:theme code="checkout.summary.placeOrder" text="Place Order"/>
                        </button>
                    </form:form>
                </div>
			</ycommerce:testId> --%>
    </div>
 <%--
    <div class="col-sm-6">
		<multi-checkout:checkoutOrderSummary cartData="${cartData}" showDeliveryAddress="true" showPaymentInfo="true" showTaxEstimate="true" showTax="true" />
	</div>

    <div class="col-sm-12 col-lg-12">
        <br class="hidden-lg">
        <cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
            <cms:component component="${feature}"/>
        </cms:pageSlot>
    </div> --%>
</div>
</template:page>