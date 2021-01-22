<%-- 
    Document   : giris
    Created on : 12 Ara 2020, 02:32:43
    Author     : lenovo
--%>

<%@page import="com.proje.VeriTabani"%>
<%@page import="com.proje.Kullanici"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
boolean duzenlemeYetkisi = true;
if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
	response.sendRedirect("giris.jsp");
} else {
	
	if (session.getAttribute("kullanici_goruntule_yetki") == null
			|| session.getAttribute("kullanici_goruntule_yetki").equals("")) {
			
				%>
				<jsp:include page='pieces/yetki-yok-page.jsp'>
					<jsp:param name="" value="" />
				</jsp:include>
				<%
								
			} else {
				
				if (session.getAttribute("kullanici_ekle_duzenle_yetki") == null
						|| session.getAttribute("kullanici_ekle_duzenle_yetki").equals("")) {
						
							duzenlemeYetkisi = false;
							
						} 
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1,initial-scale=1,user-scalable=1" />
<title>Kullanıcı Listesi</title>

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
	<section class="container" style="width: 90%;">
		<form method="post" action="" role="login">
			<div class="container">
				<h2 style="margin-bottom: 50px;">Kullanıcı Listesi</h2>

				<div class="panel-group" id="accordion" style="text-align: left;">

					<%
					List<Kullanici> kullaniciList = VeriTabani.getKullaniciList();
					int sayac = 0;
					for (Kullanici k : kullaniciList) {
						sayac++;
	
						String getUrunEkleDuzenleYetki = (k.getUrunEkleDuzenleYetki() == 1) ? "checked" : "";
						String getDepoEkleDuzenleYetki = (k.getDepoEkleDuzenleYetki() == 1) ? "checked" : "";
						String getKullaniciEkleDuzenleYetki = (k.getKullaniciEkleDuzenleYetki() == 1) ? "checked" : "";
						String getKullaniciGoruntulemeYetki = (k.getKullaniciGoruntulemeYetki() == 1) ? "checked" : "";
						String getKategoriEkleDuzenleYetki = (k.getKategoriEkleDuzenleYetki() == 1) ? "checked" : "";
					%>

					<div class="panel panel-default" id="collapse_<%=k.getId()%>">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapse<%=k.getId()%>"><strong>#<%=sayac %></strong> <%=k.getAdiSoyadi()%></a>
							</h4>
						</div>
						<div id="collapse<%=k.getId()%>" class="panel-collapse collapse <%= (sayac == 1)? "in" : "" %>">
							<div class="panel-body">
								<section>
									<div class="row">
										<div class="col-sm-12">
											<ul class="list-group">
												<li class="list-group-item rounded-0"
													style="height: 50px; font-size: 21px;"><label
													for="inputEmail3" class="col-sm-2 col-form-label"
													style="width: 100%; text-align: center;">Yetkileri</label></li>
												<li class="list-group-item rounded-0">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="customCheck<%=k.getId()%>_1"
															type="checkbox" <%=getUrunEkleDuzenleYetki%>> <label
															class="cursor-pointer font-italic d-block custom-control-label"
															for="customCheck<%=k.getId()%>_1">Ürün ekleme
															düzenleme yetkisi</label>
													</div>
												</li>
												<li class="list-group-item">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="customCheck<%=k.getId()%>_2"
															type="checkbox" <%=getDepoEkleDuzenleYetki%>> <label
															class="cursor-pointer font-italic d-block custom-control-label"
															for="customCheck<%=k.getId()%>_2">Depo ekleme
															 yetkisi</label>
													</div>
												</li>
												<li class="list-group-item">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="customCheck<%=k.getId()%>_3"
															type="checkbox" <%=getKullaniciEkleDuzenleYetki%>>
														<label
															class="cursor-pointer font-italic d-block custom-control-label"
															for="customCheck<%=k.getId()%>_3">Kullanıcı ekleme
															duzenleme yetkisi</label>
													</div>
												</li>
												<li class="list-group-item">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="customCheck<%=k.getId()%>_4"
															type="checkbox" <%=getKullaniciGoruntulemeYetki%>>
														<label
															class="cursor-pointer font-italic d-block custom-control-label"
															for="customCheck<%=k.getId()%>_4">Kullanıcıları
															görüntüleme yetkisi</label>
													</div>
												</li>
												<li class="list-group-item">
													<div class="custom-control custom-checkbox">
														<input class="custom-control-input" id="customCheck<%=k.getId()%>_5"
															type="checkbox" <%=getKategoriEkleDuzenleYetki%>>
														<label
															class="cursor-pointer font-italic d-block custom-control-label"
															for="customCheck<%=k.getId()%>_5">Kategori ekleme düzenleme yetkisi</label>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</section>

								<%
									if(duzenlemeYetkisi){
								%>
								<div style="">
									<div class="col-sm-8"></div>

									<div class="col-sm-2"
										style="padding-right: 4px; padding-left: 0px;">
										<button type="button" class="btn btn-success"
										onclick="kullaniciYetkiGuncelle('<%=k.getId()%>')"
											style="width: 100%; font-size: 14px;">Yetkileri
											güncelle</button>
									</div>

									<div class="col-sm-2"
										style="padding-right: 4px; padding-left: 0px;">
										<button type="button" class="btn btn-danger"
											onclick="kullaniciSil('<%=k.getId()%>')"
											style="width: 100%; font-size: 14px;">Kullanıcıyı
											sil</button>
									</div>
								</div>
								<%} %>
							</div>
						</div>
					</div>
					<%
					}
					%>


				</div>
			</div>
		</form>
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