
function showAndDismissAlert(type, message) {
    var htmlAlert = '<div class="alert alert-' + type + '">' + message + '</div>';

    // Prepend so that alert is on top, could also append if we want new alerts to show below instead of on top.
    $(".alert-messages").prepend(htmlAlert);

    // Since we are prepending, take the first alert and tell it to fade in and then fade out.
    // Note: if we were appending, then should use last() instead of first()
    $(".alert-messages .alert").first().hide().fadeIn(200).delay(2000).fadeOut(1000, function () { $(this).remove(); });
}

function alertPopup(type, message) {
    showAndDismissAlert('success', 'Saved Successfully!');
}

function decodeUnicode(str) {
    return decodeURIComponent(atob(str).split('').map(function (c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
}


$(".table_products_row").click(function () {
    var $row = $(this).closest("tr");
    var $tds = $row.find("td");

    //alert($row.html().replaceAll("<td>", "<tr>").replaceAll("</td>", "<tr>"));

    // $(".modal-body p").append("<table>" + $row.html().replaceAll("<td>", "<tr><td>").replaceAll("</td>", "</td></tr>") + "</table>");

    var tr = ["Barkod", "Ürün Adı", "Miktarı", "Depo", "Kategori", "Birim Ücreti"];
    var content = "<table  class=\"table\">";
    var index = 0;
    var isFirt = true;
    $.each($tds, function () {
        if (isFirt) {
            isFirt = false;
        } else {
            if (tr[index] + "" != "undefined") {
                content += "<tr><td><b>" + tr[index] + "</b></td><td>&nbsp&nbsp&nbsp" + $(this).text() + "</td></tr>";
                index++;
            }
        }
    });
    $(".modal-body").text("");
    $(".modal-body").append(content + "</table>");
    $("#myModal").modal();
});



/* $(".table_products_row_update").click(function () {
     var $row = $(this).closest("tr");
     var $tds = $row.find("td");

     var tr = ["Barkod", "Ürün Adı", "Miktarı", "Depo", "Kategori", "Birim Ücreti"];
     var inputNames = ["txtBarkod", "txtUrunAdi", "txtMiktar", "selectDepo", "Kategori", "txtUcret"];

     var index = 0;
     var isFirt = true;
     $.each($tds, function () {
         if (isFirt) {
             isFirt = false;
         } else {
             if (tr[index] + "" != "undefined") {
                 $("#" + inputNames[index]).val($(this).text().replace("$", ""));
                 index++;
             }
         }
     });
     $("#myModal").modal();
 });*/



$("#btnDelete").click(function (e) {
    e.preventDefault();
    var id = $(this).attr("_value");

    if (confirm('Bu ürünü silmekte eminmisiniz?')) {
        deleteDepoUrunWithId(id);
        $("#myModal").modal('hide');
    } else {
        alert("İptal edildi");
    }
});


$("#arama-secenekleri,#select-filtre-kategori,#select-filtre-depo").change(function (e) {
    changePagination(1);
    $('#btn-ara').click();
});

$("#filtre-depo-adi,#filtre-depo-min-boyut,#filtre-depo-max-boyut,#filtre-depo-doluluk-orani").change(function (e) {
    changePagination(1);
    $('#btnDepoGuncelle').click();
});

$("#filtre-depo-adi,#filtre-depo-min-boyut,#filtre-depo-max-boyut").keyup(function() {
    changePagination(1);
    $('#btnDepoGuncelle').click();
});

$("#input-arama").on('input', function () {
    $('#btn-ara').click();
});

$("#filtre-depo-adi").on('input', function () {
    $('#btnDepoGuncelle').click();
});

var lastPaginationNumber = 1;
function changePagination(t) {
    $("#pagination_" + t).addClass("active");
    $("#pagination_" + lastPaginationNumber).removeClass("active");
    lastPaginationNumber = t;

    $('#btn-ara').click();
    $('#btnDepoGuncelle').click();
}

function paginationBackOrForward(i) {
    var isActivePrev = ($("#pagination_prev").children().css("cursor") == "not-allowed");
    var isActiveNext = ($("#pagination_next").children().css("cursor") == "not-allowed");

    if (i == 1 && !isActiveNext) {
        $("#pagination_" + lastPaginationNumber).removeClass("active");
        lastPaginationNumber += 1;
        $("#pagination_" + lastPaginationNumber).addClass("active");

        $('#btn-ara').click();
        $('#btnDepoGuncelle').click();
    }
    else if (i == 2 && !isActivePrev) {
        $("#pagination_" + lastPaginationNumber).removeClass("active");
        lastPaginationNumber -= 1;
        $("#pagination_" + lastPaginationNumber).addClass("active");

        $('#btn-ara').click();
        $('#btnDepoGuncelle').click();
    }
}

function openUpdateModal(t) {
    var $row = $(t).closest("tr");
    var $tds = $row.find("td");

    var tr = ["Barkod", "Ürün Adı", "Miktarı", "Depo", "Kategori", "Birim Ücreti"];
    var inputNames = ["txtBarkod", "txtUrunAdi", "txtMiktar", "select-depo", "select-kategori", "txtUcret"];

    var index = 0;
    var isFirt = true;
    $.each($tds, function () {
        if (isFirt) {
            isFirt = false;

            $("#btnUpdate").attr("_value", $(this).attr("value"));
            $("#btnDelete").attr("_value", $(this).attr("value"));
            $("#txtBarkod").attr("_value", $($tds[1]).attr("_value"));
        } else {
            if (tr[index] + "" != "undefined") {

                console.log(inputNames[index] + " :" + $(this).attr("value") + "-");
                $("#" + inputNames[index]).val($(this).attr("value"));
                //$("#" + inputNames[index] + " option[value='" + $(this).attr("value") + "']").prop('selected', true);
                index++;
            }
        }
    });

    $("#myModal").modal();
}

var urunSilId = 0;
function openDeleteModal(t) {
    var $row = $(t).closest("tr");
    var $tds = $row.find("td");

    var isFirt = true;
    $.each($tds, function () {
        if (isFirt) {
            isFirt = false;
            urunSilId = $(this).attr("value");
            $("#btnUrunSil").attr("_value", $(this).attr("value"));
        } 
    });

    $("#modalDeleteUrun").modal();
}


function openModalDepoUpdate(t) {
    var $row = $(t).closest("tr");
    var $tds = $row.find("td");

    var tr = ["txtDepoAdi", "txtDepoBoyutu", "txtDepoDolulukOrani"];
    var inputNames = ["txtDepoAdi", "txtDepoBoyutu", "txtDepoDolulukOrani"];

    var index = 0;
    var isFirt = true;
    $.each($tds, function () {
        if (isFirt) {
            isFirt = false;

            $("#btnUpdateDepo").attr("_value", $(this).attr("value"));
            $("#btnDeleteDepo").attr("_value", $(this).attr("value"));
            var a = decodeUnicode($row.attr("value")).toString().split("|");

            var __data = [];

            for (i = 0; i < a.length; i++) {
                __data.push(JSON.parse(a[i]));
            }

            //var _data = [JSON.parse(a)];
            var chart;
            var _dataPoints = __data;

            chart = new CanvasJS.Chart("chartContainer", {
                theme: "light2", // "light1", "light2", "dark1", "dark2"
                exportEnabled: true,
                animationEnabled: true,
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                },
                title: {
                    text: "Ürün dağılımı"
                },
                data: [{
                    type: "pie",
                    startAngle: 25,
                    toolTipContent: "<b>{label}</b>: {y}%",
                    showInLegend: "true",
                    legendText: "{label}",
                    indexLabelFontSize: 16,
                    indexLabel: "{label} - {y}%",
                    dataPoints: _dataPoints
                }]
            });

            chart.render();

        } else {
            if (tr[index] + "" != "undefined") {

                console.log(inputNames[index] + " :" + $(this).attr("value") + "-");
                $("#" + inputNames[index]).val($(this).attr("value"));
                //$("#" + inputNames[index] + " option[value='" + $(this).attr("value") + "']").prop('selected', true);
                index++;
            }
        }
    });

    $("#myModal2").modal();
}

$("#btnDeleteDepo").click(function (e) {
    e.preventDefault();
    var id = $(this).attr("_value");

    if (confirm('Bu ürünü silmekte eminmisiniz?\nBunla birlikte bu depodaki tüm ürünlerde silinecektir!')) {
        deleteDepoWithId(id);
        $("#myModal2").modal('hide');
    } else {
        alert("İptal edildi");
    }
});



//$(document).ready(function () {

//});
