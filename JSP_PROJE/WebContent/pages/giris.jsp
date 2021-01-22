<%-- 
    Document   : giris
    Created on : 12 Ara 2020, 02:32:43
    Author     : lenovo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
	session.removeAttribute("id");
	session.removeAttribute("kullanici_ekle_duzenle_yetki");
	session.removeAttribute("kategori_ekle_duzenle_yetki");
	session.removeAttribute("urun_ekle_duzenle_yetki");
	session.removeAttribute("depo_ekle_duzenle_yetki");
	session.removeAttribute("kullanici_goruntule_yetki");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />
<title>Giriş Yap</title>

<link
	href="http://fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script src="js/jquery.min.js"></script>
</head>
<body>

	<section class="container">
		<section class="login-form">
			<form method="post" action="" role="login" id="frm-giris">
				<img src="images/login-logo.png" class="img-responsive" alt=""
					style="width: 130px;" />

				<h2 style="padding-bottom: 15px; text-align: center;">
					<b>Stok Takip Giriş</b>
				</h2>

				<input type="text" name="kullanici_adi" placeholder="Kullanıcı Adı"
					id="kullanici-adi" required class="form-control input-lg" /> <input
					type="password" id="sifre" name="sifre" placeholder="Şifre"
					required class="form-control input-lg" />
				<button type="submit" name="go"
					class="btn btn-lg btn-primary btn-block">Giriş</button>
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
</body>
</html>