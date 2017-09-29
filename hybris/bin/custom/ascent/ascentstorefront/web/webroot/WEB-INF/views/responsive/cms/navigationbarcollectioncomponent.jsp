<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>

<c:if test="${component.visible}">
	<ul class="nav navbar-nav navbar-right">
		<c:forEach items="${components}" var="component">
			<c:if test="${component.navigationNode.visible}">
				<cms:component component="${component}" evaluateRestriction="true" element="li" navigationType="offcanvas" />
			</c:if>
		</c:forEach>
	</ul>
</c:if>
