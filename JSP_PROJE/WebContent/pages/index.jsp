<%-- 
    Document   : index
    Created on : 11 Ara 2020, 00:55:55
    Author     : lenovo
--%>

<%@page import="com.proje.Istatistik"%>
<%@page import="com.proje.VeriTabani"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.proje.Urunler"%>
<%@page import="com.proje.Depo"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
if (session.getAttribute("id") == null || session.getAttribute("id").equals("")) {
	response.sendRedirect("giris.jsp");
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
<link rel="stylesheet" href="css/table.css" />

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/icon?family=Material+Icons" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<script src="js/jquery.min.js"></script>

<title>Depo İstatistikleri</title>

</head>
<body>

	<jsp:include page="pieces/nav-bar.jsp">
		<jsp:param name="page" value="home" />
	</jsp:include>


	<section class="container" style="width: 90%;">

		<h1 style="text-align: center; margin-bottom: 50px; color: black;">
			<strong>Depo hakkında istatistikler</strong>
		</h1>

		<div class="row">
			<div class="col-sm-12">
				<div class="w3-card-4" style="width: 100%">
					<div id="chartContainer" style="height: 370px; width: 100%;"></div>
				</div>
			</div>
		</div>


		<div class="row" style="margin-top: 50px;">
			<div class="col-lg-4">

				<div class="w3-card-4" style="width: 100%; height: 300px;">
					<header class="w3-container w3-light-grey">
						<h3>İstatistikler 1</h3>
					</header>
					<div class="w3-container">
						<hr>
						<img src="images/urun-ekle.png" alt="Avatar"
							class="w3-left w3-circle w3-margin-right" style="width: 60px">
						<h3>
							<strong>Toplam ürün tanımı sayısı</strong>
						</h3>
						<h4><%= VeriTabani.getToplamKayitliUrunSayisi() %></h4>
						<hr style="margin-top: 30px; margin-bottom: 30px;">

						<img src="images/urun-ekle.png" alt="Avatar"
							class="w3-left w3-circle w3-margin-right" style="width: 60px">
						<h3>
							<strong>Toplam kategori sayısı</strong>
						</h3>
						<h4><%= VeriTabani.getToplamKategoriSayisi() %></h4>
					</div>
				</div>

			</div>
			<div class="col-lg-4">
				<div class="w3-card-4" style="width: 100%">
					<div id="chartContainer2"
						style="height: 300px; max-width: 920px; margin: 0px auto;"></div>
				</div>
			</div>


			<div class="col-lg-4">
				<div class="w3-card-4" style="width: 100%; height: 300px;">
					<header class="w3-container w3-light-grey">
						<h3>İstatistikler 2</h3>
					</header>
					<div class="w3-container">
						<hr>
						<img src="images/urun-ekle.png" alt="Avatar"
							class="w3-left w3-circle w3-margin-right" style="width: 60px">
						<h3>
							<strong>Toplam Kayıtlı ürün sayısı</strong>
						</h3>
						
						<h4><%= VeriTabani.getToplamDepodakiUrunSayisi() %></h4>
						<hr style="margin-top: 30px; margin-bottom: 30px;">

						<img src="images/urun-ekle.png" alt="Avatar"
							class="w3-left w3-circle w3-margin-right" style="width: 60px">
						<h3>
							<strong>Bunların toplam maliyeti</strong>
						</h3>
						<h4><%= VeriTabani.getToplamUrunMaliyeti() %> TL</h4>
					</div>
				</div>

			</div>
		</div>

	</section>
	<script src="js/main.js"></script>
	<script src="js/canvasjs.min.js"></script>
	<script src="bootstrap/js/bootstrap.min.js"></script>


	<%
	List<Depo> depoList = VeriTabani.getTumDepoData("", "", "", "");
	%>
	<script>
		window.onload = function() {

			var chart = new CanvasJS.Chart("chartContainer", {
				theme : "light2", // "light1", "light2", "dark1"
				animationEnabled : true,
				exportEnabled : true,
				title : {
					text : "Depoların doluluk oranları"
				},
				axisX : {
					margin : 10,
					tickPlacement : "inside"
				},
				axisY2 : {
					title : "Depo başı (yüzde)",
					titleFontSize : 16,
					maximum: 100,
					includeZero : true,
					suffix : "%"
				},
				data : [ {
					type : "bar",
					axisYType : "secondary",
					yValueFormatString : "##0.00'%'",
					indexLabel : "{y}",
					dataPoints : [ 
						<%for (Depo d : depoList) {%>
							{
								label : "<%=d.getAdi()%>",
								y : <%=d.getDolulukYuzdesi()%>
							},
						<%}%>
						]
				} ]
			});
			
			
			chart.render();
			<%List<Depo> depoList2 = Istatistik.getToplamDolulukYuzdeleri();%>
			
			var chart2 = new CanvasJS.Chart("chartContainer2", {
				animationEnabled : true,
				title : {
					text : "Depo toplam doluluk oranı"
				},
				data : [ {
					type : "pie",
					startAngle : 240,
					yValueFormatString : "##0.00'%'",
					indexLabel : "{label} ({y})",
					dataPoints : [ 
						<%for (Depo d : depoList2) {%>
						{
							label : "<%=d.getAdi()%>",
							y : <%=d.getDolulukYuzdesi()%>
						},
					<%}%>
					]
				} ]
			});
			chart2.render();

		}
	</script>
</body>
</html>

<%}%>