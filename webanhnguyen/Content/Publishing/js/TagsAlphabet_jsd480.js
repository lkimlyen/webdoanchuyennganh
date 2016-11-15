$(document).ready(function () {
        if ($('#view-pre').attr('data-page') == '1') {
            $('#view-pre').hide();
        }
    });
    $('#view-next').click(function () {
        var _self = $(this);
        $.get("/Ajax/Tags/LoadMoreListTagByAlphabet", { page: $(_self).attr('data-page'), letters: $('.tabs_link_tit').text() }, function (data) {
            $('.lsttag').html('');
            $('.lsttag').html(data.lsttagalpha);
            if (data.next) {
                $('#view-pre').attr('data-page', parseInt(_self.attr('data-page')));
                _self.attr('data-page', parseInt(_self.attr('data-page')) + 1);
                if ($('#view-pre').attr('data-page') > 1) {
                    $('#view-pre').attr('style', 'display:inline');
                }
            } else {
                $('#view-next').hide();
                $('#view-pre').attr('data-page', parseInt(_self.attr('data-page')));
                _self.attr('data-page', parseInt(_self.attr('data-page')) + 1);
                _self.attr('style', 'display:none');
                $('#view-pre').attr('style', 'display:inline');
            }
        }).done(function () {

        });
    });

    $('#view-pre').click(function () {
        var _self = $(this);
        $.get("/Ajax/Tags/LoadMoreListTagByAlphabet", { page: $(_self).attr('data-page') - 1, letters: $('.tabs_link_tit').text() }, function (data) {
            $('.lsttag').html(data.lsttagalpha);
            if (data.next) {
                $('#view-next').attr('data-page', parseInt(_self.attr('data-page')));
                _self.attr('data-page', parseInt(_self.attr('data-page')) - 1);
                $('#view-next').show();
                if ($('#view-pre').attr('data-page') <= 1) {
                    $('#view-pre').attr('style', 'display:none');
                }
            }
            else {
                _self.attr('style', 'display:none');
            }
        }).done(function () {
        });
    });