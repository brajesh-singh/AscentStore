<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="buttonType">submit</c:set>
<spring:theme code="text.try" var="tryText" />
</a>
<div class="try clearfix">
	<c:url value="/try/${product.code}" var="tryUrl" />
	<ycommerce:testId code="searchPage_buyNow_button_${product.code}">
		<form:form id="tryForm${product.code}" action="${tryUrl}"
			method="post" class="try_form">
			<input type="hidden" name="productCodePost" value="${product.code}" />
			<input type="hidden" name="productNamePost" value="${product.name}" />
			<input type="hidden" name="productPostPrice"
				value="${product.price.value}" />

			<button type="${buttonType}" class="tryButton">${tryText}</button>
		</form:form>
	</ycommerce:testId>

</div>