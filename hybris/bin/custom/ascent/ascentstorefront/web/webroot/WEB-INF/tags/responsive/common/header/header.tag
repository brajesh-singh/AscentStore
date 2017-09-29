<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ attribute name="hideHeaderLinks" required="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="nav" tagdir="/WEB-INF/tags/responsive/nav"%>

<cms:pageSlot position="TopHeaderSlot" var="component" element="div"
	class="container">
	<cms:component component="${component}" />
</cms:pageSlot>
<!-- Page top anchor start -->
<a id="top"></a>
<!-- Page top anchor end -->
<!-- Hero start -->
<c:if test="${cmsPage.title eq 'Homepage' }">
<section id="hero" class="content-block homepage-hero">
	<!--<div class="hero-overlay"></div>-->
	<div class="simple-message">
		<div class="wow slideInDown">
			<h1 class="content-block-header-name center">SEEING IS BELIVING</h1>
			<h3 class="content-block-header center">but experience is confirmation </h3>
		</div>
	</div>
</section>
</c:if>
<!-- Hero end -->
<!-- Navigation start -->
<header id="navbar" class="header">
	<nav class="navbar navbar-custom" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#custom-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/${commonResourcePath}"><img
					src="${themeResourcePath}/images/logos/company-logo.png" class="img-responsive"
					style="max-height: 40px; max-width: 200px; margin-top: -7px;" /></a>
			</div>
			<div class="collapse navbar-collapse" id="custom-collapse">
			<nav:topNavigation />
			</div>
		</div>
	</nav>
</header>
<!-- Navigation end -->



<cms:pageSlot position="BottomHeaderSlot" var="component" element="div"
	class="container-fluid">
	<cms:component component="${component}" />
</cms:pageSlot>
	
<script type="text/javascript" src="${commonResourcePath}/js/pwc-os-foot.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.parallax-1.1.3.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.sticky.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/smoothscroll.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/wow.min.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/waypoints.min.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/jquery.cbpQTRotator.js"></script>
<script type="text/javascript" src="${commonResourcePath}/js/custom.js"></script>

