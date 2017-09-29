<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="buttonType">submit</c:set>
<spring:theme code="text.buyNow" var="buyNowText"/>
<c:choose>
	<c:when test="${product.stock.stockLevelStatus.code eq 'outOfStock' }">
		<c:set var="buttonType">button</c:set>
		<spring:theme code="text.addToCart.outOfStock" var="buyNowText"/>
	</c:when>
	<c:when test="${product.stock.stockLevelStatus.code eq 'lowStock' }">
		<div class='lowStock'>
			<spring:theme code="product.variants.only.left" arguments="${product.stock.stockLevel}"/>
		</div>
	</c:when>
</c:choose>
</a>
<div class="buynow clearfix">
	<c:url value="/buynow/${product.code}" var="buyNowUrl"/>
	<ycommerce:testId code="searchPage_buyNow_button_${product.code}">
		<form:form id="buyNowForm${product.code}" action="${buyNowUrl}" method="post" class="buy_now_form">
			<input type="hidden" name="productCodePost" value="${product.code}"/>
			<input type="hidden" name="productNamePost" value="${product.name}"/>
			<input type="hidden" name="productPostPrice" value="${product.price.value}"/>
			<input type="hidden" name="qty" value=1 />
			
			<button type="${buttonType}" class="buyNowButton <c:if test="
			${product.stock.stockLevelStatus.code eq 'outOfStock' }">out-of-stock</c:if>"
			<c:if test="${product.stock.stockLevelStatus.code eq 'outOfStock' }"> disabled="disabled" aria-disabled="true"</c:if>
			>${buyNowText}</button>
		</form:form>
	</ycommerce:testId>

</div>