package com.proje.web.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.LinkedList;
import java.util.List;

import com.proje.DegerYoneticisi;
import com.proje.Depo;
import com.proje.VeriTabani;
import com.google.gson.Gson;

/**
 * Servlet implementation class DepoServer
 */
@WebServlet("/depo-server")
public class DepoServer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DepoServer() {
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

		if (islem.equals("setUrun")) {

			try {
				String depoAdi = request.getParameter("depoadi");
				String depoBoyutu = request.getParameter("depoboyutu");

				Depo d = new Depo();
				d.setAdi(depoAdi);
				d.setDepo_buyuklugu(depoBoyutu);
				d.setDegerListesi(depoBoyutu);

				DegerYoneticisi yonetici = new DegerYoneticisi(d);
				if (!yonetici.negatifikKontrolu()) {

					boolean islemSonuc = VeriTabani.setYeniDepo(d);

					if (!islemSonuc)
						json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";
				} else {
					json = "[{sonuc : \"0\", msg = \"Negatif depoboyutu veya hatalý depoboyutu. Girilen depoboyutu : "
							+ depoBoyutu + "\"}]";
				}
			} catch (Exception e) {
				json = "[{sonuc : \"0\", msg = \"" + e.getMessage() + "\"}]";
				e.printStackTrace();
			}
		} else if (islem.equals("getDepoData")) {
			String _depoAdi = request.getParameter("depoadi");
			String _depoMin = request.getParameter("depomin");
			String _depoMax = request.getParameter("depomax");
			String _depoDoluluk = request.getParameter("depodoluluk");

			List<String> list = new LinkedList<String>();
			list.add((_depoMin == "")? "0" : _depoMin);
			list.add((_depoMax == "")? "0" : _depoMax);

			Depo d = new Depo();
			d.setDegerListesi(list);

			DegerYoneticisi yonetici = new DegerYoneticisi(d);
			if (!yonetici.negatifikKontrolu()) {

				try {
					List<Depo> depoListesi = VeriTabani.getTumDepoData(_depoAdi, _depoMin, _depoMax, _depoDoluluk);

					json = new Gson().toJson(depoListesi);

				} catch (Exception e) {
					json = "[{\"hata \": \"" + e.getLocalizedMessage() + "\"}]";
					e.printStackTrace();
				}
			} else {
				json = "[{sonuc : \"0\", msg = \"Negatif veya hatalý giriþ. Girilen deðerler  depoMin: " + _depoMin
						+ "depoMax: " + _depoMax + "\"}]";
			}
		} else if (islem.equals("updateDepo")) {
			String id = request.getParameter("id");
			String depoAdi = request.getParameter("depoadi");
			String depoBoyutu = request.getParameter("depoboyutu");
			
			Depo d = new Depo();
			d.setId(id);
			d.setAdi(depoAdi);
			d.setDepo_buyuklugu(depoBoyutu);

			List<String> list = new LinkedList<String>();
			list.add(id);
			list.add(depoBoyutu);
			d.setDegerListesi(list);

			DegerYoneticisi yonetici = new DegerYoneticisi(d);
			if (!yonetici.negatifikKontrolu()) {
				try {
					boolean islemSonuc = VeriTabani.updateDepo(d);

					if (!islemSonuc)
						json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";

				} catch (Exception e) {
					json = "[{\"hata \": \"" + e.getLocalizedMessage() + "\"}]";
					e.printStackTrace();
				}
			} else {
				json = "[{sonuc : \"0\", msg = \"Negatif veya hatalý giriþ. Girilen deðerler  id: " + id
						+ "depo boyutu: " + depoBoyutu + "\"}]";
			}
		} else if (islem.equals("deleteDepo")) {
			try {
				String id = request.getParameter("id");
				Depo d = new Depo();
				d.setId(id);
				d.setDegerListesi(id);

				DegerYoneticisi yonetici = new DegerYoneticisi(d);
				if (!yonetici.negatifikKontrolu()) {
					boolean islemSonuc = VeriTabani.deleteDepo(id);

					if (!islemSonuc)
						json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";

				} else {
					json = "[{sonuc : \"0\", msg = \"Negatif veya hatalý giriþ. Girilen deðerler  id: " + id;
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
