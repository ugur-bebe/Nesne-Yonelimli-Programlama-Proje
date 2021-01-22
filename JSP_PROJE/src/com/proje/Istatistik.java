package com.proje;

import java.util.List;

public class Istatistik {

	public Istatistik() {

	}

	public static List<Depo> getToplamDolulukYuzdeleri() {
		List<Depo> depoList = VeriTabani.getTumDepoData("", "", "", "");
		
		double toplamBoyut = 0;
		for(Depo d: depoList) {
			toplamBoyut += Double.parseDouble(d.getDepo_buyuklugu());
		}

		double toplamYuzde = 0;
		for(Depo d: depoList) {
			
			double yuzde = Double.parseDouble(d.getDolulukYuzdesi()) * Double.parseDouble(d.getDepo_buyuklugu()) / toplamBoyut;
			toplamYuzde += yuzde;
			d.setDepoDolulukYuzdesi(String.valueOf(yuzde));
		}
		
		Depo d = new Depo();
		d.setAdi("Boþ");
		d.setDepoDolulukYuzdesi(String.valueOf((100 - toplamYuzde)));
		
		depoList.add(d);
		
		return depoList;
	}
}
