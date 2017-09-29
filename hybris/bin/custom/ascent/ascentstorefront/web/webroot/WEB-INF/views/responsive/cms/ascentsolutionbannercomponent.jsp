<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:url value="${not empty page ? page.label : urlLink}#${fn:replace(headline,' ','')}" var="encodedUrl" />
<div class="disp-img simple-banner">
	<c:choose>
		<c:when test="${empty encodedUrl || encodedUrl eq '#'}">
			<div class="ascentThumb">
				<img title="${headline}" alt="${media.altText}" src="${media.url}">
			</div>
			<div class="ascentTitle">
				<h2>${headline}</h2>
			</div>
			<div class="ascentDetails">
				<p>${content}</p>
			</div>
			<div>
				<span class="acentExplore">Explore Products</span>
			</div>
		</c:when>
		<c:otherwise>
			<div class="ascentThumb">
				<img title="${headline}" alt="${media.altText}" src="${media.url}">
			</div>
			<div class="ascentTitle">
				<strong>${headline}</strong>
			</div>
			<div class="ascentDetails">${content}</div>
			<div>
				<a href="${encodedUrl}"> <span class="acentExplore">Explore
						Products</span>
				</a>
			</div>
		</c:otherwise>
	</c:choose>
</div>