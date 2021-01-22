/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


var isFirst = true;
$('#frm-filtre').submit(function (e) {
	e.preventDefault();
	$("#data-table").css("display", "block");

	/*if (isFirst) {
		isFirst = false;
		$("#tabel-div").css("width", (parseInt($("#table").css("width")) + 20) + "");
	}*/


	var _barkod = (($("#arama-secenekleri").val() == "urunadi") ? "" : $("#input-arama").val());
	var _urunadi = (($("#arama-secenekleri").val() == "urunadi") ? $("#input-arama").val() : "");
	var _depo = (($("#select-filtre-depo").val() == "tumu") ? "" : $("#select-filtre-depo").val());
	var _kategori = (($("#select-filtre-kategori").val() == "tumu") ? "" : $("#select-filtre-kategori").val());
	var _pagination = ($(".pagination > .active > a").text() == undefined || $(".pagination > .active > a").text().trim() == "") ? "1" : $(".pagination > .active > a").text();

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "getUrunAramaSonuc", barkod: _barkod, urunadi: _urunadi, depo: _depo, kategori: _kategori },
		success: function (responseText) {
			//console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));


			$("#bulunan-urun-tablo-baslik").text("Toplamda " + json.length + " Ürün Bulundu");
			$("#_container").css("margin-top", "4%");


			var pagination_number_len = $("#pagination > li").length - 2;
			var pagination_prev_disable = "";
			var pagination_next_disable = "";
			if (pagination_number_len == lastPaginationNumber) {
				pagination_prev_disable = "";
				pagination_next_disable = "disabled";
			}
			else if (lastPaginationNumber == 1) {
				pagination_prev_disable = "disabled";
				pagination_next_disable = "";
			}


			var pag = "<li class=\"page-item " + pagination_prev_disable + "\" id=\"pagination_prev\" ><a href=\"#\"  onclick =\"paginationBackOrForward(2);\">Önceki</a></li>";
			for (var i = 0; i < (json.length / 5); i++) {
				pag += "<li class=\"page-item " + (((lastPaginationNumber - 1) == i) ? "active" : "") + "\"  id=\"pagination_" + (i + 1) + "\" ><a href=\"#\" class=\"page-link\" onclick =\"changePagination('" + (i + 1) + "');\">" + (i + 1) + "</a></li>";
			}

			$("#pagination").text("");
			$("#pagination").append(pag + "<li class=\"page-item " + pagination_next_disable + "\" id=\"pagination_next\"><a href=\"#\" class=\"page-link\"  onclick =\"paginationBackOrForward(1);\">Sonraki</a></li>");



			var rows = "";
			var index = 1;
			var pagination_index = 0;
			json.forEach(function (object) {

				if (pagination_index >= (parseInt(_pagination) - 1) * 5 && pagination_index < (parseInt(_pagination) * 5)) {

					console.log(object.id);
					rows += "<tr class=\"table_products_row_update tr_" + object.barkod + "\" id= \"tr_" + object.id + "\" onclick = \"openUpdateModal(this)\">";
					rows += "<td value = \"" + object.id + "\">" + ((parseInt(_pagination) - 1) * 5 + (index++)) + "</td>";
					rows += "<td value = \"" + object.barkod + "\" _value= \"" + object.barkod + "\">" + object.barkod + "</td>";
					rows += "<td value = \"" + object.adi + "\">" + object.adi + "</td>";
					rows += "<td value = \"" + object.miktar + "\">" + object.miktar + "</td>";
					rows += "<td value = \"" + object.depo_id + "\">" + object.depo + "</td>";
					rows += "<td value = \"" + object.kategori_id + "\"><span class=\"status text-success\">&bull;</span>" + object.kategori + "</td>";
					rows += "<td value = \"" + object.birimUcreti + "\">" + object.birimUcreti + "</td>";
					rows += "<td><a href=\"#\" class=\"view\" title=\"View Details\" data-toggle=\"tooltip\"><i class=\"material-icons\">edit</i></a></td>";
					rows += "</tr>";
				}

				pagination_index++;
			});
			$("#table-urunGuncelle-tbody").text("");
			$("#table-urunGuncelle-tbody").append(rows);
		}
	});
});


