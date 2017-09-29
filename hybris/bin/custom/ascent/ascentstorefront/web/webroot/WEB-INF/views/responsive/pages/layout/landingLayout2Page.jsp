<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>

<link rel="stylesheet" type="text/css"
	href="${themeResourcePath}/css/pwc-os-v1.css">

<template:page pageTitle="${pageTitle}">
	<section id="categories" class="content-block homepage-categories">
		<div class="container">
			<div class="row">
				<div class="wow fadeInUp">
					<cms:pageSlot position="Section1" var="feature">
						<cms:component component="${feature}" />
					</cms:pageSlot>
				</div>
			</div>
			<div class="row">
				<cms:pageSlot position="Section2A" var="feature" element="div">
					<cms:component component="${feature}" element="div" class="col-xs-12 col-sm-6 no-space yComponentWrapper"/>
				</cms:pageSlot>
			</div></br>
			<div class="row">
				<cms:pageSlot position="Section2B" var="feature" element="div">
					<cms:component component="${feature}" element="div" class="col-xs-12 col-sm-6 no-space yComponentWrapper"/>
				</cms:pageSlot>
			</div></br>
			<div class="row">
				<cms:pageSlot position="Section2C" var="feature" element="div">
					<cms:component component="${feature}" element="div" class="col-xs-12 col-sm-6 no-space yComponentWrapper"/>
				</cms:pageSlot>
			</div>				
		</div>
	</section>

<%-- 	<cms:pageSlot position="Section2B" var="feature" element="div"
		class="row no-margin">
		<cms:component component="${feature}" element="div"
			class="col-xs-12 col-sm-6 no-space yComponentWrapper" />
	</cms:pageSlot>
	<cms:pageSlot position="Section2C" var="feature" element="div"
		class="landingLayout2PageSection2C">
		<cms:component component="${feature}" element="div"
			class="yComponentWrapper" />
	</cms:pageSlot>
 --%>
	<cms:pageSlot position="Section3" var="feature" element="div">
		<cms:component component="${feature}" element="div"
			class="no-space yComponentWrapper" />
	</cms:pageSlot>

	<cms:pageSlot position="Section4" var="feature" element="div"
		class="row no-margin">
		<cms:component component="${feature}" element="div"
			class="col-xs-6 col-md-3 no-space yComponentWrapper" />
	</cms:pageSlot>

	<cms:pageSlot position="Section5" var="feature" element="div">
		<cms:component component="${feature}" element="div"
			class="yComponentWrapper" />
	</cms:pageSlot>

	<!-- Product Spotlight start -->
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
							<a href="login.html" class="btn btn-warning btn-default btn-sm">Try</a>
							<a href="detail.html#pricing"
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
							<a href="login.html" class="btn btn-warning btn-default btn-sm">Try</a>
							<a href="detail.html#pricing"
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
							<a href="login.html" class="btn btn-warning btn-default btn-sm">Try</a>
							<a href="detail.html#pricing"
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
							<a href="login.html" class="btn btn-warning btn-default btn-sm">Try</a>
							<a href="detail.html#pricing"
								class="btn btn-warning btn-default btn-sm">BUY</a>
						</div>
					</div>
				</div>
			</div>
			<!-- .row -->
		</div>
		<!-- .container -->
	</section>
	<!-- Product Spotlight end -->

	<!-- Product Testimonials -->
	<section id="testimonial" class="content-block gray">
		<div class="container">
			<div class="wow fadeIn" data-wow-delay="0.5s">
				<h2 class="content-block-header left">What others are saying</h2>
				<div id="cbp-qtrotator" class="cbp-qtrotator wow fadeInUp">
					<div class="cbp-qtcontent">
						<p class="lead">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Pellentesque ut tincidunt massa. Cras vehicula
							lobortis eleifend. Nam quis dui a massa vehicula lobortis quis at
							orci. Donec ultrices sagittis dui non pharetra.</p>
						<div>
							<img src="${themeResourcePath}/images/logos/client-visa.png"
								alt="client-1" />
						</div>
					</div>
					<div class="cbp-qtcontent">
						<p class="lead">Lorem ipsum dolor sit amet, consectetur
							adipiscing elit. Pellentesque ut tincidunt massa. Cras vehicula
							lobortis eleifend. Nam quis dui a massa vehicula lobortis quis at
							orci. Donec ultrices sagittis dui non pharetra.</p>
						<div>
							<img src="${themeResourcePath}/images/logos/client-att.png"
								alt="client-2" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- Resources start -->
	<section id="resource" class="content-block homepage-resources">
		<div class="container">
			<div class="row">
				<div class="col-sm-3 hidden-xs wow slideInLeft">
					<img
						src="${themeResourcePath}/images/green-download-document-file.png"
						class="img-responsive" style="border: none;" />
				</div>
				<div class="col-sm-9 wow fadeInRight">
					<h2 class="content-block-header left">Resources</h2>
					<div class="content-block-line"></div>
					<p class="content-block-desc lead">Dive deeper with product
						videos, technical documents, white papers, and more.</p>
					<div class="row content-block-desc">
						<div class="col-sm-3">
							<p>White Papers</p>
							<p>White Papers</p>
							<p>White Papers</p>
						</div>

						<div class="col-sm-3">
							<p>White Papers</p>
							<p>White Papers</p>
							<p>White Papers</p>
						</div>
					</div>
					<div class="content-block-links">
						<a href="#" class="btn btn-default btn-xs">View all resources</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Resources end -->

	<!-- Contact start -->
	<section id="newsletter" class="content-block blue homepage-newsletter">
		<div class="container">
			<div class="row">
				<div class="wow bounceInUp">
					<h2 class="content-block-header center">Stay Informed</h2>
					<h4 class="content-block-header center">Stay up-to-date with
						news on our products, releases, and announcements.</h4>
					<div class="content-block-line"></div>
				</div>
			</div>
			<div class="row">
				<div class="wow fadeInUp" data-wow-delay="0.5s">
					<div class="newsletter-signup-form">
						<form class="form-horizontal">
							<div class=" form-group-lg">
								<div class="col-sm-10">
									<input type="email" class="form-control input-lg"
										placeholder="Please provide your email address" />
									<div class="clearfix">&nbsp;</div>
								</div>
								<div class="col-sm-2">
									<button class="btn btn-default btn-lg btn-block"
										value="Sign Up">Submit</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Contact end -->
</template:page>
<div class="scroll-up">
	<a href="#top"><i class="fa fa-angle-up"></i></a>
</div>
