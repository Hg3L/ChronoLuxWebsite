<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ include file="/common/taglib.jsp" %>
		<!DOCTYPE html>
		<html>

		<head>
			<title>ChronoLux</title>
			<meta charset="utf-8">
			<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		</head>

		<body>
			<section class="ftco-section">
				<div class="container">

					<div class="row justify-content-center">
						<div class="col-md-6 text-center mb-5">
							<h2 class="heading-section">Login</h2>
						</div>

					</div>
					<div class="row justify-content-center">

						<div class="col-md-12 col-lg-10">
							<div class="wrap d-md-flex">

								<div class="img"
									style="background-image: url(<c:url value='/template/login/img/bg-1.jpg'/>);">
								</div>
								<div class="login-wrap p-4 p-md-5">
									<div class="d-flex">
										<div class="w-100">
											<h3 class="mb-4">Sign In</h3>
										</div>
										<div class="w-100">
											<p class="social-media d-flex justify-content-end">
												<a href="#"
													class="social-icon d-flex align-items-center justify-content-center"><span
														class="fa fa-facebook"></span></a>
												<a href="#"
													class="social-icon d-flex align-items-center justify-content-center"><span
														class="fa fa-google"></span></a>
											</p>
										</div>
									</div>
									<form action="<c:url value='/j_spring_security_check'/>" id ="formLogin" method="post" class="signin-form">
										<div class="form-group mb-3">
											<label class="label" for="name">Username</label>
											<input type="text" class="form-control" name="j_username"
												placeholder="Username" required>
										</div>
										<div class="form-group mb-3">
											<label class="label" for="password">Password</label>
											<input type="password" class="form-control" name="j_password"
												placeholder="Password" required>
										</div>
										<c:if test = "${param.incorrectAccount != null}">
										    <div class="alert alert-danger " role="alert" style="text-align: center;">
                                                User invalid
                                            </div>
										</c:if>
                                        <c:if test = "${param.accessDenied != null}">
										    <div class="alert alert-danger" role="alert" style="text-align: center;">
                                                You Not Authorize
                                            </div>
										</c:if>
										<div class="form-group">
											<button type="submit" class="form-control btn btn-primary rounded submit px-3">
											Sign In</button>
										</div>
										<div class="form-group d-md-flex">
											<div class="w-50 text-left">
												<label class="checkbox-wrap checkbox-primary mb-0">Remember Me
													<input type="checkbox" checked>
													<span class="checkmark"></span>
												</label>
											</div>
											<div class="w-50 text-md-right">
												<a href="#">Forgot Password</a>
											</div>
										</div>
									</form>
									<p class="text-center">Not a member? <a href="<c:url value='/login/register'/>">Sign Up</a>
									</p>
								</div>
							</div>
						</div>

					</div>

				</div>
			</section>


		</body>

		</html>