$('#frm-urun-ekle').submit(function (e) {
	e.preventDefault();

	var _barkod = $("#txtBarkod").val();
	var _urunadi = $("#txtUrunAdi").val();
	var _birimUcreti = $("#txtBirimFiyatı").val();
	var _kategori = $("#select-kategori").val();
	var _kapladigi_alan = $("#txtKapladigiAlan").val();

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "setDepoUrunFromBarkod", barkod: _barkod },
		success: function (responseText) {

			showAndDismissAlert('danger', 'Bu barkod numarası daha önceden kullanılmış! <br>Lütfen başka bir barkod numarası giriniz.');
			/*showAndDismissAlert('info', 'Message Received');*/
		},
		error: function (request, status, error) {
			$.ajax({
				url: '/JSP_PROJE/urunler-server',
				type: 'POST',
				data: { islem: "setUrun", barkod: _barkod, urunadi: _urunadi, birim_ucreti: _birimUcreti, kategori: _kategori, kapladigi_alan: _kapladigi_alan },
				success: function (responseText) {
					console.log(responseText);
					showAndDismissAlert('success', 'Kayıt başarılı!');
				},
				error: function (request, status, error) {
					showAndDismissAlert('danger', request.responseText);
				}
			})
		}
	})
});


$('#frm-depoya-urun-ekle').submit(function (e) {
	e.preventDefault();

	var _barkod = $("#txtBarkod").val();
	var _miktar = $("#txtMiktar").val();
	var _depo = $("#select-depo").val();

	/*showAndDismissAlert('danger', 'Error Encountered');
	showAndDismissAlert('info', 'Message Received');*/

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "setDepoUrun", barkod: _barkod, miktar: _miktar, depo: _depo },
		success: function (responseText) {
			console.log(responseText);
			$("#txtBarkod").val("");
			$("#txtMiktar").val("");
			var obje = $("#select-depo option:selected");
			var kapladigiAlan = $("#txtUrunAdi").attr("_value");
			var kalan = (parseInt(obje.attr("_option"))/kapladigiAlan - parseInt(_miktar));
			obje.attr("_option", kalan);
			if(kalan == 0){
				obje.attr("disabled", "disabled");
				obje.text(obje.text() + " (Depo full dolu)");
			}
			$("#select-depo").val("1");

			showAndDismissAlert('success', 'Saved Successfully!');
			depoUrunEkleBarkodFiltre();
		}
	})
});


function depoUrunEkleBarkodFiltre() {

	var txt = $("#txtBarkod").val();
	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "setDepoUrunFromBarkod", barkod: txt },
		success: function (responseText) {
			console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));

			$("#txtUrunAdi").val(json.adi);
			$("#txtUrunAdi").attr("_value", json.kapladigiAlan);
			$("#txtBirimFiyatı").val(json.birimUcreti);
			if (parseInt($("#txtMiktar").val()) > 0)
				$("#btn-depo-urun-ekle").removeAttr("disabled");
			else
				$("#btn-depo-urun-ekle").attr("disabled", "disabled");

			ayarla();

		},
		error: function (request, status, error) {
			$("#txtUrunAdi").val("");
			$("#txtBirimFiyatı").val("");
			$("#btn-depo-urun-ekle").attr("disabled", "disabled");
		}
	})
}


function deleteDepoUrunWithId(_id) {

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "deleteDepoUrun", id: _id },
		success: function (responseText) {
			console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));

			//$(".table_products_row_update td option[value='" + _id + "']").prop('selected', true);

			$("#tr_" + _id + "").remove();
		},
		error: function (request, status, error) {
			$("#txtUrunAdi").val("");
			$("#txtBirimFiyatı").val("");
			$("#btn-depo-urun-ekle").attr("disabled", "disabled");
		}
	})
}


