/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.proje;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import java.util.Base64;

/**
 *
 * @author UGUR
 * 
 */
public class VeriTabani {

	public VeriTabani() {

	}

	private static final String connectionString = "jdbc:mysql://localhost:3306/stok_takip?useUnicode=true&characterEncoding=utf-8";

	private static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(connectionString, "root", "");

			return con;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public static List<Urunler> getTumUrunData() {
		List<Urunler> urunListesi = new LinkedList<Urunler>();

		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(
					"SELECT uk.id,d.id as 'depo_id',k.id as 'kategori_id', u.urun_adi, u.barkod,u.birim_ucreti, uk.miktar, d.depo_adi, k.kategori_adi FROM urun_kayitlari as uk "
							+ "INNER JOIN urunler as u ON uk.urun_id = u.id "
							+ "INNER JOIN kategori as k ON u.urun_kategorisi = k.id "
							+ "INNER JOIN depo as d ON d.id = uk.depo ORDER by CAST(u.barkod as unsigned)");

			while (rs.next()) {
				Urunler u = new Urunler();
				u.setAdi(rs.getString("urun_adi"));
				u.setId(rs.getString("id"));
				u.setMiktar(rs.getString("miktar"));
				u.setBarkod(rs.getString("barkod"));
				u.setDepo(rs.getString("depo_adi"));
				u.setDepoId(rs.getString("depo_id"));
				u.setKategori(rs.getString("kategori_adi"));
				u.setKategoriId(rs.getString("kategori_id"));
				u.setBirimUcreti(rs.getString("birim_ucreti"));
				urunListesi.add(u);
			}
			con.close();
		} catch (Exception e) {
			Urunler u = new Urunler();
			u.setAdi(e.getMessage());
			urunListesi.add(u);
			e.printStackTrace();
		}

