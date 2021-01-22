package com.proje;

public class Kullanici {

	private String id;
	private String adiSoyadi;
	private String kullaniciAdi;
	private int urunEkleDuzenleYetki;
	private int depoEkleDuzenleYetki;
	private int kategoriEkleDuzenleYetki;
	private int kullaniciEkleDuzenleYetki;
	private int kullaniciGoruntulemeYetki;
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getId() {
		return id;
	}
	
	public void setAdiSoyadi(String adiSoyadi) {
		this.adiSoyadi = adiSoyadi;
	}
	
	public String getAdiSoyadi() {
		return adiSoyadi;
	}
	
	public void setKullaniciAdi(String kullaniciAdi) {
		this.kullaniciAdi = kullaniciAdi;
	}
	
	public String getKullaniciAdi() {
		return kullaniciAdi;
	}

	public void setUrunEkleDuzenleYetki(int urunEkleDuzenleYetki) {
		this.urunEkleDuzenleYetki = urunEkleDuzenleYetki;
	}
	
	public int getUrunEkleDuzenleYetki() {
		return urunEkleDuzenleYetki;
	}
	
	public void setDepoEkleDuzenleYetki(int depoEkleDuzenleYetki) {
		this.depoEkleDuzenleYetki = depoEkleDuzenleYetki;
	}
	
	public int getDepoEkleDuzenleYetki() {
		return depoEkleDuzenleYetki;
	}
	
	public void setKullaniciEkleDuzenleYetki(int kullaniciEkleDuzenleYetki) {
		this.kullaniciEkleDuzenleYetki = kullaniciEkleDuzenleYetki;
	}
	
	public int getKullaniciEkleDuzenleYetki() {
		return kullaniciEkleDuzenleYetki;
	}
	
	public void setKullaniciGoruntulemeYetki(int kullaniciGoruntulemeYetki) {
		this.kullaniciGoruntulemeYetki = kullaniciGoruntulemeYetki;
	}
	
	public int getKullaniciGoruntulemeYetki() {
		return kullaniciGoruntulemeYetki;
	}
		
	public void setKategoriEkleDuzenleYetki(int kategoriEkleDuzenleYetki) {
		this.kategoriEkleDuzenleYetki = kategoriEkleDuzenleYetki;
	}
	
	public int getKategoriEkleDuzenleYetki() {
		return kategoriEkleDuzenleYetki;
	}
}
