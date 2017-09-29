<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
	<section id="details" class="content-block blue" >
		<div class="container" >
			<div class="row wow fadeIn" data-wow-delay="0.5s">
   				<div class="col-sm-6 ">
					<h2 class="content-block-header">Product Details</h2>
					<div class="content-block-desc">
						<p>${ycommerce:sanitizeHTML(product.summary)}</p>
					</div>
				</div>
				<div class="hidden-xs col-xs-12 col-sm-4 col-sm-offset-2 wow fadeInRight">
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
			<ul class="nav nav-tabs dcp-tabs" role="tablist" >
				<li role="presentation" class="active"><a class="pointer" data-target="#saas" role="tab" data-toggle="tab">Subscription</a></li>
				<li role="presentation" class=""><a class="pointer" data-target="#local" role="tab" data-toggle="tab">On-Premises</a></li>
			</ul>
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active " id="saas">
					<section id="pricing" class="content-block">
						<form id="configure" role="form">
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
												<p>Please enter the number of months</p>
												<div class="row">
													<div class="col-xs-6">
														<label class="sr-only" for="cpu_num">Number of CPUs.</label>
														<input type="text" id="cpu_num" class="form-control" name="cpu_num" value="0" >
													</div>
													<div class="col-xs-6">
														<span type="button" class="fa fa-plus-circle pointer cpu_up"></span>
								 						<span type="button" class="fa fa-minus-circle pointer cpu_down"></span>
								 					</div>
												</div>
											</div>
											<div class="form-group">
												<p>Please enter number of seats.</p>
												<div class="row">
													<div class="col-xs-6">
														<label class="sr-only" for="myear_num">Years of maintenance</label>
														<input type="text" id="myear_num" class="form-control" name="myear_num" value="0" >
													</div>
													<div class="col-xs-6">
														<span type="button" class="fa fa-plus-circle pointer myear_up"></span>
									 					<span type="button" class="fa fa-minus-circle pointer myear_down"></span>
								    				</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6 wow fadeInLeft"> &nbsp;</div>
									<div class="col-sm-6 wow fadeInLeft">&nbsp;&nbsp; 
										<button type="submit" class="btn btn-warning btn-lg">UPDATE Pricing</button>
									</div>
								</div>
							</div>
							<div class="container">
								<div class="row"><div class="content-block-line wow fadeIn" data-wow-delay="0.5s"></div></div>				
								<div class="row">
									<div class="row wow fadeIn" data-wow-delay="0.8s">
										<div class="col-sm-3 text-center">
											<h3>PER SEAT</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center">
											<h3>TOTAL</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center">
											<h3>DUE TODAY</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center"><br /><a href="/ascentstorefront/ascent/en/buy" class="btn btn-warning">BUY NOW</a></div>
									</div>
								</div>							
							</div>
						</form>
					</section>
   				</div>
  				<div role="tabpanel" class="tab-pane" id="local">
					<section id="pricing" class="content-block">
						<form id="configure" role="form">
							<div class="container">	
								<div class="row">
									<div class="col-sm-6 ">
										<div class="content-block-desc">
											<p>${ycommerce:sanitizeHTML(product.summary)}</p>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="content-block-desc">
											<div class="form-group">
												<p>Please enter the number of CPUs</p>
												<div class="row">
													<div class="col-xs-6">
														<label class="sr-only" for="cpu_num">Number of CPUs.</label>
														<input type="text" id="cpu_num" class="form-control" name="cpu_num" value="0" >
													</div>
													<div class="col-xs-6">
														<span type="button" class="fa fa-plus-circle pointer cpu_up"></span>
								 						<span type="button" class="fa fa-minus-circle pointer cpu_down"></span>
								 					</div>
												</div>
											</div>
											<div class="form-group">
												<p>Please enter number of years of maintenance.</p>
												<div class="row">
													<div class="col-xs-6">
														<label class="sr-only" for="myear_num">Years of maintenance</label>
														<input type="text" id="myear_num" class="form-control" name="myear_num" value="0" >
													</div>
													<div class="col-xs-6">
														<span type="button" class="fa fa-plus-circle pointer myear_up"></span>
													 	<span type="button" class="fa fa-minus-circle pointer myear_down"></span>
												    </div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-6 "> &nbsp;</div>
									<div class="col-sm-6">&nbsp;&nbsp; <button type="submit" class="btn btn-lg btn-warning">UPDATE Pricing</button></div>
								</div>
								<div class="row"><div class="content-block-line" ></div></div>				
								<div class="row">
									<div class="row">
										<div class="col-sm-3 text-center">
											<h3>PER SEAT</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center">
											<h3>TOTAL</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center">
											<h3>DUE TODAY</h3>
											<h2 class="content-block-header text-warning">$0</h2>
										</div>
										<div class="col-sm-3 text-center"><br /><a href="/ascentstorefront/ascent/en/buy" data-toggle="modal" class="btn btn-warning">BUY NOW</a></div>
									</div>
								</div>	
							</div>
						</form>
					</section>
   				</div>
			</div>
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
							<div class="spotlight-box-category"><span class="fa fa-cubes"></span> Solution Name</div>
							<div class="spotlight-box-desc">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. 							</div>
						</a>
						<div> <a href="#trial" data-toggle="modal" class="btn btn-warning btn-default btn-sm" >Try</a>  <a href="detail.html#pricing"  class="btn btn-warning btn-default btn-sm">BUY</a></div>
					</div>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-3">
					<div class="spotlight-box wow bounceInRight" data-wow-delay="0.3s">
						<a class="product-box-link" href="detail.html"><div class="spotlight-box-name">Product Name</div>
							<div class="spotlight-box-category"><span class="fa fa-cubes"></span> Solution Name</div>
							<div class="spotlight-box-desc">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. 							</div>
						</a>
						<div> <a href="#trial" data-toggle="modal" class="btn btn-warning btn-default btn-sm" >Try</a>  <a href="detail.html#pricing"  class="btn btn-warning btn-default btn-sm">BUY</a></div>
					</div>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-3">
					<div class="spotlight-box wow bounceInRight" data-wow-delay="0.5s">
						<a class="product-box-link"  href="detail.html"><div class="spotlight-box-name">Product Name</div>
							<div class="spotlight-box-category"><span class="fa fa-cubes"></span> Solution Name</div>
							<div class="spotlight-box-desc">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. 							</div>
						</a>
						<div> <a href="#trial" data-toggle="modal" class="btn btn-warning btn-default btn-sm" >Try</a>  <a href="detail.html#pricing"  class="btn btn-warning btn-default btn-sm">BUY</a></div>
					</div>
				</div>
				<div class="col-sm-6 col-md-6 col-lg-3">
					<div class="spotlight-box wow bounceInRight" data-wow-delay="0.7s">
						<a class="product-box-link"  href="detail.html"><div class="spotlight-box-name">Product Name</div>
							<div class="spotlight-box-category"><span class="fa fa-cubes"></span> Solution Name</div>
							<div class="spotlight-box-desc">
								Lorem ipsum dolor sit amet, consectetur adipiscing elit. 							</div>
						</a>
						<div> <a href="#trial" data-toggle="modal" class="btn btn-warning btn-default btn-sm" >Try</a>  <a href="detail.html#pricing"  class="btn btn-warning btn-default btn-sm">BUY</a></div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Products end -->
	<div class="scroll-up">
		<a href="#top"><i class="fa fa-angle-up"></i></a>
	</div>
	
	
