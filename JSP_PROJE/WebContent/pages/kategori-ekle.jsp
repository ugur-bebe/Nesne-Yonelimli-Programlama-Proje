<%-- 
    Document   : giris
    Created on : 12 Ara 2020, 02:32:43
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
	response.sendRedirect("giris.jsp");
} else {
	
	if (session.getAttribute("kategori_ekle_duzenle_yetki") == null
			|| session.getAttribute("kategori_ekle_duzenle_yetki").equals("")) {
			
				%>
				<jsp:include page='pieces/yetki-yok-page.jsp'>
					<jsp:param name="" value=""/>
				</jsp:include>
				<%
				
			} else {
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />
<title>Kategori Ekle</title>

<link
	href="http://fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900"
	rel="stylesheet" type="text/css">
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script src="js/jquery.min.js"></script>
</head>
<body>

	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="kategori" />
	</jsp:include>

	<section class="container">
		<section class="login-form"
			style="width: 100% !important; max-width: 100% !important;">

			<form method="post" action="" role="login" id="frm-kategori-ekle">

				<label
					style="width: 100%; text-align: center; font-size: 27px; padding-bottom: 15px;">Yeni
					Kategori Ekle</label>

				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Kategori adı</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="input-kategori-adi"
							name="input-kategori-adi" placeholder="Kategori adi" required="required">
					</div>
				</div>

				<div class="form-group row">
					<div class="col-sm-2"></div>
					<div class="col-sm-10">
						<button type="submit" class="btn btn-primary" style="width: 100%;" id="btn-kategori-kaydet">Kaydet</button>
					</div>
				</div>
			</form>

		</section>
	</section>

	<div class="alert-messages text-center"
		style="position: fixed; top: 10%; right: 50px; z-index: 7000; width: 20%;">
	</div>


	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/ajax.js"></script>
</body>
</html>
<%}}%>