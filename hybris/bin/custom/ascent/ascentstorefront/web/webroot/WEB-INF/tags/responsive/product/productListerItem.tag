<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="action" tagdir="/WEB-INF/tags/responsive/action" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:theme code="text.addToCart" var="addToCartText"/>
<c:url value="${product.url}" var="productUrl"/>

<c:set value="${not empty product.potentialPromotions}" var="hasPromotion"/>

<div class="col-sm-6 col-md-4 wow fadeIn" data-wow-delay=".3s">
	<div class="category-box">
		
		<!-- <li class="product__list--item"> -->
			<ycommerce:testId code="test_searchPage_wholeProduct">
				<a class="product-link " href="${productUrl}" title="${fn:escapeXml(product.name)}" >
					<div class="category-icon">
						<span><product:productPrimaryImage product="${product}" format="thumbnail"/></span>
					</div>
					<div class="category-name">
						<ycommerce:testId code="searchPage_productName_link_${product.code}">
							<%-- <a class="category-name"  href="${productUrl}"> --%>${ycommerce:sanitizeHTML(product.name)}<!-- </a> -->
						</ycommerce:testId>
					</div>
					<div class="category-desc">
						<c:if test="${not empty product.summary}">
							${ycommerce:sanitizeHTML(product.summary)}
						</c:if>
					</div>
				</a>
				<%-- <div class="product__list--price-panel">
					<c:if test="${not empty product.potentialPromotions}">
						<div class="product__listing--promo">
							<c:forEach items="${product.potentialPromotions}" var="promotion">
								${ycommerce:sanitizeHTML(promotion.description)}
							</c:forEach>
						</div>
					</c:if>
		
					<ycommerce:testId code="searchPage_price_label_${product.code}">
						<div class="product__listing--price"><product:productListerItemPrice product="${product}"/></div>
					</ycommerce:testId>
				</div> --%>
		
		
				<c:set var="product" value="${product}" scope="request"/>
				<c:set var="addToCartText" value="${addToCartText}" scope="request"/>
				<c:set var="addToCartUrl" value="${addToCartUrl}" scope="request"/>
				<c:set var="loginUrl" value="${contextPath}/ascent/login" />
				<c:url var="downloadUrl" value="/download" />
				<c:url var="buyUrl" value="/${product.name}/p/${product.code }" />
				<%-- <div class="addtocart">
					<div id="actions-container-for-${fn:escapeXml(component.uid)}" class="row">
						<action:actions element="div" parentComponent="${component}"  />
					</div>
				</div> --%>
				<div class="category-link">
					<a href="${downloadUrl}"  class="btn btn-warning btn-default btn-sm" ><spring:theme code="text.product.list.try" /></a>  
					<a href="${buyUrl }" class="btn btn-warning btn-default btn-sm"><spring:theme code="text.product.list.buy" /></a>
				</div>
		
			</ycommerce:testId>
		<!-- </li> -->
	</div>
</div>