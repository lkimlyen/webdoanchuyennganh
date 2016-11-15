(function($){
    $(document).ready(function () {
        //$(document).on('click', '.tg-tabul li a', function(){

        $(".tg-tabul li a").click(function (e) {
            e.preventDefault()

            $(this).tab('show');
            $(".tg-tab-scroll").mCustomScrollbar(); 
            $(".tg-tabul li").removeClass('active'); 
            $(this).parent().addClass('active');
             
            var tab_id = $(this).attr('data-id'); 
            $('.tg-maintab-i').slideUp();
            $('.tg-maintab-i[data-id="' + tab_id + '"]').slideDown();
            if ($(window).width() < 768) {
                $('html, body').animate({ scrollTop: $(".tg-maintab").offset().top - 50 }, 1000);
            }

        });
        $(".trg-proimg").click(function () { 
            $('html, body').animate({ scrollTop: $(".tg-udthe").offset().top + 30 }, 1000);
        });
         
    });
})(window.jQuery);