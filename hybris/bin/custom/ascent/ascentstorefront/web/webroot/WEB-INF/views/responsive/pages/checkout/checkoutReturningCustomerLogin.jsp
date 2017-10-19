<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/responsive/user" %>

<c:url value="/checkout/j_spring_security_check" var="loginAndCheckoutActionUrl" />


<link rel="stylesheet" type="text/css" href="${themeResourcePath}/css/pwc-os-v1.css">

<c:url value="/j_spring_security_check" var="loginActionUrl" />


	<section id="details" class="content-block blue" >
		<div class="container" >
			<div class="row wow fadeIn" data-wow-delay="0.5s">
			
				<div class="col-sm-5">
					<user:login actionNameKey="checkout.login.loginAndCheckout" action="${loginAndCheckoutActionUrl}"/>
				</div>
				
			</div>
		</div>
	</section>