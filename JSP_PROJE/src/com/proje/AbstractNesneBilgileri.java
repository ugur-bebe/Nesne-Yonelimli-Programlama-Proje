package com.proje;

public abstract class AbstractNesneBilgileri{
	
	private String adi;

	public void setAdi(String adi) {
		this.adi = adi;
	}

	public String getAdi() {
		return adi;
	}
	
	abstract void setId(String id);

	abstract public String getId();
	
}
