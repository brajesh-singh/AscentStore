<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="formElement" tagdir="/WEB-INF/tags/responsive/formElement" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>

<link rel="stylesheet" type="text/css" href="${themeResourcePath}/css/pwc-os-v1.css">

    <section class="content-block">
		<div class="container">
			<div class="row">
				<div class="col-sm-12 wow fadeInLeft">
					<h2 class="content-block-header">My ACCOUNT</h2>
				</div>
			</div>
		</div>

		<div class="container">
			<ul class="nav nav-tabs dcp-tabs" role="tablist">
				<li role="presentation" class="active"><a class=""
					data-target="#profile" role="tab" data-toggle="tab">Profile</a></li>
				<li role="presentation" class=""><a class=""
					data-target="#payment-info" role="tab" data-toggle="tab">Payment
						Info</a></li>
				<li role="presentation" class=""><a class=""
					data-target="#my-products" role="tab" data-toggle="tab">My
						Products</a></li>
			</ul>

			<div class="tab-content">

				<div role="tabpanel" class="tab-pane active " id="profile">
					<section id="pricing" class="content-block">
						<%-- <form id="configure" role="form" class="form-horizontal"> --%>
						<form:form id="configure" role="form" class="form-horizontal" action="update-profile" method="post" commandName="updateProfileForm">
							<div class="container">
								<div class="row">
									<div class="col-sm-6">
										<div class="wow fadeInLeft">
											<div class="content-block-desc">
												<formElement:formSelectBox idKey="profile.title" labelKey="profile.title" path="titleCode" mandatory="true" skipBlank="false" skipBlankMessageKey="form.select.empty" items="${titleData}" selectCSSClass="form-control"/>
											<formElement:formInputBox idKey="profile.firstName"
												labelKey="profile.firstName" path="firstName"
												inputCSS="text" mandatory="true" />
											<formElement:formInputBox idKey="profile.lastName"
												labelKey="profile.lastName" path="lastName" inputCSS="text"
												mandatory="true" />

											<div class="form-group">
													<!-- <a href="#" class="btn btn-default btn-sm">Cancel</a> <a
														href="#" class="btn btn-default btn-sm">Save</a> -->
													<ycommerce:testId code="personalDetails_savePersonalDetails_button">
														<button type="submit" class="btn btn-default btn-sm">
															<spring:theme code="text.account.profile.saveUpdates"
																text="Save Updates" />
														</button>
													</ycommerce:testId>

													<ycommerce:testId code="personalDetails_cancelPersonalDetails_button">
														<button type="button"
															class="btn btn-default btn-sm">
															<spring:theme code="text.account.profile.cancel"
																text="Cancel" />
														</button>
													</ycommerce:testId>
												</div>
											</div>
										</div>
									</div>

									<div class="col-sm-6 text-center">
									<c:url value="/my-account/update-password" var="changePasswordUrl" />
										<a href="${changePasswordUrl}" class="btn btn-warning">CHANGE PASSWORD</a>
									</div>

								</div>
							</div>
						</form:form>
					</section>
				</div>

				<div role="tabpanel" class="tab-pane" id="payment-info">
					<section id="pricing" class="content-block">
					<c:choose>
						<c:when test="${not empty paymentInfoData}">
							<div class="account-paymentdetails account-list">
								<div class="account-cards card-select">
									<div class="row">
										<c:forEach items="${paymentInfoData}" var="paymentInfo">
											<div class="col-xs-12 col-sm-6 col-md-4 card">
												<ul class="pull-left">
													<li><c:if test="${paymentInfo.defaultPaymentInfo}">
															<strong>
														</c:if> ${fn:escapeXml(paymentInfo.accountHolderName)}<c:if
															test="${paymentInfo.defaultPaymentInfo}">&nbsp;(<spring:theme
																code="text.default" />)</c:if> <c:if
															test="${paymentInfo.defaultPaymentInfo}">
															</strong>
														</c:if></li>
													<li>${fn:escapeXml(paymentInfo.cardTypeData.name)}</li>
													<li><ycommerce:testId
															code="paymentDetails_item_cardNumber_text">${fn:escapeXml(paymentInfo.cardNumber)}</ycommerce:testId>
													</li>
													<li><c:if test="${paymentInfo.expiryMonth lt 10}">0</c:if>
														${fn:escapeXml(paymentInfo.expiryMonth)}&nbsp;/&nbsp;${fn:escapeXml(paymentInfo.expiryYear)}
													</li>
													<c:if test="${paymentInfo.billingAddress ne null}">
														<li>${fn:escapeXml(paymentInfo.billingAddress.line1)}</li>
														<li>${fn:escapeXml(paymentInfo.billingAddress.town)}&nbsp;${fn:escapeXml(paymentInfo.billingAddress.region.isocodeShort)}</li>
														<li>${fn:escapeXml(paymentInfo.billingAddress.country.name)}&nbsp;${fn:escapeXml(paymentInfo.billingAddress.postalCode)}</li>
													</c:if>
												</ul>
												<div class="account-cards-actions pull-left">
													<ycommerce:testId
														code="paymentDetails_deletePayment_button">
														<a class="action-links removePaymentDetailsButton"
															href="#"
															data-payment-id="${fn:escapeXml(paymentInfo.id)}"
															data-popup-title="<spring:theme code="text.account.paymentDetails.delete.popup.title"/>">
															<span class="glyphicon glyphicon-remove"></span>
														</a>
													</ycommerce:testId>
												</div>
												<c:if test="${not paymentInfo.defaultPaymentInfo}">
													<c:url value="/my-account/set-default-payment-details"
														var="setDefaultPaymentActionUrl" />
													<form:form
														id="setDefaultPaymentDetails${fn:escapeXml(paymentInfo.id)}"
														action="${setDefaultPaymentActionUrl}" method="post">
														<input type="hidden" name="paymentInfoId"
															value="${fn:escapeXml(paymentInfo.id)}" />
														<ycommerce:testId
															code="paymentDetails_setAsDefault_button">
															<button type="submit" class="account-set-default-address">
																<spring:theme code="text.setDefault" />
															</button>
														</ycommerce:testId>
													</form:form>
												</c:if>
											</div>

											<div class="display-none">
												<div
													id="popup_confirm_payment_removal_${fn:escapeXml(paymentInfo.id)}"
													class="account-address-removal-popup">
													<spring:theme
														code="text.account.paymentDetails.delete.following" />
													<div class="address">
														<strong>
															${fn:escapeXml(paymentInfo.accountHolderName)} </strong> <br>${fn:escapeXml(paymentInfo.cardTypeData.name)}
														<br>${fn:escapeXml(paymentInfo.cardNumber)} <br>
														<c:if test="${paymentInfo.expiryMonth lt 10}">0</c:if>
														${fn:escapeXml(paymentInfo.expiryMonth)}&nbsp;/&nbsp;${fn:escapeXml(paymentInfo.expiryYear)}
														<c:if test="${paymentInfo.billingAddress ne null}">
															<br>${fn:escapeXml(paymentInfo.billingAddress.line1)}
	                                    <br>${fn:escapeXml(paymentInfo.billingAddress.town)}&nbsp;${fn:escapeXml(paymentInfo.billingAddress.region.isocodeShort)}
	                                    <br>${fn:escapeXml(paymentInfo.billingAddress.country.name)}&nbsp;${fn:escapeXml(paymentInfo.billingAddress.postalCode)}
	                                </c:if>
													</div>
													<c:url value="/my-account/remove-payment-method"
														var="removePaymentActionUrl" />
													<form:form
														id="removePaymentDetails${fn:escapeXml(paymentInfo.id)}"
														action="${removePaymentActionUrl}" method="post">
														<input type="hidden" name="paymentInfoId"
															value="${fn:escapeXml(paymentInfo.id)}" />
														<br />
														<div class="modal-actions">
															<div class="row">
																<ycommerce:testId
																	code="paymentDetailsDelete_delete_button">
																	<div class="col-xs-12 col-sm-6 col-sm-push-6">
																		<button type="submit"
																			class="btn btn-default btn-primary btn-block paymentsDeleteBtn">
																			<spring:theme
																				code="text.account.paymentDetails.delete" />
																		</button>
																	</div>
																</ycommerce:testId>
																<div class="col-xs-12 col-sm-6 col-sm-pull-6">
																	<a
																		class="btn btn-default closeColorBox paymentsDeleteBtn btn-block"
																		data-payment-id="${fn:escapeXml(paymentInfo.id)}">
																		<spring:theme code="text.button.cancel" />
																	</a>
																</div>
															</div>
														</div>
													</form:form>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="account-section-content content-empty">
								<spring:theme
									code="text.account.paymentDetails.noPaymentInformation" />
							</div>
						</c:otherwise>
					</c:choose>
				</section>
				</div>

				<div role="tabpanel" class="tab-pane" id="my-products"
					style="min-height: 450px;">
					<section id="products-list" class="content-block">
					<c:if test="${not empty subscriptions}">
						<%-- <div class="description">
							<spring:theme
								code="text.account.subscriptions.manageSubscriptions"
								text="Manage your subscriptions" />
						</div> --%>

						<table class="subscriptionsTable">
							<thead>
								<tr>
									<th><spring:theme
											code="text.account.subscriptions.productName"
											text="Product Name" /></th>
									<th><spring:theme
											code="text.account.subscriptions.startDate" text="Start Date" /></th>
									<th><spring:theme
											code="text.account.subscriptions.endDate" text="End Date" /></th>
									<th class="subscriptionsTableState"><spring:theme
											code="text.account.subscriptions.status" text="Status" /></th>
									<%-- <th class="subscriptionsTablePayment"><spring:theme
											code="text.account.subscriptions.paymentDetails"
											text="Payment Details" /></th> --%>
									<th class="subscriptionsTableAction" style="display:none"><spring:theme
											code="text.account.orderHistory.actions" text="Actions" /></th>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${subscriptions}" var="subscription">

									<c:url value="/my-account/subscription/${subscription.id}"
										var="myAccountSubscriptionDetailsUrl" />
									<c:url value="${subscription.productUrl}"
										var="productDetailsUrl" />

									<tr>
										<td><ycommerce:testId
												code="subscriptions_productName_link">
												<a href="${productDetailsUrl}">${subscription.name}</a>
											</ycommerce:testId></td>
										<td><ycommerce:testId
												code="subscriptions_startDate_label">
												<fmt:formatDate value="${subscription.startDate}"
													dateStyle="long" timeStyle="short" type="date" />
											</ycommerce:testId></td>
										<td><ycommerce:testId code="subscriptions_endDate_label">
												<fmt:formatDate value="${subscription.endDate}"
													dateStyle="long" timeStyle="short" type="date" />
											</ycommerce:testId></td>
										<td><ycommerce:testId code="subscriptions_status_label">
                                ${subscription.subscriptionStatus}
                            </ycommerce:testId></td>
										<%-- <td><ycommerce:testId code="subscriptions_status_label">
												<c:if
													test="${not empty paymentInfoMap[subscription.paymentMethodId]}">
													<c:set
														value="${paymentInfoMap[subscription.paymentMethodId]}"
														var="paymentMethod"></c:set>
													<c:set
														value="${fn:length(paymentMethod.expiryMonth) lt 2 ? '0'.concat(paymentMethod.expiryMonth) : paymentMethod.expiryMonth}"
														var="paymentMethodExpiryMonth"></c:set>
													<spring:theme
														code="text.account.subscriptions.payment.details"
														arguments="${fn:substring(paymentMethod.cardTypeData.name,0,4)},${fn:replace(paymentMethod.cardNumber,'*','')},${paymentMethodExpiryMonth},${paymentMethod.expiryYear}"
														text="" />
												</c:if>

												<c:if test="${not empty subscription.paymentMethodId}">
													<spring:theme
														code="text.account.subscriptions.payment.costcenter"
														arguments="${subscription.paymentMethodId}" />
												</c:if>
											</ycommerce:testId></td> --%>
										<td>
											<%-- <a href="${myAccountSubscriptionDetailsUrl}"
											class="function_btn"> <spring:theme code="text.manage"
													text="Manage" />
											</a>  --%>
											<a href="${productDetailsUrl}" class="btn btn-warning btn-xs">Buy</a>
											<c:if test="${fn:toUpperCase(subscription.subscriptionStatus) ne 'PAUSED' and fn:toUpperCase(subscription.subscriptionStatus) ne 'CANCELLED'
                            and !empty subscriptionFacade.getUpsellingOptionsForSubscription(subscription.productCode)}">
												<c:url
													value="/my-account/subscription/upgrades-comparison?subscriptionId=${subscription.id}"
													var="upgradeSubscriptionComparisionUrl" />
												<a type="button" href="${upgradeSubscriptionComparisionUrl}"
													class="button secondary"> <spring:theme
														code="text.account.subscription.upgradeSubscription"
														text="Upgrade Subscription" />
												</a>
											</c:if> <c:if
												test="${fn:toUpperCase(subscription.subscriptionStatus) eq 'PAUSED' and fn:toUpperCase(subscription.subscriptionStatus) ne 'CANCELLED'}">
												<c:url value="/my-account/subscription/change-state"
													var="changeSubscriptionStateUrl" />
												<form:form class="resume_subscription_form"
													id="resumeSubscriptionForm"
													action="${changeSubscriptionStateUrl}" method="post">
													<button type="submit" class="positive">
														<spring:theme
															code="text.account.subscription.resumeSubscription"
															text="Resume Subscription" />
													</button>
													<input type="hidden" name="newState" value="ACTIVE" />
													<input type="hidden" name="subscriptionId"
														value="${subscription.id}" />
												</form:form>
											</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>

					<c:if test="${empty subscriptions}">
						<div class="account-section-content content-empty">
							<p class="emptyMessage">
								<spring:theme code="text.account.subscriptions.noSubscriptions"
									text="You have no subscriptions" />
							</p>
						</div>
					</c:if>
				</section>
				</div>
			</div>
		</div>
	</section>