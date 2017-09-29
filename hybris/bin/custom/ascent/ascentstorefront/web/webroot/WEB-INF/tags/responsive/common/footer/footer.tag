<%@ tag body-content="empty" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>


<footer id="footer">
	<cms:pageSlot position="Footer" var="feature">
		<cms:component component="${feature}" />
	</cms:pageSlot>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<ul class="social-links">
					<li><a href="#" class="wow fadeInUp"><i
							class="fa fa-facebook"></i></a></li>
					<li><a href="#" class="wow fadeInUp" data-wow-delay=".1s"><i
							class="fa fa-twitter"></i></a></li>
					<li><a href="#" class="wow fadeInUp" data-wow-delay=".2s"><i
							class="fa fa-google-plus"></i></a></li>
					<li><a href="#" class="wow fadeInUp" data-wow-delay=".4s"><i
							class="fa fa-pinterest"></i></a></li>
					<li><a href="#" class="wow fadeInUp" data-wow-delay=".5s"><i
							class="fa fa-envelope"></i></a></li>
				</ul>
			</div>
			<div class="col-sm-12 text-center">
				<a href="index.html"><img src="${themeResourcePath}/images/logos/company-logo.png"
					class="img-responsive center-block"
					style="max-height: 40px; max-width: 200px; margin-top: 0px;" /></a>
				<p class="copyright">
					Copyright © 2015 Ascent Solutions. All rights reserved.<br> <a
						href="#">Privacy</a> | <a href="#">Legal</a>
				</p>
			</div>
		</div>
		<!-- .row -->
	</div>
	<!-- .container -->
</footer>

