package com.proje.web.server;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.proje.VeriTabani;

/**
 * Servlet implementation class KategoriServer
 */
@WebServlet("/kategori-server")
public class KategoriServer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public KategoriServer() {
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

		if (islem.equals("setKategori")) {
			String kategoriadi = request.getParameter("kategoriadi");

			boolean islemSonuc = VeriTabani.setKategori(kategoriadi);
			System.out.println("-->asdasdasd");
			if (!islemSonuc)
				json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";

		} else if (islem.equals("updateKategori")) {
			String kategoriadi = request.getParameter("kategoriadi");
			String id = request.getParameter("id");

			boolean islemSonuc = VeriTabani.updateKategori(id, kategoriadi);

			if (!islemSonuc)
				json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";

		} else if (islem.equals("deleteKategori")) {
			String id = request.getParameter("id");

			boolean islemSonuc = VeriTabani.deleteKategori(id);

			if (!islemSonuc)
				json = "[{sonuc : \"0\", msg = \"Hata Yok\"}]";

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
