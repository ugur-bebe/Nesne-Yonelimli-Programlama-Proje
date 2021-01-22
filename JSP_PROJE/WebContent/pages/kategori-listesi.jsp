<%-- 
    Document   : giris
    Created on : 12 Ara 2020, 02:32:43
    Author     : lenovo
--%>

<%@page import="com.proje.Kategori"%>
<%@page import="com.proje.VeriTabani"%>
<%@page import="com.proje.Kullanici"%>
<%@page import="java.util.List"%>
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
<title>Kategori Listesi</title>

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
	
	<section class="container" style="width: 90%;">
		<form method="post" action="" role="login">
			<div class="container">
				<h2 style="margin-bottom: 50px;"><strong>Kategori Listesi</strong></h2>

				<div class="panel-group" id="accordion" style="text-align: left;">

					<%
					List<Kategori> kategoriData = VeriTabani.getTumKategoriData();
					int sayac = 0;
					for (Kategori k : kategoriData) {
						sayac++;
					%>

					<div class="panel panel-default" id="collapse_<%=k.getId()%>">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion" id="c_<%=k.getId()%>"
									href="#collapse<%=k.getId()%>"><strong>#<%=sayac%></strong>
									<%=k.getAdi()%></a>
							</h4>
						</div>
						<div id="collapse<%=k.getId()%>"
							class="panel-collapse collapse <%=(sayac == 1) ? "in" : ""%>">
							<div class="panel-body">
								<div class="row">
									<div class="col-sm-12">

										<label style="padding-left: 15px;">Miktarı</label>
										<div class="form-group">

											<div class="col-sm-8">
												<input type="text" id="txtKategoriAdi<%=k.getId()%>"
													name="txtKategoriAdi" value="<%=k.getAdi().replace("-", "")%>"
													class="form-control" placeholder="Kategori adını giriniz"/>
											</div>
											<div class="col-sm-2"
												style="padding-right: 4px; padding-left: 0px;">
												<button type="button" class="btn btn-success"
													onclick="kategoriGuncelle('<%=k.getId()%>')"
													style="width: 100%; font-size: 14px;" >Kategori
													güncelle</button>
											</div>

											<div class="col-sm-2"
												style="padding-right: 4px; padding-left: 0px;">
												<button type="button" class="btn btn-danger"
													onclick="kategoriSil('<%=k.getId()%>')"
													style="width: 100%; font-size: 14px;">Kategori sil</button>
											</div>
										</div>
									</div>


								</div>
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
}
%>