(function(_, $) {
        $(window).load(function() {
                if ($('.fixed-enabled').length > 0) {
//                        var headerHeight = $('.tygh-header').offset().top + 50;
                        var headerHeight = 128;
                        var mainNav = $('.fixed-enabled');
                        $(window).scroll(function() {
                                var scrollY = $(window).scrollTop();
                                if (scrollY > headerHeight) {
                                        mainNav.addClass('fixed-nav');
                                } else if (scrollY < headerHeight) {
                                        mainNav.removeClass('fixed-nav');
                                }
                        });
                }
                
        });
}(Tygh, Tygh.$));
