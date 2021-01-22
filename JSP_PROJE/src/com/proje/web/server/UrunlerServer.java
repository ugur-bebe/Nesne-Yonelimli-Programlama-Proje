package com.proje.web.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import com.proje.Urunler;
import com.proje.VeriTabani;
import com.google.gson.Gson;

/**
 * Servlet implementation class server
 */
@WebServlet("/urunler-server")
public class UrunlerServer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UrunlerServer() {
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

		if (islem.equals("geturunlistjson")) {

			try {
				List<Urunler> urunListesi = VeriTabani.getTumUrunData();

				json = new Gson().toJson(urunListesi);

			} catch (Exception e) {
				json = "[{\"hata \": \"" + e.getLocalizedMessage() + "\"}]";
			}
		} else if (islem.equals("getUrunAramaSonuc")) {
			String barkod = request.getParameter("barkod");
			String urunAdi = request.getParameter("urunadi");
			String depo = request.getParameter("depo");
			String kategori = request.getParameter("kategori");

			List<Urunler> urunListesi = VeriTabani.getTumUrunData(barkod, urunAdi, depo, kategori);
			json = new Gson().toJson(urunListesi);

		} else if (islem.equals("setUrun")) {
			try {
				String barkod = request.getParameter("barkod");
				String urunAdi = request.getParameter("urunadi");
				String birim_ucreti = request.getParameter("birim_ucreti");
				String kategori = request.getParameter("kategori");
				String kapladigiAlan = request.getParameter("kapladigi_alan");

				boolean islemSonuc = VeriTabani.setYeniUrun(barkod, urunAdi, kategori, birim_ucreti, kapladigiAlan);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}

		} else if (islem.equals("setDepoUrun")) {
			try {
				String barkod = request.getParameter("barkod");
				String miktar = request.getParameter("miktar");
				String depo = request.getParameter("depo");

				boolean islemSonuc = VeriTabani.setDepoyaYeniUrun(barkod, miktar, depo);

				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				e.printStackTrace();
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
			}

		} else if (islem.equals("setDepoUrunFromBarkod")) {
			try {
				
				String barkod = request.getParameter("barkod");
								
				Urunler islemSonuc = VeriTabani.getUrunFromBarkod(barkod);

				if (islemSonuc.getDepo() == null)
					json = "[{sonuc : \"0\", msg = \"Veri Yok\"}]";
				else
					json = new Gson().toJson(islemSonuc);

			} catch (Exception e) {
				e.printStackTrace();
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
			}

		} else if (islem.equals("updateUrun")) {

			String urunAdi = request.getParameter("urunadi");
			String urun_depo_id = request.getParameter("id");
			String barkod = request.getParameter("barkod");
			String newBarkod = request.getParameter("newbarkod");
			String miktar = request.getParameter("miktar");
			String depo = request.getParameter("depo");
			String urun_kategorisi = request.getParameter("urun_kategorisi");
			String birim_ucreti = request.getParameter("birim_ucreti");

			boolean islemSonuc = VeriTabani.updateDepoUrun(urun_depo_id, barkod, newBarkod, miktar, urunAdi, depo,
					urun_kategorisi, birim_ucreti);

			try {
				if (!islemSonuc)
					json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
			} catch (Exception e) {
				e.printStackTrace();
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
			}

		} else if (islem.equals("deleteDepoUrun")) {

			String id = request.getParameter("id");
			boolean s = VeriTabani.deleteDepoUrun(id);
			if (!s)
				json = "[{sonuc : \"0\", msg = \"Veri Yok\"}]";
			
		} else if (islem.equals("deleteUrun")) {

			String id = request.getParameter("id");
			boolean s = VeriTabani.deleteUrun(id);
			if (!s)
				json = "[{sonuc : \"0\", msg = \"Veri Yok\"}]";
		}
		else if(islem.equals("getUrunList")) {
			String barkod = request.getParameter("barkod");
			String urunAdi = request.getParameter("urunadi");
			String kategori = request.getParameter("kategori");

			List<Urunler> urunListesi = VeriTabani.getUrunData(barkod, urunAdi, kategori);
			json = new Gson().toJson(urunListesi);
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
