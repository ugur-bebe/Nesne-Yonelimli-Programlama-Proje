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
	
	if (session.getAttribute("kullanici_ekle_duzenle_yetki") == null
			|| session.getAttribute("kullanici_ekle_duzenle_yetki").equals("")) {
			
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
<title>Kullanıcı Ekle</title>

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
		<jsp:param name="page" value="kullanici" />
	</jsp:include>

	<section class="container">
		<section class="login-form"
			style="width: 100% !important; max-width: 100% !important;">

			<form method="post" action="" role="login" id="frm-kullanici-ekle">

				<label
					style="width: 100%; text-align: center; font-size: 27px; padding-bottom: 15px;">Yeni
					Kullanıcı Ekle</label>

				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Ad
						soyad</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="input-ad-soyad"
							name="input-ad-soyad" placeholder="Ad soyad" required="required">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Kullanıcı
						Adı</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="input-kullanici-adi"
							name="input-kullanici-adi" placeholder="Kullanıcı Adı" required="required">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputPassword3" class="col-sm-2 col-form-label">Şifre</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="input-sifre"
							name="input-sifre" placeholder="Şifre" required="required">
					</div>
				</div>

				<section>
					<div class="row">
						<div class="col-sm-2">
							<label for="inputEmail3" class="col-sm-2 col-form-label"
								style="width: 100%; text-align: center;">Yetkiler</label>
						</div>
						<div class="col-sm-10">
							<ul class="list-group">
								<li class="list-group-item rounded-0">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck1"
											type="checkbox"> <label
											name="kullanici-ekleme-duzenleme-yetkisi"
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck1">Ürün ekleme düzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck2"
											type="checkbox"> <label name="depo-ekleme-duzenleme-yekisi"
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck2">Depo ekleme düzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck3"
											type="checkbox"> <label name = "kullanici-ekleme-duzenlelme-yetkisi"
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck3">Kullanıcı ekleme duzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck4"
											type="checkbox"> <label name="kullanicilari-goruntuleme-yetkisi"
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck4">Kullanıcıları görüntüleme yetkisi</label>
									</div>
								</li>
								
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck5"
											type="checkbox"> <label name="kategori-ekleme-duzenlelme-yetkisi"
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck5">Kategori ekleme düzenleme yetkisi</label>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</section>

				<div class="form-group row">
					<div class="col-sm-2"></div>
					<div class="col-sm-10">
						<button type="submit" class="btn btn-primary" style="width: 100%;" id="btn-kullanici-kaydet">Kaydet</button>
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
<%
	}
}%>