$('.alphabet>li>a').click(function () {
    if ($('#view-pre').attr('data-page') == '1') {
        $('#view-pre').hide();
    }
    $('#view-pre').hide();
    $('.alphabet>li>a').removeClass('active');
    $(this).addClass('active');
     var letter = $(this).data('name');
     $('.lsttag').html('');
     $.get("Ajax/Tags/GetListTagByAlphabet", { letters: letter }, function (data) {
        $('#view-next').show();
         $('#view-next').attr('data-ascii', "'" + letter + "'");
         $('#view-pre').attr('data-ascii', "'"+ letter+ "'");
         $('#view-pre').attr('data-page', '1');
            $('#view-next').attr('data-page', '2');
            if (data.length < 2350) {
                $('.tabs_link_paging').hide();
                $('.lsttag').html('');
                $('.lsttag').append('<div class="tabs_link_item clearfix"><p>Hiện tại chưa có tags này !</p></div>');
                //$('.lsttag').html('<p>Hiện tại chưa có tags này !</p>');
            } else {
                $('.tabs_link_paging').show();
                $('.lsttag').append(data);
                if ($('.nextmore').data('id') == 'False') {
                    $('#view-next').hide();
                }
            }
        });
    });