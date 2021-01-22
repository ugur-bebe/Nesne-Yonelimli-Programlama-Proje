<%-- 
    Document   : urun-ekle
    Created on : 12 Ara 2020, 23:38:49
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.proje.VeriTabani"%>
<%@page import="com.proje.Kategori"%>
<%@page import="com.proje.Depo"%>
<%@page import="java.util.List"%>

<%
if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
	response.sendRedirect("giris.jsp");
} else {

	if (session.getAttribute("urun_ekle_duzenle_yetki") == null
	|| session.getAttribute("urun_ekle_duzenle_yetki").equals("")) {
	
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css" />

<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet" href="css/table.css" />
<script src="js/jquery.min.js"></script>

<title>Ürün Ekle</title>


<style>
body {
	background: -webkit-linear-gradient(left, #0072ff, #00c6ff);
}

.contact-form {
	background: #fff;
	margin-top: 10%;
	margin-bottom: 5%;
	width: 70%;
}

.contact-form .form-control {
	border-radius: 1rem;
}

.contact-image {
	text-align: center;
}

.contact-image img {
	border-radius: 50%;
	width: 150px;
	margin-top: -3%;
	/* transform: rotate(29deg);*/
}

.contact-form form {
	padding: 10%;
}

.contact-form form .row {
	margin-bottom: -7%;
}

.contact-form h2 {
	margin-bottom: 4%;
	margin-top: -10%;
	text-align: center;
	color: #0062cc;
}

.contact-form .btnContact {
	width: 50%;
	border: none;
	border-radius: 1rem;
	padding: 1.5%;
	background: #dc3545;
	font-weight: 600;
	color: #fff;
	cursor: pointer;
}

.btnContactSubmit {
	width: 50%;
	border-radius: 1rem;
	padding: 1.5%;
	color: #fff;
	background-color: #0062cc;
	border: none;
	cursor: pointer;
}
</style>
</head>
<body>
	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="urun" />
	</jsp:include>


	<div class="container contact-form">
		<div class="contact-image">
			<img src="images/urun-ekle.png" alt="rocket_contact" />
		</div>
		<form method="post" id="frm-urun-ekle" style="padding-bottom: 6%;">
			<h2>
				<b>Ürün Kaydet</b>
			</h2>
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<label>Barkod</label> <input type="number" name="txtBarkod"
							id="txtBarkod" class="form-control" placeholder="Barkod Giriniz"
							required="required" value="" />
					</div>
					<div class="form-group">
						<label>Ürün Adı</label> <input type="text" name="txtUrunAdi"
							id="txtUrunAdi" class="form-control"
							placeholder="Ürün Adı Giriniz" value="" required="required" />
					</div>
					<div class="form-group">
						<label>Birim Fiyatı</label> <input type="number" min="0"
							id="txtBirimFiyatı" name="txtBirimFiyatı" class="form-control"
							placeholder="Miktarı Giriniz" value="" required="required" />
					</div>


				</div>
				<div class="col-md-6">
					<div class="form-group">
						<div class="form-group">
							<label>Kategori</label> <select class="form-control"
								id="select-kategori">
								<%
								List<Kategori> kategroList = VeriTabani.getTumKategoriData();
								for (Kategori k : kategroList) {
								%>
								<option value="<%=k.getId()%>"><%=k.getAdi()%></option>
								<%
								}
								%>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label>Kapladığı alan</label> <input type="number"
							id="txtKapladigiAlan" name="txtKapladigiAlan"
							class="form-control" placeholder="Kapladığı alanı giriniz"
							value="" required="required" />
					</div>
				</div>
			</div>
			<div class="form-group">
				<input type="submit" name="btnSubmit"
					style="width: 100%; margin-top: 20px;" class="btn btn-primary"
					value="Kaydet" />
			</div>
		</form>
	</div>

	<div class="alert-messages text-center"
		style="position: fixed; top: 10%; right: 50px; z-index: 7000; width: 20%;">
	</div>

	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/ajax.js"></script>
</body>
</html>

<%
}
}
%>