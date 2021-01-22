package com.proje.web.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.proje.Kullanici;
import com.proje.VeriTabani;

/**
 * Servlet implementation class KullaniciServer
 */
@WebServlet("/kullanici-server")
public class KullaniciServer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public KullaniciServer() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		String islem = request.getParameter("islem") + "";
		String json = "[]";

		if (islem.equals("setKullanici")) {

			try {
				String inputAdSoyad = request.getParameter("inputAdSoyad");
				String inputKullaniciAdi = request.getParameter("inputKullaniciAdi");
				String inputSifre = request.getParameter("inputSifre");
				String yetki1 = request.getParameter("yetki1");
				String yetki2 = request.getParameter("yetki2");
				String yetki3 = request.getParameter("yetki3");
				String yetki4 = request.getParameter("yetki4");
				String yetki5 = request.getParameter("yetki5");

				boolean islemSonuc = VeriTabani.setKullanici(inputAdSoyad, inputKullaniciAdi, inputSifre, yetki1, yetki2,
						yetki3, yetki4, yetki5);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		} else if (islem.equals("updateKullaniciYetki")) {

			try {
				String id = request.getParameter("id");
				String yetki1 = request.getParameter("yetki1");
				String yetki2 = request.getParameter("yetki2");
				String yetki3 = request.getParameter("yetki3");
				String yetki4 = request.getParameter("yetki4");
				String yetki5 = request.getParameter("yetki5");

				boolean islemSonuc = VeriTabani.updateKullaniciYetki(yetki1, yetki2, yetki3, yetki4,yetki5, id);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		} else if (islem.equals("updateKullanici")) {

			try {
				String id = "1";
				/*String yeki1 = request.getParameter("yetki1");
				String yeki2 = request.getParameter("yetki1");
				String yeki3 = request.getParameter("yetki1");
				String yeki4 = request.getParameter("yetki1");*/

				String inputAdSoyad = request.getParameter("inputAdSoyad");
				String inputKullaniciAdi = request.getParameter("inputKullaniciAdi");
				String inputEskiSifre = request.getParameter("inputSifre");
				String inputYeniSifre = request.getParameter("inputYeniSifre");

				boolean islemSonuc = VeriTabani.updateKullanici(inputAdSoyad, inputKullaniciAdi, inputEskiSifre, inputYeniSifre, id);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		} else if (islem.equals("deleteKullanici")) {

			try {
				String id = request.getParameter("id");

				boolean islemSonuc = VeriTabani.deleteKullanici(id);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		}else if (islem.equals("giris")) {

			try {
				String kullaniciAdi = request.getParameter("kullaniciAdi");
				String sifre = request.getParameter("sifre");

				Kullanici islemSonuc = VeriTabani.girisOnay(kullaniciAdi, sifre);

				if (islemSonuc == null)
					json = "[{sonuc : \"0\", msg = \"Hatalý kullanici adi veya þifre\"}]";
				else {
					
					HttpSession session = request.getSession();
					session.setAttribute("id", islemSonuc.getId());
					session.setAttribute("adSoyad", islemSonuc.getAdiSoyadi());
					session.setAttribute("kullaniciAdi", islemSonuc.getKullaniciAdi());

					session.setAttribute("kullanici_ekle_duzenle_yetki", (islemSonuc.getKullaniciEkleDuzenleYetki() == 1)? islemSonuc.getKullaniciEkleDuzenleYetki() : null);
					session.setAttribute("kategori_ekle_duzenle_yetki", (islemSonuc.getKategoriEkleDuzenleYetki() == 1)? islemSonuc.getKategoriEkleDuzenleYetki() : null);
					session.setAttribute("urun_ekle_duzenle_yetki", (islemSonuc.getUrunEkleDuzenleYetki() == 1)? islemSonuc.getUrunEkleDuzenleYetki() : null);
					session.setAttribute("depo_ekle_duzenle_yetki", (islemSonuc.getDepoEkleDuzenleYetki() == 1)? islemSonuc.getDepoEkleDuzenleYetki() : null);
					session.setAttribute("kullanici_goruntule_yetki", (islemSonuc.getKullaniciGoruntulemeYetki() == 1)? islemSonuc.getKullaniciGoruntulemeYetki() : null);
				}
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		}

		response.getWriter().write(json);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
