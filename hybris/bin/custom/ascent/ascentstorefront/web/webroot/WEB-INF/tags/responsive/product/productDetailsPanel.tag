<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<header id="navbar" class="header">
	<nav class="navbar navbar-custom detail-nav" role="navigation">

		<div class="container-fluid">

			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#custom-collapse-sub">
					<span class="sr-only"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand"><span class="fa fa-cube"></span>
					${fn:escapeXml(product.name)}</a>
			</div>

			<!-- 		<div class="collapse navbar-collapse" id="custom-collapse-sub">
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#overview-details" role="tab" data-toggle="tab">Overview</a></li>
						<li><a href="#pricing-info" role="tab" data-toggle="tab">Pricing</a></li>
                        <li><a href="#account">Skills</a></li>
						<li><a href="#testimonials">Testimonials</a></li>
						<li><a href="login.html" ><span class="btn btn-warning">FREE TRAIL</span></a></li> 
						<li><a href="#buy" data-toggle="modal"><span class="btn btn-warning">Buy</span></a></li>
					</ul>
				</div> -->



		</div>
		<!-- .container -->

	</nav>

</header>
<%-- <div class="product-details page-title">
	<ycommerce:testId code="productDetails_productNamePrice_label_${product.code}">
		<div class="name">${fn:escapeXml(product.name)}<span class="sku">ID</span><span class="code">${fn:escapeXml(product.code)}</span></div>
	</ycommerce:testId>
	<product:productReviewSummary product="${product}" showLinks="true"/>
</div>
<div class="row">
	<div class="col-xs-10 col-xs-push-1 col-sm-6 col-sm-push-0 col-lg-4">
		<product:productImagePanel galleryImages="${galleryImages}" />
	</div>
	<div class="clearfix hidden-sm hidden-md hidden-lg"></div>
	<div class="col-sm-6 col-lg-8">
		<div class="product-main-info">
			<div class="row">
				<div class="col-lg-6">
					<div class="product-details">
						<product:productPromotionSection product="${product}"/>
						<ycommerce:testId code="productDetails_productNamePrice_label_${product.code}">
							<product:productPricePanel product="${product}" />
						</ycommerce:testId>
						<div class="description">${ycommerce:sanitizeHTML(product.summary)}</div>
					</div>
				</div>

				<div class="col-sm-12 col-md-9 col-lg-6">
					<cms:pageSlot position="VariantSelector" var="component" element="div" class="page-details-variants-select">
						<cms:component component="${component}" element="div" class="yComponentWrapper page-details-variants-select-component"/>
					</cms:pageSlot>
					<cms:pageSlot position="AddToCart" var="component" element="div" class="page-details-variants-select">
						<cms:component component="${component}" element="div" class="yComponentWrapper page-details-add-to-cart-component"/>
					</cms:pageSlot>
				</div>
			</div>
		</div>

	</div>
</div> --%>

<!-- Tab panes -->
<section id="details" class="content-block blue">
	<div class="container">
		<div class="row wow fadeIn" data-wow-delay="0.5s">
			<div class="col-sm-6 ">
				<h2 class="content-block-header">Product Details</h2>
				<div class="content-block-desc">
					<p>${ycommerce:sanitizeHTML(product.summary)}</p>
				</div>
			</div>
			<div
				class="hidden-xs col-xs-12 col-sm-4 col-sm-offset-2 wow fadeInRight">
				<product:productImagePanel galleryImages="${galleryImages}" />
			</div>
		</div>
	</div>
</section>