$("#btnUpdate").click(function (e) {
	e.preventDefault();

	if (!confirm('Bu ürünü güncellemek istediğinizden eminmisiniz?')) {
		alert("İptal edildi");
		return;
	}

	var _urunadi = $("#txtUrunAdi").val();
	var _id = $(this).attr("_value");
	var _barkod = $("#txtBarkod").attr("_value");
	var _newBarkod = $("#txtBarkod").val();
	var _miktar = $("#txtMiktar").val();
	var _depo = $("#select-depo").val();
	var _urun_kategorisi = $("#select-kategori").val();
	var _birim_ucreti = $("#txtUcret").val();

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "updateUrun", id: _id, urunadi: _urunadi, barkod: _barkod, newbarkod: _newBarkod, miktar: _miktar, depo: _depo, urun_kategorisi: _urun_kategorisi, birim_ucreti: _birim_ucreti },
		success: function (responseText) {
			console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));
			$("#btn-ara").click();

			//$(".table_products_row_update td option[value='" + _id + "']").prop('selected', true);

			//$("#tr" + _id + "").prop('selected', true);

			/*var $row = $("#tr_" + _id + "");
			var $tds = $row.find("td");

			$($tds[1]).text($("#txtBarkod").val());
			$($tds[2]).text($("#txtUrunAdi").val());
			$($tds[3]).text($("#txtMiktar").val());
			$($tds[4]).text($("#select-depo option:selected").text());
			$($tds[5]).text("<span class=\"status text-success\">•</span>" + $("#select-kategori option:selected").text());
			$($tds[6]).text($("#txtUcret").val());*/
		},
		error: function (request, status, error) {
			$("#txtUrunAdi").val("");
			$("#txtBirimFiyatı").val("");
			$("#btn-depo-urun-ekle").attr("disabled", "disabled");
		}
	})

	$("#myModal").modal('hide');
});


/****************************************************************************************************/


$('#frm-depo-ekle').submit(function (e) {
	e.preventDefault();

	var _depoAdi = $("#txtDepoAdi").val();
	var _depoBoyutu = $("#txtDepoBuyukluk").val();

	/*showAndDismissAlert('danger', 'Error Encountered');
	showAndDismissAlert('info', 'Message Received');*/

	$.ajax({
		url: '/JSP_PROJE/depo-server',
		type: 'POST',
		data: { islem: "setUrun", depoadi: _depoAdi, depoboyutu: _depoBoyutu },
		success: function (responseText) {
			console.log(responseText);

			$("#txtDepoAdi").val("");
			$("#txtDepoBuyukluk").val("");

			showAndDismissAlert('success', 'Saved Successfully!');
		},
		error: function (request, status, error) {

			if (request.responseText.indexOf("Negatif") >= 0) {
				showAndDismissAlert('danger', "Depo boyutu pozitif olmalıdır!");
			}
		}
	})
});


