﻿function goBack() {
    window.history.back();
}
function linkto(act){
    window.location.href = root+'/quantri/?act='+act;
}
function to_href(link){
    window.location.href = root+'/quantri/'+link;
}
function to_href2(link){
    window.open(link);
}
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();            
        reader.onload = function (e) {
            $('#blah').attr('src', e.target.result);
        }            
        reader.readAsDataURL(input.files[0]);
        console.log("b");
    } else {
        console.log("a");
    }
}
$(document).ready(function() {
    
    $('.nav-header.pull-right > li div.btn-group button.btn.btn-default.btn-image').click(function(){
        $(this).parent('.btn-group').toggleClass('open');
    });

    /**/

    $(".tool").on('click', function(){
        var id = $(this).attr("value");
        var table  = $(this).attr('data-table');
        var field  = $(this).attr('data-field');
        var action = $(this).attr('data-action');
        var $this = $(this);
        var data = {'action': action, 'item': id, 'field': field, 'table': table};
        $.ajax({
            url: '/Admin/Ajax/ToolAjax/',
            type: 'POST',
            dataType: 'json',
            data: {'data': data, 'cmd': 'BTN_ACTIVE_STAT'},
        })
        .done(function (result) {
            if(result=='1') $this.toggleClass('active');
        });
    });
    $(".block-content").on("click", ".btn-remove", function () {
        var name = $(this).closest("tr").find(".name-to-confirm").html(),
            c = confirm("Bạn thực sự muốn xoá \"" + name.trim() + "\" ?");
        return c;
    })
});