<section id="pricing" class="content-block">
	<div class="container">
		<div class="row">
			<div class="col-sm-12 wow fadeInLeft">
				<h2 class="content-block-header">Pricing</h2>
			</div>
		</div>
	</div>
	<div class="container">
	<c:url value="/buy/${product.code}" var="buyUrl" />
		<ul class="nav nav-tabs dcp-tabs" role="tablist">
		<c:choose>
			<c:when test="${fn:length(subscriptionProducts) > 0 }">
			<li role="presentation" class="active"><a class="pointer"
				data-target="#saas" role="tab" data-toggle="tab">Subscription</a></li>
			</c:when>
			<c:otherwise>
				<li role="presentation" class="active"><a class="pointer"
					data-target="#local" role="tab" data-toggle="tab">On-Premises</a></li>
			</c:otherwise>
		</c:choose>
		</ul>
		<c:choose>
			<c:when test="${fn:length(subscriptionProducts) > 0 }">
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active " id="saas">
						<section id="pricing" class="content-block">
							<form:form id="buyToCartForm" role="form" action="${buyUrl}" commandName="addToCartForm">						
									<div class="row">
										<div class="col-sm-6 wow fadeInLeft">
											<div class="content-block-desc">
												<p>${ycommerce:sanitizeHTML(product.summary)}</p>
											</div>
										</div>
										<div class="col-sm-6 wow fadeInLeft">
											<div class="content-block-desc">
												<div class="form-group">
													<p>Please enter the number of users</p>
													<div class="row">
														<div class="col-xs-6">
															<label class="sr-only" for="cpu_num">Number of
																users.</label> <input type="text" id="cpu_num"
																class="form-control" name="qty" value="1">
														</div>
														<div class="col-xs-6">
															<span type="button"
																class="fa fa-plus-circle pointer cpu_up"></span> <span
																type="button"
																class="fa fa-minus-circle pointer cpu_down"></span>
														</div>
													</div>
												</div>
												<div class="form-group">
													<p>Please select the validity of the service</p>
													<div class="row">
														<div class="col-xs-6">
															<select class="form-control" id="service_validity" name ="subProductCode">
																<option value="">Please select a valid service
																	time</option>
																<c:forEach items="${subscriptionProducts}" var="sub">
																	<option value="${sub.code}">${sub.name}</option>
																</c:forEach>
															</select>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								
									<div class="container" id="servicesContainer">
										<div class="row">
											<div class="content-block-line wow fadeIn"
												data-wow-delay="0.5s"></div>
										</div>
										<c:forEach items="${subscriptionProducts}" var="sub">
											<div class="row" data-select-value="${sub.code}">
												<div class="row wow fadeIn" data-wow-delay="0.8s">
													<div class="col-xs-1 text-center">	
													<br />													
														<h2 class="content-block-header text-warning"><product:productPrimaryImage product="${sub}" format="thumbnail"/></h2>
													</div>
													<div class="col-xs-6 text-center">
														<br />
														<h3 class="col-xs-9 text-center">${sub.name}</h3>
													</div>
													<div class="col-xs-3 text-center">
														<br />
														<h2 class="content-block-header text-warning"><format:fromPrice priceData="${sub.price}"/></h2>
													</div>
													<div class="col-xs-2 text-center">
														<br />
														<button type="submit" class="btn btn-warning">BUY NOW</button>	
													</div>
												</div>
											</div>
										</c:forEach>

									</div>
							</form:form>
						</section>
					</div>
				</div>

			</c:when>
			<c:otherwise>
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active " id="local">
						<section id="pricing" class="content-block">
							<form:form id="buyToCartForm" role="form" action="${buyUrl}" commandName="addToCartForm">
								<div class="container">
									<div class="row">
										<div class="col-sm-6 wow fadeInLeft">
											<div class="content-block-desc">
												<p>${ycommerce:sanitizeHTML(product.summary)}</p>
											</div>
										</div>
										<div class="col-sm-6 wow fadeInLeft">
											<div class="content-block-desc">
												<div class="form-group">
												<h2 class="content-block-header text-warning"><format:fromPrice priceData="${product.price}"/></h2>
												
												</div>
												<div class="form-group">
													<p>Please enter the number of users</p>
													<div class="row">
														<div class="col-xs-6">
															<label class="sr-only" for="cpu_num">Number of
																CPUs.</label> <input type="text" id="cpu_num"
																class="form-control" name="qty" value="1">
														</div>
														<div class="col-xs-6">
															<span type="button"
																class="fa fa-plus-circle pointer cpu_up"></span> <span
																type="button"
																class="fa fa-minus-circle pointer cpu_down"></span>
														</div>
													</div>
												</div>
											</div>
										</div>										
									</div>
									<input type="hidden" name="subProductCode" value="">
									<div class="row">
										<div class="col-sm-6 wow fadeInLeft">&nbsp;</div>
										<div class="col-sm-6 wow fadeInLeft">
											&nbsp;&nbsp;
											<button type="submit" class="btn btn-warning">BUY NOW</button>										
										</div>
									</div>
								</div>
							</form:form>
						</section>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</section>