var isFirst2 = true;
$('#frm-update-depo').submit(function (e) {
	e.preventDefault();
	$("#data-table").css("display", "block");

	/*if (isFirst2) {
		isFirst2 = false;
		$("#tabel-div").css("width", (parseInt($("#table").css("width")) + 20) + "");
	}*/

	var _depoAdi = $("#filtre-depo-adi").val();
	var _depoMin = $("#filtre-depo-min-boyut").val();
	var _depoMax = $("#filtre-depo-max-boyut").val();
	var _depoDoluluk = $("#filtre-depo-doluluk-orani").val();
	var _id = $(this).attr("_value");

	var _pagination = ($(".pagination > .active > a").text() == undefined || $(".pagination > .active > a").text().trim() == "") ? "1" : $(".pagination > .active > a").text();

	$.ajax({
		url: '/JSP_PROJE/depo-server',
		type: 'POST',
		data: { islem: "getDepoData", depoadi: _depoAdi, depomin: _depoMin, depomax: _depoMax, depodoluluk: _depoDoluluk },
		success: function (responseText) {
			console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));


			$("#bulunan-urun-tablo-baslik").text("Toplamda " + json.length + " Ürün Bulundu");
			$("#_container").css("margin-top", "4%");


			var pagination_number_len = $("#pagination > li").length - 2;
			var pagination_prev_disable = "";
			var pagination_next_disable = "";
			if (pagination_number_len == lastPaginationNumber) {
				pagination_prev_disable = "";
				pagination_next_disable = "disabled";
			}
			else if (lastPaginationNumber == 1) {
				pagination_prev_disable = "disabled";
				pagination_next_disable = "";
			}


			var pag = "<li class=\"page-item " + pagination_prev_disable + "\" id=\"pagination_prev\" ><a href=\"#\"  onclick =\"paginationBackOrForward(2);\">Önceki</a></li>";
			for (var i = 0; i < (json.length / 5); i++) {
				pag += "<li class=\"page-item " + (((lastPaginationNumber - 1) == i) ? "active" : "") + "\"  id=\"pagination_" + (i + 1) + "\" ><a href=\"#\" class=\"page-link\" onclick =\"changePagination('" + (i + 1) + "');\">" + (i + 1) + "</a></li>";
			}

			$("#pagination").text("");
			$("#pagination").append(pag + "<li class=\"page-item " + pagination_next_disable + "\" id=\"pagination_next\"><a href=\"#\" class=\"page-link\"  onclick =\"paginationBackOrForward(1);\">Sonraki</a></li>");

			var rows = "";
			var index = 1;
			var pagination_index = 0;
			json.forEach(function (object) {

				if (pagination_index >= (parseInt(_pagination) - 1) * 5 && pagination_index < (parseInt(_pagination) * 5)) {

					console.log(object.id);
					rows += "<tr class=\"table_products_row_update tr_" + object.id + "\" value = \"" + (object.depoUrunData) + "\" id= \"tr_" + object.id + "\" onclick = \"openModalDepoUpdate(this)\">";
					rows += "<td value = \"" + object.id + "\">" + ((parseInt(_pagination) - 1) * 5 + (index++)) + "</td>";
					rows += "<td value = \"" + object.adi + "\" _value= \"" + object.adi + "\">" + object.adi + "</td>";
					rows += "<td value = \"" + object.depo_buyuklugu + "\">" + object.depo_buyuklugu + "</td>";
					rows += "<td value = \"" + object.depoDolulukYuzdesi + "\">%" + object.depoDolulukYuzdesi + "</td>";
					rows += "<td><a href=\"#\" class=\"view\" title=\"View Details\" data-toggle=\"tooltip\"><i class=\"material-icons\">edit</i></a></td>";
					rows += "</tr>";
				}

				pagination_index++;
			});
			$("#table-depoGuncelle-tbody").text("");
			$("#table-depoGuncelle-tbody").append(rows);
		}
		,
		error: function (request, status, error) {

			if (request.responseText.indexOf("Negatif") >= 0) {
				showAndDismissAlert('danger', "Hatalı değer!");
			}
		}
	});
});


$("#btnUpdateDepo").click(function (e) {
	e.preventDefault();

	if (!confirm('Bu ürünü güncellemek istediğinizden eminmisiniz?')) {
		alert("İptal edildi");
		return;
	}

	var _depoadi = $("#txtDepoAdi").val();
	var _depoboyutu = $("#txtDepoBoyutu").val();

	var _id = $(this).attr("_value");

	$.ajax({
		url: '/JSP_PROJE/depo-server',
		type: 'POST',
		data: { islem: "updateDepo", id: _id, depoadi: _depoadi, depoboyutu: _depoboyutu },
		success: function (responseText) {
			console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));
			$("#btnDepoGuncelle").click();
			showAndDismissAlert('success', "Depo başarıyla güncellendi");
		},
		error: function (request, status, error) {
			console.log(request);
			if (request.responseText.indexOf("Negatif") >= 0) {
				showAndDismissAlert('danger', "Hatalı değer!");
			}
		}
	})

	$("#myModal2").modal('hide');
});



