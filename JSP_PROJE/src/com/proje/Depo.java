package com.proje;

import java.util.LinkedList;
import java.util.List;

public class Depo extends NesneBilgileri implements IDegerYoneticisi {
	
	@Override
	public void setDegerListesi(List<String> degerListesi) {
		this.degerListesi = degerListesi;
	}
	
	@Override
	public void setDegerListesi(String deger) {
		List<String> list = new LinkedList<String>();
		list.add(deger);
		this.degerListesi = list;
	}

	@Override
	public List<String> getDegerListesi() {
		return degerListesi;
	}

	public Depo() {

	}

	public Depo(String id, String adi) {
		this.setId(id);
		this.setAdi(adi);
	}
	
	private String depo_buyuklugu;
	private String depoDolulukYuzdesi;
	private String depoUrunData;
	private String depoKalanAlan;
	private List<String> degerListesi;




	public void setDepo_buyuklugu(String depo_buyuklugu) {
		this.depo_buyuklugu = depo_buyuklugu;
	}

	public String getDepo_buyuklugu() {
		return depo_buyuklugu;
	}

	public void setDepoDolulukYuzdesi(String depoDolulukYuzdesi) {
		this.depoDolulukYuzdesi = depoDolulukYuzdesi;
	}

	public String getDolulukYuzdesi() {
		return depoDolulukYuzdesi;
	}

	public void setDepoUrunData(String depoUrunData) {
		this.depoUrunData = depoUrunData;
	}

	public String getDepoUrunData() {
		return depoUrunData;
	}
	
	public void setDepoKalanAlan(String depoKalanAlan) {
		this.depoKalanAlan = depoKalanAlan;
	}

	public String getDepoKalanAlan() {
		return depoKalanAlan;
	}

}