<!-- Products start -->
<section id="products" class="content-block homepage-spotlight">
	<div class="container">
		<div class="row">
			<div class="col-sm-12 wow fadeInUp">
				<h2 class="content-block-header left">Additional Products</h2>
				<div class="content-block-line"></div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-6 col-lg-3">
				<div class="spotlight-box wow bounceInRight" data-wow-delay="0.1s">
					<a class="product-box-link" href="detail.html">
						<div class="spotlight-box-name">Product Name</div>
						<div class="spotlight-box-category">
							<span class="fa fa-cubes"></span> Solution Name
						</div>
						<div class="spotlight-box-desc">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit.</div>
					</a>
					<div>
						<a href="#trial" data-toggle="modal"
							class="btn btn-warning btn-default btn-sm">Try</a> <a
							href="detail.html#pricing"
							class="btn btn-warning btn-default btn-sm">BUY</a>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-6 col-lg-3">
				<div class="spotlight-box wow bounceInRight" data-wow-delay="0.3s">
					<a class="product-box-link" href="detail.html"><div
							class="spotlight-box-name">Product Name</div>
						<div class="spotlight-box-category">
							<span class="fa fa-cubes"></span> Solution Name
						</div>
						<div class="spotlight-box-desc">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit.</div> </a>
					<div>
						<a href="#trial" data-toggle="modal"
							class="btn btn-warning btn-default btn-sm">Try</a> <a
							href="detail.html#pricing"
							class="btn btn-warning btn-default btn-sm">BUY</a>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-6 col-lg-3">
				<div class="spotlight-box wow bounceInRight" data-wow-delay="0.5s">
					<a class="product-box-link" href="detail.html"><div
							class="spotlight-box-name">Product Name</div>
						<div class="spotlight-box-category">
							<span class="fa fa-cubes"></span> Solution Name
						</div>
						<div class="spotlight-box-desc">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit.</div> </a>
					<div>
						<a href="#trial" data-toggle="modal"
							class="btn btn-warning btn-default btn-sm">Try</a> <a
							href="detail.html#pricing"
							class="btn btn-warning btn-default btn-sm">BUY</a>
					</div>
				</div>
			</div>
			<div class="col-sm-6 col-md-6 col-lg-3">
				<div class="spotlight-box wow bounceInRight" data-wow-delay="0.7s">
					<a class="product-box-link" href="detail.html"><div
							class="spotlight-box-name">Product Name</div>
						<div class="spotlight-box-category">
							<span class="fa fa-cubes"></span> Solution Name
						</div>
						<div class="spotlight-box-desc">Lorem ipsum dolor sit amet,
							consectetur adipiscing elit.</div> </a>
					<div>
						<a href="#trial" data-toggle="modal"
							class="btn btn-warning btn-default btn-sm">Try</a> <a
							href="detail.html#pricing"
							class="btn btn-warning btn-default btn-sm">BUY</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Products end -->
<div class="scroll-up">
	<a href="#top"><i class="fa fa-angle-up"></i></a>
</div>


