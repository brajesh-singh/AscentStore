<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="multi-checkout" tagdir="/WEB-INF/tags/responsive/checkout/multi"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%-- <%@ taglib prefix="b2b-multi-checkout" tagdir="/WEB-INF/tags/addons/b2bacceleratoraddon/responsive/checkout/multi" %>
 --%>
<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">
<c:forEach items="${cartData.entries}" var="entry">
	<product:productHeader productName="${entry.product.name}" />
</c:forEach>
<div class="row">
    <div >
        <div class="checkout-headline container">
            <%-- <span class="glyphicon glyphicon-lock"></span>
            <spring:theme code="checkout.multi.secure.checkout"></spring:theme> --%>
        </div>
        <multi-checkout:checkoutSteps checkoutSteps="${checkoutSteps}" progressBarId="${progressBarId}">
           <%-- <jsp:body>
                <multi-checkout:paymentTypeForm/>
            </jsp:body>  --%>
        </multi-checkout:checkoutSteps>
         <multi-checkout:paymentTypeForm/>
    </div>
   <%--  <div class="col-sm-6 hidden-xs">
        <multi-checkout:checkoutOrderDetails cartData="${cartData}" showDeliveryAddress="false" showPaymentInfo="false" showTaxEstimate="false" showTax="true" />
    </div> --%>

    <div class="col-sm-12 col-lg-12">
        <cms:pageSlot position="SideContent" var="feature" element="div" class="checkout-help">
            <cms:component component="${feature}"/>
        </cms:pageSlot>
    </div>
</div>
</template:page>
