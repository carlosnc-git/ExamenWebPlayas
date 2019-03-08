$(document).ready(function () {
    console.log('ready');
    init();
});
function init() {
    loadInfo();
    $('#miCarrusel').carousel({
        interval: 2000
    });
}

function loadInfo() {
    $('#modalInfo').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget);
        var idPlaya = button.data('id');
        $.ajax({
            type: "GET",
            url: "Controller?op=info&idPlaya=" + idPlaya,
            success: function (info) {
                $("#modalinfopuntuaciones").html(info);
            }
        });
    });
}    









