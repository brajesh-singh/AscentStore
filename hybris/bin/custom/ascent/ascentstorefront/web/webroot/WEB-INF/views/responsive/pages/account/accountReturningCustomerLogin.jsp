<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="user" tagdir="/WEB-INF/tags/responsive/user"%>

<link rel="stylesheet" type="text/css" href="${themeResourcePath}/css/pwc-os-v1.css">

<c:url value="/j_spring_security_check" var="loginActionUrl" />


	<section id="details" class="content-block blue" >
		<div class="container" >
			<div class="row wow fadeIn" data-wow-delay="0.5s">
			
				<div class="col-sm-5">
					<user:login actionNameKey="login.login" action="${loginActionUrl}" />
				</div>
				
				<div class="hidden-xs col-sm-1">&nbsp;</div>
				
				<div class="col-sm-5">
					<c:url value="/login/register" var="registerActionUrl" />
					<user:register actionNameKey="register.submit"
						action="${registerActionUrl}" />
				</div>
				
			</div>
		</div>
	</section>