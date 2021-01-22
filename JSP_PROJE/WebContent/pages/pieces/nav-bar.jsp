
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-inverse" style="border-radius: 0px !important;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span></button>
            <a class="navbar-brand" href="#"><b style="color: white;">Stok Takip</b></a>
        </div>
        <div class="collapse navbar-collapse" id="myNavbar">
            <ul class="nav navbar-nav">
                <li id="home"><a href="index.jsp">Ana Sayfa</a></li>

                <li class="dropdown" id="urun">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Ürün <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li style="pointer-events: none; opacity: 0.6;"><a href="#">Depo işlemleri</a></li>
                        <li><a href="urun-duzenle.jsp">&nbsp;&nbsp;&nbsp;Ürünleri Listesi</a></li>
                        <li><a href="depoya-urun-ekle.jsp">&nbsp;&nbsp;&nbsp;Depoya Yeni Ürün Kaydet</a></li>
                        <li class="divider"></li>
                        <li style="pointer-events: none; opacity: 0.6;"><a href="#">Sistem işlemleri</a></li>
                        <li><a href="urun-ekle.jsp">&nbsp;&nbsp;&nbsp;Yeni Ürün Kaydet</a></li>
                        <li><a href="urun-sil.jsp">&nbsp;&nbsp;&nbsp;Ürün Kaydı Sil</a></li>
                    </ul>
                </li>
                <li class="dropdown" id="depo">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Depo <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="depo-ekle.jsp">Depo Ekle</a></li>
                        <li><a href="depo-duzenle.jsp">Depo Listesi</a></li>
                    </ul>
                </li>

                <li class="dropdown" id="kullanici">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Kullanıcı <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="kullanici-ekle.jsp">Kullanıcı Ekle</a></li>
                        <li><a href="kullanici-listesi.jsp">Kullanıcıları Listesi</a></li>
                    </ul>
                </li>
                
				<li class="dropdown" id="kategori">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Kategori <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="kategori-ekle.jsp">Kategori Ekle</a></li>
                        <li><a href="kategori-listesi.jsp">Kategori Listesi</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="profil.jsp"><span class="glyphicon glyphicon-user"></span> Profil</a>
                </li>
                <li>
                    <a href="giris.jsp"><span class="glyphicon glyphicon-log-in"></span> Çıkış Yap</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<script>
    $("#<%=request.getParameter("page")%>").attr("class", "active");
</script>