function deleteDepoWithId(_id) {

	$.ajax({
		url: '/JSP_PROJE/depo-server',
		type: 'POST',
		data: { islem: "deleteDepo", id: _id },
		success: function (responseText) {
			console.log(responseText);

			$("#tr_" + _id + "").remove();
		},
		error: function (request, status, error) {
			console.log(request);
		}
	})
}


$('#frm-urun-listesi-filtre').submit(function (e) {
	e.preventDefault();
	$("#data-table").css("display", "block");

	var _barkod = (($("#arama-secenekleri").val() == "urunadi") ? "" : $("#input-arama").val());
	var _urunadi = (($("#arama-secenekleri").val() == "urunadi") ? $("#input-arama").val() : "");
	var _kategori = (($("#select-filtre-kategori").val() == "tumu") ? "" : $("#select-filtre-kategori").val());

	var _pagination = ($(".pagination > .active > a").text() == undefined || $(".pagination > .active > a").text().trim() == "") ? "1" : $(".pagination > .active > a").text();

	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "getUrunList", barkod: _barkod, urunadi: _urunadi, kategori: _kategori },
		success: function (responseText) {
			//console.log(responseText);
			var json = JSON.parse(JSON.stringify(responseText));


			$("#bulunan-urun-tablo-baslik").text("Toplamda " + json.length + " Ürün Bulundu");
			$("#_container").css("margin-top", "4%");

			var pagination_number_len = $("#pagination > li").length - 2;
			var pagination_prev_disable = "";
			var pagination_next_disable = "";
			if (pagination_number_len == lastPaginationNumber) {
				pagination_prev_disable = "";
				pagination_next_disable = "disabled";
			}
			else if (lastPaginationNumber == 1) {
				pagination_prev_disable = "disabled";
				pagination_next_disable = "";
			}

			var pag = "<li class=\"page-item " + pagination_prev_disable + "\" id=\"pagination_prev\" ><a href=\"#\"  onclick =\"paginationBackOrForward(2);\">Önceki</a></li>";
			for (var i = 0; i < (json.length / 5); i++) {
				pag += "<li class=\"page-item " + (((lastPaginationNumber - 1) == i) ? "active" : "") + "\"  id=\"pagination_" + (i + 1) + "\" ><a href=\"#\" class=\"page-link\" onclick =\"changePagination('" + (i + 1) + "');\">" + (i + 1) + "</a></li>";
			}

			$("#pagination").text("");
			$("#pagination").append(pag + "<li class=\"page-item " + pagination_next_disable + "\" id=\"pagination_next\"><a href=\"#\" class=\"page-link\"  onclick =\"paginationBackOrForward(1);\">Sonraki</a></li>");

			var rows = "";
			var index = 1;
			var pagination_index = 0;
			json.forEach(function (object) {
				if (pagination_index >= (parseInt(_pagination) - 1) * 5 && pagination_index < (parseInt(_pagination) * 5)) {

					console.log(object.id);
					rows += "<tr class=\"table_products_row_update tr_" + object.barkod + "\" id= \"tr_" + object.id + "\" onclick = \"openDeleteModal(this)\">";
					rows += "<td value = \"" + object.id + "\">" + ((parseInt(_pagination) - 1) * 5 + (index++)) + "</td>";
					rows += "<td value = \"" + object.barkod + "\" _value= \"" + object.barkod + "\">" + object.barkod + "</td>";
					rows += "<td value = \"" + object.adi + "\">" + object.adi + "</td>";
					rows += "<td value = \"" + object.kategori_id + "\"><span class=\"status text-success\">&bull;</span>" + object.kategori + "</td>";
					rows += "<td><a href=\"#\" class=\"view\" title=\"View Details\" data-toggle=\"tooltip\"><i class=\"material-icons\">delete</i></a></td>";
					rows += "</tr>";
				}

				pagination_index++;
			});
			$("#table-urun-sil-tbody").text("");
			$("#table-urun-sil-tbody").append(rows);
		}
	});
});

