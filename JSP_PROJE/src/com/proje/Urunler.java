package com.proje;

public class Urunler extends AbstractNesneBilgileri {
	
	@Override
	void setId(String id) {
		this.id = id;
	}

	@Override
	public String getId() {
		return id;
	}

    public Urunler() {
        
    }

    private String id;
    private String miktar;
    private String depo;
    private String depo_id;
    private String kategori;
    private String kategori_id;
    private String birimUcreti;
    private String kapladigiAlan;


    public String getBarkod() {
        return barkod;
    }

    private String barkod;
    public void setBarkod(String barkod) {
        this.barkod = barkod;
    }

    public String getMiktar() {
        return miktar;
    }

    public void setMiktar(String miktar) {
        this.miktar = miktar;
    }

    public String getDepo() {
        return depo;
    }

    public void setDepo(String depo) {
        this.depo = depo;
    }
    
    public String getDepoId() {
        return depo_id;
    }

    public void setDepoId(String depo_id) {
        this.depo_id = depo_id;
    }

    public String getKategori() {
        return kategori;
    }

    public void setKategori(String kategori) {
        this.kategori = kategori;
    }

    public String getKategoriId() {
        return kategori_id;
    }

    public void setKategoriId(String kategori_id) {
        this.kategori_id = kategori_id;
    }

    public String getBirimUcreti() {
        return birimUcreti;
    }

    public void setBirimUcreti(String birimUcreti) {
        this.birimUcreti = birimUcreti;
    }
    
	public void setKategoriKapladigiAlan(String kapladigiAlan) {
		this.kapladigiAlan = kapladigiAlan;
	}
	
	public String getKategoriKapladigiAla() {
		return kapladigiAlan;
	}

}