		return urunListesi;
	}

	public static List<Urunler> getTumUrunData(String barkod, String urunAdi, String depo, String kategori) {

		List<Urunler> urunListesi = new LinkedList<Urunler>();

		Connection con = getConnection();
		String query = "SELECT uk.id, d.id as 'depo_id',k.id as 'kategori_id', u.urun_adi, u.barkod,u.birim_ucreti, uk.miktar, d.depo_adi, k.kategori_adi "
				+ "FROM urun_kayitlari as uk INNER JOIN urunler as u ON uk.urun_id = u.id "
				+ "INNER JOIN kategori as k ON u.urun_kategorisi = k.id "
				+ "INNER JOIN depo as d ON d.id = uk.depo where u.barkod  "
				+ ((!barkod.equals("")) ? "LIKE ?" : "= u.barkod") + " and u.urun_adi"
				+ ((!urunAdi.equals("")) ? " LIKE ? " : " = u.urun_adi") + " and uk.depo = "
				+ ((!depo.equals("")) ? "?" : "uk.depo") + " and u.urun_kategorisi = "
				+ ((!kategori.equals("")) ? "?" : "u.urun_kategorisi") + "  ORDER by CAST(u.barkod as unsigned)";

		int index = 1;
		try {

			PreparedStatement pstmt = con.prepareStatement(query);

			if (!barkod.equals("")) {
				pstmt.setString(index, "%" + barkod + "%");
				index++;
			}
			if (!urunAdi.equals("")) {
				index++;
			}
			if (!depo.equals("")) {
				pstmt.setInt(index, Integer.parseInt(depo));
				index++;
			}
			if (!kategori.equals("")) {
				pstmt.setInt(index, Integer.parseInt(kategori));
				index++;
			}
			
			System.out.println(pstmt);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Urunler u = new Urunler();
				u.setAdi(rs.getString("urun_adi"));
				u.setId(rs.getString("id"));
				u.setMiktar(rs.getString("miktar"));
				u.setBarkod(rs.getString("barkod"));
				u.setDepo(rs.getString("depo_adi"));
				u.setDepoId(rs.getString("depo_id"));
				u.setKategori(rs.getString("kategori_adi"));
				u.setKategoriId(rs.getString("kategori_id"));
				u.setBirimUcreti(rs.getString("birim_ucreti"));
				urunListesi.add(u);
			}
			con.close();
		} catch (Exception e) {
			Urunler u = new Urunler();
			u.setAdi(e.getMessage() + "----> \n " + index);
			urunListesi.add(u);
			e.printStackTrace();
		}

		return urunListesi;
	}

	public static List<Kategori> getTumKategoriData() {
		List<Kategori> kategoriList = new LinkedList<Kategori>();

		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * From kategori");

			while (rs.next()) {
				Kategori u = new Kategori();
				u.setId(rs.getString("id"));
				u.setAdi(rs.getString("kategori_adi"));
				kategoriList.add(u);
			}
			con.close();
		} catch (Exception e) {
			Kategori k = new Kategori();
			k.setAdi(e.getMessage());
			k.setId("1");
			kategoriList.add(k);
			e.printStackTrace();
		}

		return kategoriList;
	}

	public static List<Depo> getTumDepoData() {
		List<Depo> depoList = new LinkedList<Depo>();

		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * From depo");

			while (rs.next()) {
				Depo d = new Depo();
				String id = rs.getString("id");
				d.setId(id);
				d.setAdi(rs.getString("depo_adi"));
				d.setDepo_buyuklugu(rs.getString("depo_buyuklugu"));
				d.setDepoKalanAlan(getDepoKalanAlanFromDepoId(id));
				depoList.add(d);
			}
			con.close();
		} catch (Exception e) {
			Depo d = new Depo();
			d.setAdi(e.getMessage());
			d.setId("1");
			depoList.add(d);
			e.printStackTrace();
		}

		return depoList;
	}

	public static String getDepoKalanAlanFromDepoId(String id) {

		Connection con = getConnection();
		try {
			List<Depo> depoList = getTumDepoData("", "", "", "");
			for (Depo d : depoList) {
				if (d.getId().equals(id)) {
					double doluluk = Double.parseDouble(d.getDolulukYuzdesi());
					double kalanAlan = Double.parseDouble(d.getDepo_buyuklugu())
							- Double.parseDouble(d.getDepo_buyuklugu()) * doluluk / 100;

					con.close();

					return String.valueOf((int) kalanAlan);
				}
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "";
	}

	public static boolean setYeniUrun(String barkod, String urunAdi, String kategori, String birimUcreti,
			String kapladigi_alan) {

		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con.prepareStatement(
					"insert into urunler (barkod, urun_adi, urun_kategorisi, birim_ucreti, kapladigi_alan) values (?, ?, ?, ?, ?)");
			preparedStmt.setString(1, barkod);
			preparedStmt.setString(2, urunAdi);
			preparedStmt.setInt(3, Integer.parseInt(kategori));
			preparedStmt.setInt(4, Integer.parseInt(birimUcreti));
			preparedStmt.setInt(5, Integer.parseInt(kapladigi_alan));
			preparedStmt.execute();

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public static boolean setDepoyaYeniUrun(String barkod, String miktar, String depo) {

		Urunler urun = getUrunFromBarkod(barkod);

		if (urun.getDepo().equals("hata"))
			return false;

		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con
					.prepareStatement("insert into urun_kayitlari (urun_id, miktar, depo) values (?, ?, ?)");
			preparedStmt.setString(1, urun.getId());
			preparedStmt.setInt(2, Integer.parseInt(miktar));
			preparedStmt.setInt(3, Integer.parseInt(depo));
			preparedStmt.execute();

			con.close();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static Urunler getUrunFromBarkod(String barkod) {
		Connection con = getConnection();
		Urunler u = new Urunler();

		try {
			PreparedStatement pstmt = con.prepareStatement("select * from urunler where barkod = ?");
			pstmt.setString(1, barkod);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				u.setId(rs.getString("id"));
				u.setAdi(rs.getString("urun_adi"));
				u.setBirimUcreti(rs.getString("birim_ucreti"));
				u.setKategoriKapladigiAlan(rs.getString("kapladigi_alan"));
				u.setDepo("baþarýlý");

				con.close();
				return u;
			}
		} catch (Exception e) {
			e.printStackTrace();
			u.setId(e.getMessage());
			u.setDepo("hata");
			return u;
		}

		return u;
	}

	public static boolean deleteDepoUrun(String id) {
		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("delete from urun_kayitlari where id = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean updateDepoUrun(String id, String barkod, String newBarkod, String miktar, String urunAdi,
			String depo, String urun_kategorisi, String birim_ucreti) {
		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"UPDATE urunler as u JOIN urun_kayitlari as uk ON u.barkod = ? and uk.id = ? SET u.urun_adi = ?, uk.miktar = ?, uk.depo = ?, u.urun_kategorisi = ?, u.birim_ucreti = ?, u.barkod = ?");
			pstmt.setString(1, barkod);
			pstmt.setString(2, id);
			pstmt.setString(3, urunAdi);
			pstmt.setString(4, miktar);
			pstmt.setString(5, depo);
			pstmt.setString(6, urun_kategorisi);
			pstmt.setString(7, birim_ucreti);
			pstmt.setString(8, newBarkod);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean setYeniDepo(Depo depo) {
		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con
					.prepareStatement("insert into depo (depo_adi, depo_buyuklugu) values (?, ?)");
			preparedStmt.setString(1, depo.getAdi());
			preparedStmt.setString(2, depo.getDepo_buyuklugu());
			preparedStmt.execute();

			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	private static List<Depo> getDepoData(String _id) {
		List<Depo> depoListesi = new LinkedList<Depo>();

		Connection con = getConnection();
		try {
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("Select * From depo " + ((_id != "") ? "Where id = " + _id : ""));

			while (rs.next()) {
				Depo d = new Depo();
				String id = rs.getString("id");
				d.setId(id);
				d.setAdi(rs.getString("depo_adi"));
				d.setDepo_buyuklugu(rs.getString("depo_buyuklugu"));
				depoListesi.add(d);
			}
			con.close();

			return depoListesi;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static List<Depo> getTumDepoData(String depoAdi, String depoMinBoyut, String depoMaxBoyut,
			String dolulukOraniId) {

		String dolulukOraniMin = "0";
		String dolulukOraniMax = "100";

		if (dolulukOraniId.equals("0-25")) {
			dolulukOraniMin = "0";
			dolulukOraniMax = "25";
		} else if (dolulukOraniId.equals("25-50")) {
			dolulukOraniMin = "25";
			dolulukOraniMax = "50";
		} else if (dolulukOraniId.equals("50-75")) {
			dolulukOraniMin = "50";
			dolulukOraniMax = "75";
		} else if (dolulukOraniId.equals("75-100")) {
			dolulukOraniMin = "75";
			dolulukOraniMax = "100";
		} else if (dolulukOraniId.equals("0-50")) {
			dolulukOraniMin = "0";
			dolulukOraniMax = "50";
		} else if (dolulukOraniId.equals("50-100")) {
			dolulukOraniMin = "50";
			dolulukOraniMax = "100";
		} else if (dolulukOraniId.equals("0-100")) {
			dolulukOraniMin = "0";
			dolulukOraniMax = "100";
		} else if (dolulukOraniId.equals("100")) {
			dolulukOraniMin = "100";
			dolulukOraniMax = "100";
		}

		List<Depo> depoListesi = new LinkedList<Depo>();
		List<Depo> depolist = getDepoData("");
		String query2 = "";
		try {
			for (Depo _depo : depolist) {

				Connection con = getConnection();
				query2 = "Select * From( SELECT SUM(carpim)/liste2.depo_buyuklugu*100 as oran,liste2.* from "
						+ "( SELECT SUM(miktar)*kapladigi_alan as carpim, liste.* FROM "
						+ "( SELECT uk.miktar,uk.depo, d.depo_adi,d.depo_buyuklugu, u.kapladigi_alan,uk.urun_id FROM depo as d "
						+ "LEFT JOIN  urun_kayitlari as uk ON d.id = uk.depo LEFT JOIN urunler as u ON u.id = uk.urun_id where "
						+ "(d.depo_buyuklugu >= " + ((!depoMinBoyut.equals("")) ? "?" : "d.depo_buyuklugu")
						+ " and d.depo_buyuklugu <= " + ((!depoMaxBoyut.equals("")) ? "?" : "d.depo_buyuklugu")
						+ " and d.depo_adi " + ((!depoAdi.equals("")) ? "LIKE ?" : "= d.depo_adi")
						+ ") ) as liste where depo = " + _depo.getId()
						+ " GROUP BY liste.urun_id ) as liste2 ) as liste3 where (liste3.oran >= ? and liste3.oran <= ?) or ISNULL(IF(? = 0, liste3.oran, 1))";

				int index = 1;

				PreparedStatement pstmt = con.prepareStatement(query2);

				if (!depoMinBoyut.equals("")) {
					pstmt.setInt(index, Integer.parseInt(depoMinBoyut));
					index++;
				}
				if (!depoMaxBoyut.equals("")) {
					pstmt.setInt(index, Integer.parseInt(depoMaxBoyut));
					index++;
				}
				if (!depoAdi.equals("")) {
					pstmt.setString(index, "%" + depoAdi + "%");
					index++;
				}
				if (!dolulukOraniMin.equals("")) {
					pstmt.setInt(index, Integer.parseInt(dolulukOraniMin));
					index++;
				}
				if (!dolulukOraniMax.equals("")) {
					pstmt.setInt(index, Integer.parseInt(dolulukOraniMax));
					index++;
				}
				pstmt.setInt(index, Integer.parseInt(dolulukOraniMin));

				System.out.println("'-" + depoAdi + "-'" + pstmt);
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
					Depo u = new Depo();
					String ad = rs.getString("depo_adi");
					if (ad == null) {
						List<Depo> depolist2 = getDepoData(_depo.getId());

						if (!(depolist2.get(0).getAdi().toLowerCase().indexOf(depoAdi.toLowerCase()) >= 0)
								&& depoAdi != "") {
							continue;
						}

						if (!(Integer.parseInt(depolist2.get(0).getDepo_buyuklugu()) >= Integer
								.parseInt((depoMinBoyut == "") ? "0" : depoMinBoyut)) && depoMinBoyut != "") {
							continue;
						}

						if (!(Integer.parseInt(depolist2.get(0).getDepo_buyuklugu()) <= Integer
								.parseInt((depoMaxBoyut == "") ? "0" : depoMaxBoyut)) && depoMaxBoyut != "") {
							continue;
						}

						u.setId(_depo.getId());
						u.setAdi(depolist2.get(0).getAdi());
						// u.setDepoAdi("" +
						// depolist2.get(0).getDepoAdi().toLowerCase().indexOf(depoAdi.toLowerCase()));
						u.setDepo_buyuklugu(depolist2.get(0).getDepo_buyuklugu());
						u.setDepoDolulukYuzdesi("0");
						
							u.setDepoUrunData(Base64.getEncoder().encodeToString(
									getDepoUrunlereGoreDolulukYuzdeleri(_depo.getId()).getBytes("UTF-8")));
						
						depoListesi.add(0, u);
					} else {
						String id = _depo.getId();
						u.setId(id);
						u.setAdi(ad);
						u.setDepo_buyuklugu(rs.getString("depo_buyuklugu"));
						u.setDepoDolulukYuzdesi(rs.getString("oran"));
						
							u.setDepoUrunData(Base64.getEncoder()
									.encodeToString(getDepoUrunlereGoreDolulukYuzdeleri(id).getBytes("UTF-8")));
						
						depoListesi.add(0, u);
					}
				}
				con.close();
			}
		} catch (Exception e) {
			Depo u = new Depo();
			u.setAdi("Hata : " + query2);
			u.setDepo_buyuklugu("Hata :" + depoMinBoyut.equals("") + "-" + depoMaxBoyut.equals(""));
			depoListesi.add(u);
			e.printStackTrace();
		}

		return depoListesi;
	}

	static Connection _con2 = null;
	public static String getDepoUrunlereGoreDolulukYuzdeleri(String id) {
		
		Connection con = getConnection();
		
		try {
			PreparedStatement pstmt = con.prepareStatement(
					"SELECT d.*,u.urun_adi, ( (SUM(uk.miktar) * u.kapladigi_alan) / d.depo_buyuklugu ) * 100 as 'yuzdelik' FROM urun_kayitlari as uk"
							+ " INNER JOIN depo as d ON d.id = uk.depo "
							+ " INNER JOIN urunler as u ON u.id = uk.urun_id where uk.depo = ? GROUP by uk.urun_id");

			pstmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = pstmt.executeQuery();

			String data = "";
			float toplamYuzde = 0;
			while (rs.next()) {

				/*
				 * { y : 51.08, label : "Chrome" }
				 */

				float y = rs.getFloat("yuzdelik");
				toplamYuzde += y;

				data += "{ \"y\" : " + y + ", \"label\" : \"" + rs.getString("urun_adi") + "\"}|";

			}
			if(toplamYuzde == 0)data += "{ \"y\" :" + (100 - toplamYuzde) + ", \"label\" : \"Boþ\" }";
			else data += "{ \"y\" :" + (100 - toplamYuzde) + ", \"label\" : \"Bos\" }";

			con.close();
			return data;
		} catch (Exception e) {
			try {
				con.close();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
			return e.getMessage();
		}
	}

	public static boolean updateDepo(Depo d) {

		System.out.print("------->" + d.getAdi());

		if (d.getAdi().equals("") || Integer.parseInt(d.getDepo_buyuklugu()) < 0)
			return false;

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con
					.prepareStatement("UPDATE depo SET depo_adi = ?, depo_buyuklugu = ? where id = ?");
			pstmt.setString(1, d.getAdi());
			pstmt.setInt(2, Integer.parseInt(d.getDepo_buyuklugu()));
			pstmt.setInt(3, Integer.parseInt(d.getId()));
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean deleteDepo(String id) {

		String q = "";

		if (getDepoUrunlereGoreDolulukYuzdeleri(id).indexOf("Boþ") >= 0) {
			q = "delete from depo where id = ?";
		} else {
			q = "delete d,uk from depo d JOIN urun_kayitlari uk ON d.id = uk.depo where d.id = ?";
		}

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(q);
			pstmt.setInt(1, Integer.parseInt(id));
			System.out.println(getDepoUrunlereGoreDolulukYuzdeleri(id) + "<---->" + pstmt);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean deleteUrun(String id) {

		try {

			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("select * from urun_kayitlari where urun_id = ?");
			pstmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PreparedStatement pstmt2 = con.prepareStatement(
						"delete u,uk from urunler u JOIN urun_kayitlari uk ON u.id = uk.urun_id where u.id = ?");
				pstmt2.setInt(1, Integer.parseInt(id));
				System.out.println(pstmt2);
				pstmt2.executeUpdate();
				return true;
			}

			PreparedStatement pstmt2 = con.prepareStatement("delete from urunler where id = ?");
			pstmt2.setInt(1, Integer.parseInt(id));
			System.out.println(pstmt2);
			pstmt2.executeUpdate();
			return true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static List<Urunler> getUrunData(String barkod, String urunAdi, String kategori) {

		List<Urunler> urunListesi = new LinkedList<Urunler>();

		Connection con = getConnection();
		String query = "SELECT urunler.*,kategori.kategori_adi as 'kategoriadi' FROM urunler INNER JOIN kategori ON kategori.id = urunler.urun_kategorisi where barkod "
				+ ((!barkod.equals("")) ? "LIKE ?" : "= barkod") + " and urun_adi"
				+ ((!urunAdi.equals("")) ? " LIKE ? " : " = urun_adi") + " and urun_kategorisi = "
				+ ((!kategori.equals("")) ? "?" : "urun_kategorisi") + "  ORDER by CAST(barkod as unsigned)";

		int index = 1;
		try {

			PreparedStatement pstmt = con.prepareStatement(query);

			if (!barkod.equals("")) {
				pstmt.setString(index, "%" + barkod + "%");
				index++;
			}
			if (!urunAdi.equals("")) {
				pstmt.setString(index, "%" + urunAdi + "%");
				index++;
			}
			if (!kategori.equals("")) {
				pstmt.setInt(index, Integer.parseInt(kategori));
				index++;
			}
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Urunler u = new Urunler();
				u.setAdi(rs.getString("urun_adi"));
				u.setId(rs.getString("id"));
				u.setBarkod(rs.getString("barkod"));
				u.setKategori(rs.getString("kategoriadi"));
				u.setKategoriId(rs.getString("urun_kategorisi"));
				urunListesi.add(u);
			}
			con.close();
		} catch (Exception e) {
			Urunler u = new Urunler();
			u.setAdi(e.getMessage() + "----> \n " + index);
			urunListesi.add(u);
			e.printStackTrace();
		}

		return urunListesi;
	}

	public static List<Kullanici> getKullaniciList() {
		List<Kullanici> kullaniciList = new LinkedList<Kullanici>();
		Connection con = getConnection();
		Statement stmt;
		try {
			stmt = con.createStatement();

			ResultSet rs = stmt.executeQuery("SELECT * From kullanici");

			while (rs.next()) {
				Kullanici k = new Kullanici();
				k.setId(rs.getString("id"));
				k.setAdiSoyadi(rs.getString("adi_soyadi"));
				k.setKullaniciAdi(rs.getString("kullanici_adi"));
				k.setUrunEkleDuzenleYetki(rs.getInt("urun_ekle_duzenle_yetki"));
				k.setDepoEkleDuzenleYetki(rs.getInt("depo_ekle_duzenle_yetki"));
				k.setKullaniciEkleDuzenleYetki(rs.getInt("kullanici_ekle_duzenle_yetki"));
				k.setKullaniciGoruntulemeYetki(rs.getInt("kullanici_goruntuleme_yetki"));
				k.setKategoriEkleDuzenleYetki(rs.getInt("kategori_ekleme_duzenleme_yetki"));

				kullaniciList.add(k);
			}

			return kullaniciList;
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public static boolean setKullanici(String inputAdSoyad, String inputKullaniciAdi, String inputSifre, String yeki1,
			String yeki2, String yeki3, String yeki4, String yeki5) {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"INSERT INTO kullanici(adi_soyadi, kullanici_adi, sifre, urun_ekle_duzenle_yetki, depo_ekle_duzenle_yetki, kullanici_ekle_duzenle_yetki, kullanici_goruntuleme_yetki,kategori_ekleme_duzenleme_yetki) VALUES (?,?,?,?,?,?,?,?)");

			pstmt.setString(1, inputAdSoyad);
			pstmt.setString(2, inputKullaniciAdi);
			pstmt.setString(3, inputSifre);
			pstmt.setInt(4, Integer.parseInt(yeki1));
			pstmt.setInt(5, Integer.parseInt(yeki2));
			pstmt.setInt(6, Integer.parseInt(yeki3));
			pstmt.setInt(7, Integer.parseInt(yeki4));
			pstmt.setInt(8, Integer.parseInt(yeki5));
			System.out.println(pstmt);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean updateKullanici(String inputAdSoyad, String inputKullaniciAdi, String inputEskiSifre,
			String inputYeniSifre, String id) {

		if (inputYeniSifre.equals("") || inputKullaniciAdi.equals("") || inputEskiSifre.equals("")
				|| inputYeniSifre.equals(""))
			return false;

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"UPDATE kullanici SET adi_soyadi=?,kullanici_adi=?,sifre=? WHERE id=? and sifre=?");

			pstmt.setString(1, inputAdSoyad);
			pstmt.setString(2, inputKullaniciAdi);
			pstmt.setString(3, inputYeniSifre);
			pstmt.setInt(4, Integer.parseInt(id));
			pstmt.setString(5, inputEskiSifre);

			System.out.println(pstmt);
			int isUpdate = pstmt.executeUpdate();
			if (isUpdate != 1)
				throw new Exception("Hatalý þifre");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean updateKullaniciYetki(String yeki1, String yeki2, String yeki3, String yeki4, String yeki5,
			String id) {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"UPDATE kullanici SET urun_ekle_duzenle_yetki=?,depo_ekle_duzenle_yetki=?,kullanici_ekle_duzenle_yetki=?,kullanici_goruntuleme_yetki=?,	kategori_ekleme_duzenleme_yetki = ? WHERE id=?");

			pstmt.setInt(1, Integer.parseInt(yeki1));
			pstmt.setInt(2, Integer.parseInt(yeki2));
			pstmt.setInt(3, Integer.parseInt(yeki3));
			pstmt.setInt(4, Integer.parseInt(yeki4));
			pstmt.setInt(5, Integer.parseInt(yeki5));
			pstmt.setInt(6, Integer.parseInt(id));
			System.out.println(pstmt);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static boolean deleteKullanici(String id) {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("Delete From kullanici WHERE id=?");

			pstmt.setInt(1, Integer.parseInt(id));
			System.out.println(pstmt);
			pstmt.executeUpdate();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	public static Kullanici getKullanici(String id) {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("Select * from kullanici where id = ?");
			pstmt.setInt(1, Integer.parseInt(id));

			ResultSet rs = pstmt.executeQuery();
			Kullanici k = new Kullanici();
			while (rs.next()) {
				k.setId(rs.getString("id"));
				k.setAdiSoyadi(rs.getString("adi_soyadi"));
				k.setKullaniciAdi(rs.getString("kullanici_adi"));
				k.setUrunEkleDuzenleYetki(rs.getInt("urun_ekle_duzenle_yetki"));
				k.setDepoEkleDuzenleYetki(rs.getInt("depo_ekle_duzenle_yetki"));
				k.setKullaniciEkleDuzenleYetki(rs.getInt("kullanici_ekle_duzenle_yetki"));
				k.setKullaniciGoruntulemeYetki(rs.getInt("kullanici_goruntuleme_yetki"));
				k.setKategoriEkleDuzenleYetki(rs.getInt("kategori_ekleme_duzenleme_yetki"));
			}

			return k;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public static Kullanici girisOnay(String kullaniciAdi, String sifre) {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con
					.prepareStatement("Select * from kullanici where kullanici_adi = ? and sifre = ?");
			pstmt.setString(1, kullaniciAdi);
			pstmt.setString(2, sifre);

			ResultSet rs = pstmt.executeQuery();
			Kullanici k = null;
			while (rs.next()) {
				k = new Kullanici();
				k.setId(rs.getString("id"));
				k.setAdiSoyadi(rs.getString("adi_soyadi"));
				k.setKullaniciAdi(rs.getString("kullanici_adi"));
				k.setUrunEkleDuzenleYetki(rs.getInt("urun_ekle_duzenle_yetki"));
				k.setDepoEkleDuzenleYetki(rs.getInt("depo_ekle_duzenle_yetki"));
				k.setKullaniciEkleDuzenleYetki(rs.getInt("kullanici_ekle_duzenle_yetki"));
				k.setKullaniciGoruntulemeYetki(rs.getInt("kullanici_goruntuleme_yetki"));
				k.setKategoriEkleDuzenleYetki(rs.getInt("kategori_ekleme_duzenleme_yetki"));
			}

			return k;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public static boolean setKategori(String kategoriAdi) {

		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con.prepareStatement("insert into kategori (kategori_adi) values (?)");
			preparedStmt.setString(1, kategoriAdi);
			System.out.println(preparedStmt);
			preparedStmt.executeUpdate();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public static boolean updateKategori(String id, String kategoriAdi) {

		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con.prepareStatement("Update kategori SET kategori_adi=? where id= ?");
			preparedStmt.setString(1, kategoriAdi);
			preparedStmt.setInt(2, Integer.parseInt(id));
			int islem = preparedStmt.executeUpdate();
			if (islem == 1) {
				return true;
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static boolean deleteKategori(String id) {

		Connection con = getConnection();
		try {
			PreparedStatement preparedStmt = con.prepareStatement("Delete from kategori where id= ?");
			preparedStmt.setInt(1, Integer.parseInt(id));
			int islem = preparedStmt.executeUpdate();
			if (islem == 1) {

				PreparedStatement preparedStmt2 = con
						.prepareStatement("Select * from urunler where urun_kategorisi = ?");
				preparedStmt2.setInt(1, Integer.parseInt(id));
				ResultSet rs = preparedStmt2.executeQuery();
				while (rs.next()) {
					deleteUrun(rs.getString("id"));
				}

				return true;
			}
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public static String getToplamKayitliUrunSayisi() {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("Select count(id) as c from urunler");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString("c");
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String getToplamKategoriSayisi() {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("Select count(id) as c from kategori");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString("c");
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String getToplamDepodakiUrunSayisi() {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement("Select count(id) as c from urun_kayitlari");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString("c");
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public static String getToplamUrunMaliyeti() {

		try {
			Connection con = getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"SELECT SUM(fiyat) as toplam FROM (SELECT sum(uk.miktar)*u.birim_ucreti as fiyat FROM urun_kayitlari as uk LEFT JOIN urunler as u ON u.id = uk.urun_id GROUP BY u.id) as altsorgu");
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString("toplam");
			}

			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}
}