function deleteUrun() {

	//urunSilId --> main.js içersinde
	$.ajax({
		url: '/JSP_PROJE/urunler-server',
		type: 'POST',
		data: { islem: "deleteUrun", id: urunSilId },
		success: function (responseText) {
			console.log(responseText);

			$("#tr_" + urunSilId + "").remove();
		},
		error: function (request, status, error) {
			console.log(request);
		}
	})

	$("#modalDeleteUrun").modal('hide');
}


$('#frm-kullanici-ekle').submit(function (e) {
	e.preventDefault();

	var _inputAdSoyad = $("#input-ad-soyad").val();
	var _inputKullaniciAdi = $("#input-kullanici-adi").val();
	var _inputSifre = $("#input-sifre").val();

	var customCheck1 = ($("#customCheck1").is(':checked') == true) ? "1" : "0";
	var customCheck2 = ($("#customCheck2").is(':checked') == true) ? "1" : "0";
	var customCheck3 = ($("#customCheck3").is(':checked') == true) ? "1" : "0";
	var customCheck4 = ($("#customCheck4").is(':checked') == true) ? "1" : "0";
	var customCheck5 = ($("#customCheck5").is(':checked') == true) ? "1" : "0";

	$.ajax({
		url: '/JSP_PROJE/kullanici-server',
		type: 'POST',
		data: { islem: "setKullanici", inputAdSoyad: _inputAdSoyad, inputKullaniciAdi: _inputKullaniciAdi, inputSifre: _inputSifre, yetki1: customCheck1, yetki2: customCheck2, yetki3: customCheck3, yetki4: customCheck4, yetki5: customCheck5 },
		success: function (responseText) {
			$("#input-ad-soyad").val("");
			$("#input-kullanici-adi").val("");
			$("#input-sifre").val("");
			$("#customCheck1").prop('checked', false);
			$("#customCheck2").prop('checked', false);
			$("#customCheck3").prop('checked', false);
			$("#customCheck4").prop('checked', false);
			$("#customCheck5").prop('checked', false);


			showAndDismissAlert('success', 'Kullanıcı ekleme başarılı!');
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Kullanıcı Eklenemedi!');
		}
	})
});


function kullaniciYetkiGuncelle(e) {

	var customCheck1 = ($("#customCheck" + e + "_1").is(':checked') == true) ? "1" : "0";
	var customCheck2 = ($("#customCheck" + e + "_2").is(':checked') == true) ? "1" : "0";
	var customCheck3 = ($("#customCheck" + e + "_3").is(':checked') == true) ? "1" : "0";
	var customCheck4 = ($("#customCheck" + e + "_4").is(':checked') == true) ? "1" : "0";
	var customCheck5 = ($("#customCheck" + e + "_5").is(':checked') == true) ? "1" : "0";

	$.ajax({
		url: '/JSP_PROJE/kullanici-server',
		type: 'POST',
		data: { islem: "updateKullaniciYetki", yetki1: customCheck1, yetki2: customCheck2, yetki3: customCheck3, yetki4: customCheck4, yetki5: customCheck5, id: e },
		success: function (responseText) {

			showAndDismissAlert('success', 'Kullanıcı yetkileri düzenleme başarılı!');
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Kullanıcı yetkileri düzenlenemedi!');
		}
	})
}

