<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:if test="${component.visible}">
	<ul class="nav navbar-nav navbar-right">
		<c:forEach items="${components}" var="component">
			<c:if test="${component.navigationNode.visible}">
				<cms:component component="${component}" evaluateRestriction="true" element="li" navigationType="offcanvas" />
			</c:if>
		</c:forEach>
	<c:url value="/login" var="loginUrl"/>
	<c:url value="/logout" var="logoutUrl"/>
<%-- 	<sec:authorize access="hasRole('ROLE_ANONYMOUS')">
	<li ><a href="${loginUrl}"><span  class="fa fa-sign-in"></span>LOGIN</a></li>
	</sec:authorize> --%>
	<sec:authorize access="!hasRole('ROLE_ANONYMOUS')">
	<li ><a href="${logoutUrl}"><span  class="fa fa-sign-out"></span>LOGOUT</a></li>
	</sec:authorize> 
	</ul>
</c:if>
