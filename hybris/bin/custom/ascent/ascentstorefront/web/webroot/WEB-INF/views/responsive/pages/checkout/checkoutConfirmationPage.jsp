<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/desktop/order"%>
<%@ taglib prefix="b2b-order" tagdir="/WEB-INF/tags/addons/b2bacceleratoraddon/desktop/order"%>
<%@ taglib prefix="ascent-order" tagdir="/WEB-INF/tags/addons/ascentcheckoutaddon/desktop/order"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/desktop/user"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<template:page pageTitle="${pageTitle}">
<%-- 	 <div id="globalMessages">
		<common:globalMessages />
	</div> --%>
	<div class="span-24">
		<cms:pageSlot position="TopContent" var="feature" element="div" class="span-24 top-content-slot cms_disp-img_slot">
			<cms:component component="${feature}" />
		</cms:pageSlot>
		<div>
			<a href="${request.contextPath}" class="button positive right">
				<spring:theme code="checkout.orderConfirmation.continueShopping" />
			</a>
		</div>
		<div class="orderHead">
			<ycommerce:testId code="orderConfirmation_yourOrderResults_text">
				<div class="orderConfirmationMsg">
					<spring:theme code="checkout.orderConfirmation.thankYouForOrder" />
				</div>
				<div>
					<spring:theme code="checkout.orderConfirmation.copySentTo" arguments="${email}" />
				</div>
			</ycommerce:testId>
			<div>
				<spring:theme code="text.account.order.orderNumber" text="Order number is {0}" arguments="${orderData.code}" />
			</div>
			<div>
				<spring:theme code="text.account.order.orderPlaced" text="Placed on {0}" arguments="${orderData.created}" />
			</div>
			<c:if test="${not empty orderData.statusDisplay}">
				<spring:theme code="text.account.order.status.display.${orderData.statusDisplay}" var="orderStatus" />
				<div>
					<spring:theme code="text.account.order.orderStatus" text="The order is {0}" arguments="${orderStatus}" />
				</div>
			</c:if>
		</div>
<%-- 
		<div class="orderBoxes clearfix">

			<c:set var="isService" value="false" />

			<c:forEach items="${orderData.entries}" var="entry">
				<c:if test="${not empty entry.product.categories}">
					<c:forEach items="${entry.product.categories}" var="category">
						<c:if test="${category.code eq 'Services'}">
							<c:set var="isService" value="true" />
						</c:if>
					</c:forEach>
				</c:if>

				<c:if test="${empty entry.product.categories}">
					<c:set var="isService" value="true" />
				</c:if>
			</c:forEach>

			<c:if test="${isService eq false }">
				<ascent-order:requireCDItem order="${orderData}" />
			</c:if>


			<c:if test="${orderData.requireCD eq true}">
				<order:deliveryAddressItem order="${orderData}" />
				<order:deliveryMethodItem order="${orderData}" />
			</c:if>
			<b2b-order:paymentMethodItem order="${orderData}" />
		</div>
		<ascent-order:orderDetailsItem order="${orderData}" />
		<c:forEach items="${orderData.pickupOrderGroups}" var="orderGroup">
			<order:orderPickupDetailsItem order="${orderData}" orderGroup="${orderGroup}" />
		</c:forEach>
		<div class="span-16">
			<order:receivedPromotions order="${orderData}" />
		</div>
		<div class="span-8 right last">
			<ascent-order:orderTotalsItem order="${orderData}" containerCSS="positive" />
		</div>
	</div>
	<cms:pageSlot position="SideContent" var="feature" element="div" class="span-24 side-content-slot cms_disp-img_slot">
		<cms:component component="${feature}" />
	</cms:pageSlot>
	<div>
		<a href="${request.contextPath}" class="button positive right">
			<spring:theme code="checkout.orderConfirmation.continueShopping" />
		</a>
	</div>  --%>

</template:page>