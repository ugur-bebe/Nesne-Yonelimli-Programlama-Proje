<%-- 
    Document   : urun-duzenle
    Created on : 13 Ara 2020, 01:38:49
    Author     : lenovo
--%>

<%@page import="com.proje.VeriTabani"%>
<%@page import="com.proje.Kategori"%>
<%@page import="com.proje.Depo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
	if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
		response.sendRedirect("giris.jsp");
	} else {
		
		if (session.getAttribute("urun_ekle_duzenle_yetki") == null
		|| session.getAttribute("urun_ekle_duzenle_yetki").equals("")) {
	%>
	<jsp:include page='pieces/yetki-yok-page.jsp'>
		<jsp:param name="" value="" />
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

<title>Ürün Düzenle</title>


<style>
.modal {
	text-align: center;
	padding: 0 !important;
}

.modal:before {
	content: '';
	display: inline-block;
	height: 100%;
	vertical-align: middle;
	margin-right: -4px;
}

.modal-dialog {
	display: inline-block;
	text-align: left;
	vertical-align: middle;
}

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
	/* transform: rotate(29deg); */
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

@media only screen and (max-width: 998px) {
	.contact-form {
		width: 95%;
	}
}

@media only screen and (max-width: 760px) , ( min-device-width : 768px)
	and (max-device-width: 1024px) {
	/* Force table to not be like tables anymore */
	table, thead, tbody, th, td, tr {
		display: block;
	}

	/* Hide table headers (but not display: none;, for accessibility) */
	thead tr {
		position: absolute;
		top: -9999px;
		left: -9999px;
	}
	tr {
		border: 1px solid #ccc;
	}
	td {
		/* Behave  like a "row" */
		border: none;
		border-bottom: 1px solid #eee;
		position: relative;
		padding-left: 45% !important;
	}
	td:before {
		/* Now like a table header */
		position: absolute;
		/* Top/left values mimic padding */
		top: 6px;
		left: 6px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
	}
	td:nth-of-type(1):before {
		content: "#";
	}
	td:nth-of-type(2):before {
		content: "Barkod";
	}
	td:nth-of-type(3):before {
		content: "Ürün adı";
	}
	td:nth-of-type(4):before {
		content: "Miktarı";
	}
	td:nth-of-type(5) {
		content: "Depo";
	}
	td:nth-of-type(6) {
		content: "Birim Ücreti";
	}
	td:nth-of-type(7) {
		content: "Düzenle";
	}
}
</style>
</head>
<body>
	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="urun" />
	</jsp:include>


	<div class="container contact-form" id="_container">
		<div class="contact-image">
			<img src="images/urun-ara2.png" alt="rocket_contact" />
		</div>
		<form method="post" style="padding-bottom: 6%;" id="frm-filtre">
			<h2>
				<b>Ürün Ara</b>
			</h2>
			<div class="row">
				<div class="col-md-2">
					<label>Şuna Göre Ara</label> <select class="form-control"
						id="arama-secenekleri" onchange="changed()">
						<option value="barkod">Barkod</option>
						<option value="urunadi">Ürün Adı</option>
					</select>
				</div>

				<div class="col-md-4">
					<div class="form-group">
						<label id="arama-turu">Barkod</label> <input type="number"
							name="urun-adi" id="input-arama" class="form-control"
							placeholder="Barkod Giriniz" value="" />
					</div>
				</div>

				<div class="col-md-2">
					<label>Depo</label> <select class="form-control"
						id="select-filtre-depo" onchange="changed()">

						<option value="tumu">Tümü</option>
						<%
						List<Depo> depoList = VeriTabani.getTumDepoData();
						for (Depo d : depoList) {
						%>
						<option value="<%=d.getId()%>"><%=d.getAdi()%></option>
						<%
						}
						%>

					</select>
				</div>

				<div class="col-md-2">
					<div class="form-group">
						<label>Kategori</label> <select class="form-control"
							id="select-filtre-kategori">

							<option value="tumu">Tümü</option>
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


				<div class="col-md-2">
					<div class="form-group">
						<input type="submit" name="btnSubmit"
							style="width: 100%; margin-top: 20px;" class="btn btn-primary"
							id="btn-ara" value="Ara" />
					</div>
				</div>
			</div>
		</form>



		<div class="table-responsive" style="display: none;" id="data-table">
			<div class="table-wrapper" id="tabel-div"
				style="width: 100% !important;">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-4">
							<h4>
								<b id="bulunan-urun-tablo-baslik"></b>
							</h4>
						</div>
					</div>
				</div>

				<table class="table table-striped table-hover" id="table">
					<thead>
						<tr>
							<th>#</th>
							<th>Barkod</th>
							<th>Ürün Adı</th>
							<th>Miktarı</th>
							<th>Depo</th>
							<th>Kategori</th>
							<th>Birim Ücreti</th>
							<th>Düzenle</th>
						</tr>
					</thead>
					<tbody id="table-urunGuncelle-tbody">

					</tbody>
				</table>
				<div class="clearfix">
					<ul class="pagination" id="pagination">

					</ul>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-dialog-centered  modal-lg"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b>Ürün Bilgiler</b>
					</h4>
				</div>
				<div class="modal-body">
					<form method="post">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Barkod</label> <input type="number" name="txtBarkod"
										id="txtBarkod" class="form-control"
										placeholder="Barkod Giriniz" value="" />
								</div>
								<div class="form-group">
									<label>Ürün Adı</label> <input type="text" name="txtUrunAdi"
										id="txtUrunAdi" class="form-control"
										placeholder="Ürün Adı Giriniz" value="" />
								</div>
								<div class="form-group">
									<label>Miktarı</label> <input type="number" name="txtMiktar"
										id="txtMiktar" class="form-control"
										placeholder="Miktarı Giriniz" value="" />
								</div>


							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="form-group">
										<label>Depo:</label> <select class="form-control"
											id="select-depo">

											<%
											for (Depo d : depoList) {
											%>
											<option value="<%=d.getId()%>"><%=d.getAdi()%></option>
											<%
											}
											%>

										</select>
									</div>

									<div class="form-group">
										<label>Kategori</label> <select class="form-control"
											id="select-kategori">
											<%
											for (Kategori k : kategroList) {
											%>
											<option value="<%=k.getId()%>"><%=k.getAdi()%></option>
											<%
											}
											%>
										</select>
									</div>
									<div class="form-group">
										<label>Birim Ücretii</label> <input type="number"
											name="txtUcret" id="txtUcret" class="form-control"
											placeholder="Birim Ücretini Giriniz" value="" />
									</div>

								</div>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<input type="submit" name="btnSubmit" id="btnUpdate"
						class="btn btn-primary" value="Ürünü Güncelle" /> <input
						type="submit" name="btnDelete" id="btnDelete"
						class="btn btn-danger" value="Ürünü Sil" />
					<button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		function changed() {
			$("#arama-turu").text($("#arama-secenekleri").val());
			if ($("#arama-secenekleri").val() == "barkod") {
				$("#input-arama").attr("type", "number");
			} else {
				$("#input-arama").attr("type", "text");
			}
			$("#input-arama").attr("placeholder",
					$("#arama-secenekleri").val() + " Giriniz");
		}
	</script>

	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/ajax.js"></script>
</body>
</html>
<%}}%>
