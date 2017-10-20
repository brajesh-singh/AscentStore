<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>


<section id="product-spolight" class="content-block homepage-spotlight">
	<div class="container">
		<div class="row">
			<div class="col-sm-12 wow fadeInUp">
				<h2 class="content-block-header center">Product Spotlight</h2>
				<div class="content-block-line"></div>
				<!--<p class="content-block-desc">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ut tincidunt massa. Cras vehicula lobortis eleifend. Nam quis dui a massa vehicula lobortis quis at orci. Donec ultrices sagittis dui non pharetra. 
			</p>-->
			</div>
		</div>
		<div class="row">
			<c:if test="${ not empty spotlightProductList }">
				<c:set var="count" value="0" />
				<c:forEach var="product" items="${spotlightProductList }">
					<c:forEach var="category" items="${product.categories}">
						<c:if test="${fn:contains(category.url,'Solutions') and count < 4}">
								<c:set var="count" value="${count+1}" />
								<c:url var="downloadUrl" value="/download" />
								<c:url var="buyUrl" value="${category.url}/${product.name}/p/${product.code }" />
								<div class="col-sm-6 col-md-6 col-lg-3">
									<div class="spotlight-box wow bounceInRight" data-wow-delay="0.1s">
										<a class="product-box-link" href="${buyUrl }">
											<div class="spotlight-box-name">${product.name }</div>
											<div class="spotlight-box-category">
												<span class="fa fa-cubes"></span> 
												
														${category.name }
											</div>
											<div class="spotlight-box-desc">${product.summary }</div>
										</a>
										<div>
											<a href="${downloadUrl}" class="btn btn-warning btn-default btn-sm"><spring:theme code="text.product.list.try" /></a>
											<a href="${buyUrl }"
												class="btn btn-warning btn-default btn-sm"><spring:theme code="text.product.list.buy" /></a>
										</div>
									</div>
								</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</c:if>
		</div>
	</div>
</section>