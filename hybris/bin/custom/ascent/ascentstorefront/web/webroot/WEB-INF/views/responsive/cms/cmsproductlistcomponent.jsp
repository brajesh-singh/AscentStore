<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/responsive/storepickup" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<c:forEach items="${searchPageData.facets}" var="facet">
	<c:if  test="${facet.code eq 'solution'}">
		<c:forEach items="${facet.values}" var="facetValue" varStatus="status">
			<section id="${fn:replace(facetValue.name,' ','')}" class="content-block ${status.index%2!=0 ? 'gray' : '' }">
				<div class="container">
					<div class="row wow fadeIn" data-wow-delay="0.5s">
						<!-- <div class="col-sm-10 col-sm-offset-2">  -->
							<h2 class="content-block-header"><span class="fa fa-${facetValue.code} pull-right"></span> ${facetValue.name} </h2>
							<div class="content-block-line"></div>
							<div class="content-block-desc">
								<p class="lead">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ut tincidunt massa. Cras vehicula lobortis eleifend. Nam quis dui a massa vehicula lobortis quis at orci. Donec ultrices sagittis dui non pharetra.</p>
							</div>
						<!-- </div> -->
						<div class="wow fadeInRight">
							<c:forEach items="${searchPageData.results}" var="product" varStatus="status">
								<c:forEach items="${product.categories}" var="productCategory">
									<c:if test="${productCategory eq facetValue.name}">
										<product:productListerItem product="${product}" />
									</c:if>
								</c:forEach>
							</c:forEach>
						</div>
					 </div>
				</div> 
			</section>
		</c:forEach>
	</c:if>
</c:forEach>
<script>
	$('body').scrollspy({ target: '#cat-menu-bar' })
</script> 




