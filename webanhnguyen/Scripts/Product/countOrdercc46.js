$(window).load(function () {
    var proId = parseInt($('#productId').val());
    $.post("../online-friday/Ajax/Order/CountOrderSuccessDetail.html", { proId: proId }, function (data) {

        $('#ordered').text(data);
        $('.fshop-cdprods.clearfix').show();
        console.log("còn lại: " + data);

        //if (parseInt(data) <= 0) {
        //    $('#ordered').text("000");
        //}
    });
});