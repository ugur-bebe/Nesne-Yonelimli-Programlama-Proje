<%-- 
    Document   : index
    Created on : 11 Ara 2020, 00:55:55
    Author     : lenovo
--%>

<%@page import="com.proje.VeriTabani"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.proje.Urunler"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="bootstrap/css/bootstrap.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" href="css/table.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />

<script src="js/jquery.min.js"></script>

<title>JSP Page</title>

</head>
<body>

	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="home" />
	</jsp:include>

	<div class="container-xl" style="padding-left: 20px;">
		<div class="table-responsive">
			<div class="table-wrapper" id="tabel-div">
				<div class="table-title">
					<div class="row">
						<div class="col-sm-4">
							<h2>
								<b>Stok Listesi</b>
							</h2>
						</div>
					</div>
				</div>
				<div class="table-filter">
					<div class="row">
						<div class="col-sm-12">
							<button type="button" class="btn btn-primary">
								<i class="fa fa-search"></i>
							</button>
							<div class="filter-group">
								<label>Ara</label> <input type="text" class="form-control">
							</div>
							<div class="filter-group">
								<label>Ürün Konumu</label> <select class="form-control">
									<option>Depo 1</option>
									<option>Depo 2</option>
									<option>Depo 3</option>
									<option>Depo 4</option>
									<option>Depo 5</option>
									<option>Depo 6</option>
								</select>
							</div>
							<div class="filter-group">
								<label>Ürün Durumu</label> <select class="form-control">
									<option>İyi</option>
									<option>Normal</option>
									<option>Bozulmuş</option>
								</select>
							</div>
							<span class="filter-icon"><i class="fa fa-filter"></i></span>
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
					<tbody>

						<%
						List<Urunler> urunListesi = VeriTabani.getTumUrunData();

						int sayac = 1;
						for (Urunler u : urunListesi) {
						%>
						<tr class="table_products_row">
							<td><%=sayac%></td>
							<td><%=u.getBarkod()%></td>
							<td><%=u.getAdi()%></td>
							
							<td><%=u.getMiktar()%></td>
							<td><%=u.getDepo()%></td>
							<td><span class="status text-success">&bull;</span> <%=u.getKategori()%></td>
							<td><%=u.getBirimUcreti()%></td>
							<td><a href="urun-duzenle.jsp?barkod=<%=u.getBarkod()%>"
								class="view" title="View Details" data-toggle="tooltip"><i
									class="material-icons">edit</i></a></td>
						</tr>

						<%
						sayac++;
						}
						%>
					</tbody>
				</table>
				<div class="clearfix">
					<ul class="pagination">
						<li class="page-item disabled"><a href="#">Önceki</a></li>
						<li class="page-item"><a href="#" class="page-link">1</a></li>
						<li class="page-item"><a href="#" class="page-link">2</a></li>
						<li class="page-item"><a href="#" class="page-link">3</a></li>
						<li class="page-item active"><a href="#" class="page-link">4</a></li>
						<li class="page-item"><a href="#" class="page-link">5</a></li>
						<li class="page-item"><a href="#" class="page-link">6</a></li>
						<li class="page-item"><a href="#" class="page-link">7</a></li>
						<li class="page-item"><a href="#" class="page-link">Sonraki</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">
						<b>Ürün Bilgiler</b>
					</h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Kapat</button>
				</div>
			</div>
		</div>
	</div>

	<script src="js/main.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>

	<script>
		$(document).ready(function() {
			$("#tabel-div").css("width", $("#table").css("width") + "");
		});
	</script>
</body>
</html>
