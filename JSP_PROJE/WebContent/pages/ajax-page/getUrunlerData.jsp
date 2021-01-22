<%-- 
    Document   : getUrunlerData
    Created on : 16 Ara 2020, 01:39:22
    Author     : lenovo
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.proje.Urunler"%>
<%@page import="com.proje.VeriTabani"%>
<%
Class.forName("com.mysql.jdbc.Driver");
List<Urunler> urunListesi = new LinkedList<Urunler>();
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/stok_takip", "root", "");

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from urunler");
while (rs.next()) {
	Urunler u = new Urunler();
	u.setAdi(rs.getString("urun_adi"));
	u.setDepoId(String.valueOf(rs.getInt("id")));
	u.setMiktar(String.valueOf(rs.getInt("miktar")));
	u.setBarkod(rs.getString("barkod"));
	u.setDepo(String.valueOf(rs.getInt("depo")));
	u.setDepo(String.valueOf(rs.getInt("kategori")));
	u.setBirimUcreti(String.valueOf(rs.getInt("birim_ucreti")));
	urunListesi.add(u);
}
con.close();

VeriTabani v = new VeriTabani();
List<Urunler> urunler = v.getTumUrunData();
String json = new Gson().toJson(urunListesi);
out.println(json);
%>