package com.proje;

import java.util.LinkedList;
import java.util.List;

public class Kategori extends NesneBilgileri3 implements IDegerYoneticisi {

	public List<String> degerListesi;
	@Override
	public void setDegerListesi(List<String> degerListesi) {
		this.degerListesi = degerListesi;
	}

	@Override
	public List<String> getDegerListesi() {
		return degerListesi;
	}

	@Override
	public void setDegerListesi(String deger) {
		List<String> list = new LinkedList<String>();
		list.add(deger);
		this.degerListesi = list;
	}


}
