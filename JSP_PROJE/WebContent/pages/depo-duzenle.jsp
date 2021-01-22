<%-- 
    Document   : urun-ekle
    Created on : 12 Ara 2020, 23:38:49
    Author     : lenovo
--%>
<%
if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
	response.sendRedirect("giris.jsp");
} else {
	if (session.getAttribute("depo_ekle_duzenle_yetki") == null
			|| session.getAttribute("depo_ekle_duzenle_yetki").equals("")) {
			
				%>
				<jsp:include page='pieces/yetki-yok-page.jsp'>
					<jsp:param name="" value=""/>
				</jsp:include>
				<%
				
			} else {
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

<title>Depo Listesi</title>


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

.canvasjs-chart-canvas {
	width: 100%;
}

.canvasjs-chart-canvas:nth-of-type(1) {
	position: absolute;
}

.canvasjs-chart-canvas:nth-of-type(2) {
	position: inherit !important;
}

.canvasjs-chart-credit {
	display: none;
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
		content: "Depo Adı";
	}
	td:nth-of-type(3):before {
		content: "Depo Boyutu";
	}
	td:nth-of-type(4):before {
		content: "Doluluk Oraı";
	}
	td:nth-of-type(5):before {
		content: "Düzenle";
	}
}
</style>
</head>
<body>
	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="depo" />
	</jsp:include>


	<div class="container contact-form">
		<div class="contact-image">
			<img src="images/urun-ara2.png" alt="rocket_contact" />
		</div>
		<form method="post" style="padding-bottom: 6%;" id="frm-update-depo">
			<h2>
				<b>Depo Ara</b>
			</h2>
			<div class="row">

				<div class="col-lg-4">
					<div class="form-group">
						<label id="arama-turu">Depo Adı</label> <input type="text"
							name="depo-adi" id="filtre-depo-adi" class="form-control"
							placeholder="Depo adı giriniz" value="" />
					</div>
				</div>

				<div class="col-lg-2">
					<div class="form-group">
						<label id="arama-turu">Depo min boyut</label> <input type="number"
							name="depo-adi" id="filtre-depo-min-boyut" class="form-control"
							placeholder="Depo adı giriniz" value="" />
					</div>
				</div>

				<div class="col-lg-2">
					<div class="form-group">
						<label id="arama-turu">Depo max boyut</label> <input type="number"
							name="depo-adi" id="filtre-depo-max-boyut" class="form-control"
							placeholder="Depo adı giriniz" value="" />
					</div>
				</div>

				<div class="col-lg-2">
					<div class="form-group">
						<label>Depo doluluk oranı</label> <select class="form-control"
							id="filtre-depo-doluluk-orani">
							<option value="0-100">Tümü</option>
							<option value="0-25">%0 ve %25 arası</option>
							<option value="25-50">%25 ve %50 arası</option>
							<option value="50-75">%50 ve %75 arası</option>
							<option value="75-100">%75 ve %100 arası</option>
							<option value="0-50">%0 ve %50 arası</option>
							<option value="50-100">%50 ve %100 arası</option>
							<option value="100">Tam dolu olanlar</option>
						</select>
					</div>
				</div>

				<div class="col-lg-2">
					<div class="form-group">
						<input type="submit" name="btnSubmit" id="btnDepoGuncelle"
							style="width: 100%; margin-top: 20px;" class="btn btn-primary"
							value="Ara" />
					</div>
				</div>
			</div>
		</form>


		<div class="table-responsive" style="display: block;" id="data-table">
			<div class="table-wrapper" id="tabel-div">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-4">
							<h4>
								<b id="bulunan-urun-tablo-baslik">Toplamda 8 Ürün Bulundu</b>
							</h4>
						</div>
					</div>
				</div>

				<table class="table table-striped table-hover" id="table">
					<thead>
						<tr>
							<th>#</th>
							<th>Depo Adı</th>
							<th>Depo Boyutu</th>
							<th>Doluluk Oranı</th>
							<th></th>
						</tr>
					</thead>
					<tbody id="table-depoGuncelle-tbody">

					</tbody>
				</table>
				<div class="clearfix">
					<ul class="pagination" id="pagination">
						<li class="page-item " id="pagination_prev"><a href="#"
							onclick="paginationBackOrForward(2);">Önceki</a></li>
						<li class="page-item " id="pagination_1"><a href="#"
							class="page-link" onclick="changePagination('1');">1</a></li>
						<li class="page-item active" id="pagination_2"><a href="#"
							class="page-link" onclick="changePagination('2');">2</a></li>
						<li class="page-item disabled" id="pagination_next"><a
							href="#" class="page-link" onclick="paginationBackOrForward(1);">Sonraki</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="myModal2" role="dialog">
		<div class="modal-dialog modal-dialog-centered modal-lg"
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
									<label>Depo Adı</label> <input type="text" name="txtDepoAdi"
										id="txtDepoAdi" class="form-control"
										placeholder="Depo adınız giriniz" value="" />
								</div>
								<div class="form-group">
									<label>Depo boyutu</label> <input type="number"
										name="txtDepoBoyutu" id="txtDepoBoyutu" class="form-control"
										placeholder="Depo boyutunu giriniz" value="" />
								</div>

								<div class="form-group">
									<label>Depo doluluk oranı</label> <input type="number"
										name="txtDepoDolulukOrani" id="txtDepoDolulukOrani"
										class="form-control" placeholder="Birim Ücretini Giriniz"
										value="" disabled="disabled"/>
								</div>
							</div>

							<div class="col-md-6">
								<div class="form-group">
									<div id="chartContainer" style="width: 100%; margin: 0px auto;"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<input type="submit" name="btnSubmit" id="btnUpdateDepo"
						class="btn btn-primary" value="Depo Güncelle" /> <input
						type="submit" name="btnDelete" id="btnDeleteDepo"
						class="btn btn-danger" value="Depo Sil" />
					<button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
				</div>
			</div>
		</div>
	</div>

	<div class="alert-messages text-center"
		style="position: fixed; top: 10%; right: 50px; z-index: 7000; width: 20%;">
	</div>

	<script src="bootstrap/js/bootstrap.min.js"></script>
	<script src="js/canvasjs.min.js"></script>
	<script src="js/main.js"></script>
	<script src="js/ajax.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnDepoGuncelle").click();
			/*var chart;
			var _dataPoints = [{ y : 100, label : "Boş" }];
			
			chart = new CanvasJS.Chart("chartContainer", {
				theme : "light2", // "light1", "light2", "dark1", "dark2"
				exportEnabled : true,
				animationEnabled : true,
				responsive : true,
				maintainAspectRatio : false,
				scales : {
					yAxes : [ {
						ticks : {
							beginAtZero : true
						}
					} ]
				},
				title : {
					text : "Desktop Browser Market Share in 2016"
				},
				data : [ {
					type : "pie",
					startAngle : 25,
					toolTipContent : "<b>{label}</b>: {y}%",
					showInLegend : "true",
					legendText : "{label}",
					indexLabelFontSize : 16,
					indexLabel : "{label} - {y}%",
					dataPoints : _dataPoints
				} ]
			});

			chart.render();*/
		});
	</script>
</body>
</html>

<%
	}
}
%>