function kullaniciSil(e) {

	if (!confirm('Bu kullanıcıyı silmekten emin misiniz?')) {
		alert("İptal edildi");
		return;
	}

	$.ajax({
		url: '/JSP_PROJE/kullanici-server',
		type: 'POST',
		data: { islem: "deleteKullanici", id: e },
		success: function (responseText) {
			showAndDismissAlert('success', 'Kullanıcı silme işlemi başarılı!');
			$("#collapse_" + e).remove();
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Kullanıcı silinemedi!');
		}
	})
}

function kullaniciGuncelle() {

	var _inputAdSoyad = $("#input-ad-soyad").val();
	var _inputKullaniciAdi = $("#input-kullanici-adi").val();
	var _inputEskiSifre = $("#input-eski-sifre").val();
	var _inputYeniSifre = $("#input-sifre").val();

	$.ajax({
		url: '/JSP_PROJE/kullanici-server',
		type: 'POST',
		data: { islem: "updateKullanici", inputAdSoyad: _inputAdSoyad, inputKullaniciAdi: _inputKullaniciAdi, inputSifre: _inputEskiSifre, inputYeniSifre: _inputYeniSifre },
		success: function (responseText) {

			showAndDismissAlert('success', 'Kullanıcı yetkileri düzenleme başarılı!');
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Kullanıcı yetkileri düzenlenemedi!');
		}
	})
}

$('#frm-giris').submit(function (e) {
	e.preventDefault();

	var _kullaniciAdi = $("#kullanici-adi").val();
	var _sifre = $("#sifre").val();

	$.ajax({
		url: '/JSP_PROJE/kullanici-server',
		type: 'POST',
		data: { islem: "giris", kullaniciAdi: _kullaniciAdi, sifre: _sifre },
		success: function (responseText) {
			window.location.href = "index.jsp";
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Hatlı kullanıcı adı veya şifre!');
		}
	})
});

function kategoriSil(e) {

	if (!confirm('Bu kategoriyi silmekten emin misiniz? Bu kategoriye ait bütün ürünler silinecektir !')) {
		alert("İptal edildi");
		return;
	}

	$.ajax({
		url: '/JSP_PROJE/kategori-server',
		type: 'POST',
		data: { islem: "deleteKategori", id: e },
		success: function (responseText) {
			showAndDismissAlert('success', 'Kategori silme işlemi başarılı!');
			$("#collapse_" + e).remove();
		},
		error: function (request, status, error) {
			showAndDismissAlert('danger', 'Kategori silinemedi!');
		}
	})
}

function kategoriGuncelle(e) {

	var _kategoriadi = $("#txtKategoriAdi" + e).val();
	if (_kategoriadi == "") {
		showAndDismissAlert('danger', 'Kategori düzenlenemedi!<br>Lütfen değer giriniz!');

	} else {

		$.ajax({
			url: '/JSP_PROJE/kategori-server',
			type: 'POST',
			data: { islem: "updateKategori", kategoriadi: _kategoriadi, id: e },
			success: function (responseText) {
				$("#c_" + e).text("");
				$("#c_" + e).append("#" + _kategoriadi + "");
				showAndDismissAlert('success', 'Kategori düzenleme başarılı!');
			},
			error: function (request, status, error) {
				showAndDismissAlert('danger', 'Kategori düzenlenemedi!');
			}
		})
	}
}

$('#frm-kategori-ekle').submit(function (e) {
	e.preventDefault();
	var _inputkategoriadi = $("#input-kategori-adi").val();
	if (_inputkategoriadi == "") {
		showAndDismissAlert('danger', 'Kategori düzenlenemedi!<br>Lütfen değer giriniz!');

	} else {

		$.ajax({
			url: '/JSP_PROJE/kategori-server',
			type: 'POST',
			data: { islem: "setKategori", kategoriadi: _inputkategoriadi },
			success: function (responseText) {
				$("#input-kategori-adi").val("");
				showAndDismissAlert('success', 'Kategori ekleme başarılı!');
			},
			error: function (request, status, error) {
				showAndDismissAlert('danger', 'Kategori eklenemedi!');
			}
		})
	}
});

