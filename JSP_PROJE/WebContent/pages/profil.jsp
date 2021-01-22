<%-- 
    Document   : giris
    Created on : 12 Ara 2020, 02:32:43
    Author     : lenovo
--%>

<%@page import="com.proje.Kullanici"%>
<%@page import="com.proje.VeriTabani"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />
<title>Profil</title>

<link
	href="http://fonts.googleapis.com/css?family=Lato:100italic,100,300italic,300,400italic,400,700italic,700,900italic,900"
	rel="stylesheet" type="text/css">
<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css" href="css/login.css" />
<script src="js/jquery.min.js"></script>
<style type="text/css">
input[type=checkbox][disabled] {
	color: blue;
}
</style>
</head>
<body>

	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="kullanici" />
	</jsp:include>

	<%
	if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
		response.sendRedirect("giris.jsp");
	} else {
		Kullanici k = VeriTabani.getKullanici(String.valueOf(session.getAttribute("id")));

		String getUrunEkleDuzenleYetki = (k.getUrunEkleDuzenleYetki() == 1) ? "checked" : "";
		String getDepoEkleDuzenleYetki = (k.getDepoEkleDuzenleYetki() == 1) ? "checked" : "";
		String getKullaniciEkleDuzenleYetki = (k.getKullaniciEkleDuzenleYetki() == 1) ? "checked" : "";
		String getKullaniciGoruntulemeYetki = (k.getKullaniciGoruntulemeYetki() == 1) ? "checked" : "";
		String getKategoriGoruntulemeYetki = (k.getKategoriEkleDuzenleYetki() == 1) ? "checked" : "";
	%>

	<section class="container">
		<section class="login-form"
			style="width: 100% !important; max-width: 100% !important;">

			<form method="post" action="#" role="login" id="frm-profil">

				<label
					style="width: 100%; text-align: center; font-size: 27px; padding-bottom: 15px;">Yeni
					Kullanıcı Ekle</label>

				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Ad
						soyad</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="input-ad-soyad"
							name="input-ad-soyad" placeholder="<%=k.getAdiSoyadi()%>"
							required="required" onkeyup="inputEvent()">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputEmail3" class="col-sm-2 col-form-label">Kullanıcı
						Adı</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="input-kullanici-adi"
							name="input-kullanici-adi" placeholder="<%=k.getKullaniciAdi()%>"
							required="required" onkeyup="inputEvent()">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputPassword3" class="col-sm-2 col-form-label">Şifre</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="input-sifre"
							name="input-sifre" placeholder="***" required="required"
							onkeyup="inputEvent()">
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
											type="checkbox" <%=getUrunEkleDuzenleYetki%>
											disabled="disabled"> <label
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck1">Ürün ekleme düzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck2"
											type="checkbox" <%=getDepoEkleDuzenleYetki%>
											disabled="disabled"> <label
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck2">Depo ekleme düzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck3"
											type="checkbox" disabled="disabled"
											<%=getKullaniciEkleDuzenleYetki%>> <label
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck3">Kullanıcı ekleme duzenleme yetkisi</label>
									</div>
								</li>
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck4"
											type="checkbox" disabled="disabled"
											<%=getKullaniciGoruntulemeYetki%>> <label
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck4">Kullanıcıları görüntüleme yetkisi</label>
									</div>
								</li>
								
								<li class="list-group-item">
									<div class="custom-control custom-checkbox">
										<input class="custom-control-input" id="customCheck5"
											type="checkbox" disabled="disabled"
											<%=getKategoriGoruntulemeYetki%>> <label
											class="cursor-pointer font-italic d-block custom-control-label"
											for="customCheck4">Kategori ekleme düzenleme yetkisi</label>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</section>

				<div class="form-group row">
					<div class="col-sm-2"></div>
					<div class="col-sm-10">
						<button type="submit" class="btn btn-primary" data-toggle="modal"
							data-target="#exampleModal" style="width: 100%;"
							disabled="disabled" id="btn-profil-guncelle">Kaydet</button>
					</div>
				</div>
			</form>

		</section>
	</section>
	<%
	}
	%>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="exampleModalLabel">Eski şifreyi
						giriniz</h4>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<input type="password" class="form-control" id="input-eski-sifre"
						name="input-eski-sifre" placeholder="Şifre" required="required"
						onkeyup="inputEvent2()">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Kapat</button>
					<button type="button" class="btn btn-primary"
						id="btn-profil-guncelle-modal-button"
						onclick="kullaniciGuncelle()" disabled="disabled">Kaydet</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function inputEvent() {
			console.log($("#input-ad-soyad").val() + " --> "
					+ ($("#input-ad-soyad").val() == ""));
			console.log($("#input-kullanici-adi").val() + " --> "
					+ ($("#input-kullanici-adi").val() == ""));
			console.log($("#input-sifre").val() + " --> "
					+ ($("#input-sifre").val() == ""));

			if ($("#input-ad-soyad").val() == ""
					|| $("#input-kullanici-adi").val() == ""
					|| $("#input-sifre").val() == "") {
				$("#btn-profil-guncelle").attr("disabled", "disabled");
			} else {
				$("#btn-profil-guncelle").removeAttr("disabled");
			}
		}

		function inputEvent2() {
			if ($("#input-eski-sifre").val() == "") {
				$("#btn-profil-guncelle-modal-button").attr("disabled",
						"disabled");
			} else {
				$("#btn-profil-guncelle-modal-button").removeAttr("disabled");
			}
		}

		$('#frm-profil').submit(function(e) {
			e.preventDefault();
		});
	</script>

	<div class="alert-messages text-center"
		style="position: fixed; top: 10%; right: 50px; z-index: 7000; width: 20%;">
	</div>


	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/ajax.js"></script>
</body>
</html>