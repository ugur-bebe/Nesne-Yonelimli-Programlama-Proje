package com.proje;

import java.util.List;

public class DegerYoneticisi {

	private IDegerYoneticisi nesne = null;

	public DegerYoneticisi(IDegerYoneticisi nesne) {
		this.nesne = nesne;
	}

	public boolean negatifikKontrolu() {
		List<String> degerListesi = nesne.getDegerListesi();

		for (String d : degerListesi) {
			try {

				System.out.println("---->" + d);
				int sayi = Integer.parseInt(d);
				if (!(sayi >= 0))
					return true;

			} catch (Exception e) {
				e.printStackTrace();
				return true;
			}
		}
		
		return false;
	}
}
