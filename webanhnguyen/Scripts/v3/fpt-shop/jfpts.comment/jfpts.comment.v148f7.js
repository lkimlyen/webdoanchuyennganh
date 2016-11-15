/**
 * @author Nghiatc2.
 * @description Script for comment FptShop
 **/

jQuery(document).ready(function ($) {
    if ($('#wrapper-nt-comment').length > 0) {
        var commentFptShop = new CommentFptShop({
            moduleId: $('#wrapper-nt-comment').attr('data-modul')
        });
        commentFptShop.init();
    }
});

/**
 * Comment Object
 */
var CommentFptShop = function (option) {
    this.option = jQuery.extend({
        moduleId: 0
    }, option);
};

CommentFptShop.prototype.init = function () {
    var self = this;

    $(".scrollerbar").css("padding-right", "15px");

    $('#wrapper-nt-comment').html(self.buildHtmlTemplateInit());

    $(document).on('click', '.fcm-login-close', function () {
        $(this).closest('.fcm-login').hide('slow');
        $(document).find('.fshop-cmt-tabtn').show();
    });

    $(document).on('click', '.fcm-login-fb', function () {	
		console.log("Login FB");
        LoginFacebook($(this));		
    });

    $(document).on('click', '.new-comment-ntc a', function () {
        var htmlView = $('#listCommentCate').data('view');

        $('#listCommentCate').prepend(htmlView);

        $(this).closest('.new-comment-ntc').remove();
    });

    self.loadComment(undefined, undefined, undefined, 1, false);

    self.filterComment();

    self.sortComment();

    self.sendComment();

    self.likeComment();

    self.replyComment();

    self.pagingComment();

    self.setIconEmotionComment();
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used build init html when lload page.
 */
CommentFptShop.prototype.buildHtmlTemplateInit = function () {
    var htmlInit = $([
        "<div class='fshop-comment'>",
            "<div class='fshop-cmttitle'>",
                "Bình luận<span class='fshop-cmtcount'>0</span>",
            "</div>",
            "<div class='fshop-cmt-head'>",
                "<div class='clearfix'>",
                    "<div class='fshop-cmt-col6'>",
                        "<div class='fshop-cmt-form'>",
                            "<input id='txt-filter-comment' type='text' class='fshop-cmt-ftxt' placeholder='Tìm kiếm bình luận...'>",
                            "<div class='fshop-cmt-fsbox'>",
                                "<select class='fshop-cmt-fselect' id='select-condition-filter-comment'>",
                                    "<option value='0'>Tất cả</option>",
                                    "<option value='2'>Email</option>",
                                    "<option value='3'>Tên</option>",
                                "</select>",
                            "</div>",
                        "</div>",
                    "</div>",
                    "<div class='fshop-cmt-col6'>",
                        "<div class='fshop-cm-hsort'>",
                            "<span data-value='1' class='sort-comment active'>Mới nhất</span> | <span class='sort-comment' data-value='0'>Quan tâm nhất</span>",
                        "</div>",
                    "</div>",
                "</div>",
            "</div>",
            "<div class='fshop-cmt-main'>",
                "<div class='clearfix'>",
                    "<form>",
                        "<div class='fshop-cmt-tabox'>",
                            "<textarea id='txt-comment-cate' class='fshop-cmt-textarea' rows='3' placeholder='Viết bình luận của bạn...'></textarea>",
                            "<input type='submit' class='fshop-cmt-tabtn' value='Bình luận' id='btnCommentCate'>",
                        "</div>",
                    "</form>",
                    "<div class='fcm-login'>",
                        "<div class='fcm-login-tb clearfix'>",
                            "<span class='fcm-login-close'>×</span>",
                            "<form id='register-information'>",
                                "<div class='fcm-login-col'>",
                                    "<p class='fcm-login-title'>Nhập thông tin để bình luận:</p>",
                                    "<p><input class='fcm-login-txt' type='text' placeholder='Họ tên (bắt buộc)' name='name'/></p>",
                                    "<p><input class='fcm-login-txt' type='email' placeholder='Email' name='email'/></p>",
                                    "<p><input class='fcm-login-txt' type='text' placeholder='Điện thoại' name='phone'/></p>",
                                    "<p><input class='fcm-login-btn' type='submit' value='Bình luận' /></p>",
                                "</div>",
                            "</form>",
                            "<div class='fcm-login-col'>",
                                "<p class='fcm-login-title'>Hoặc đăng nhập qua: </p>",
                                "<ul class='fcm-login-sul'>",
                                    "<li>",
                                        "<a href='javascript:void(0);' title='' class='fcm-login-fb'>",
                                            "<img src='Content/Publishing/css/images/cmt/i_facebook3860.png?v=1' />",
                                            "<strong>Facebook</strong>",
                                        "</a>",
                                    "</li>",
                                "</ul>",
                            "</div>",
                        "</div>",
                    "</div>",
                    "<div id='listCommentCate'>",
                    "</div>",
                "</div>",
            "</div>",
            "<div class='fshop-cmt-cmtmores' id='ntc-viewmore-comment' data-page='2'>",
                "<span>Xem thêm <strong>0</strong> bình luận</span>",
            "</div>",
        "</div>"
    ].join("\n"));

    return htmlInit;
};

CommentFptShop.prototype.pageID = 0;

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used load comment.
 * @param keyword Keyword used for search comment.
 * @param searchin Search by email or name.
 * @param sort Sort comment 1=>search by latest.
 */
CommentFptShop.prototype.loadComment = function (keyword, searchin, sort, currentPage, isPaging) {
    var self = this,
        keywordTemp = keyword || "",
        searchinTemp = searchin || 0,
        sortTemp = sort || 1,
        currentPageTemp = currentPage || 1,
        elementAppendComment = $('#wrapper-nt-comment').find('#listCommentCate'),
        $btnPaging = $('#wrapper-nt-comment').find('#ntc-viewmore-comment'),
        idNews = 0;

    if (elementAppendComment.length > 0) {
        $.ajax({
            type: 'GET',
            url: UtilCommentFS.linkAjax().linkApiGetListComment,
            data: {
                pageId: self.pageID,
                modulId: self.option.moduleId,
                referID: $('.fnews-detail-rating').length > 0 ? $('.fnews-detail-rating').attr('data-id') : 0,
                title: ($("head title")[0]).text,
                orderby: sortTemp,
                keyword: keywordTemp,
                catesearch: searchinTemp,
                page: currentPageTemp,
                isNewTemplate: true
            },
            beforeSend: function () {
                if (!isPaging) {
                    elementAppendComment.html(UtilCommentFS.configConstant().imgBigLoading);
                } else {
                    $btnPaging.html(UtilCommentFS.configConstant().imgLoading);
                }
            }
        }).done(function (data) {

            if (isPaging) {
                elementAppendComment.append(data.View);
                $btnPaging.attr('data-page', Number(currentPageTemp) + 1);
            } else {
                elementAppendComment.html(data.View);
            }

            if (data.TotalRecordRest > 0) {
                $btnPaging.show().html("<span>Xem thêm <strong >0</strong> bình luận</span>").find('strong').text(data.TotalRecordRest);
            } else {
                $btnPaging.hide().attr('data-page', 2);
            }

            $('#wrapper-nt-comment').find('.fshop-cmtcount').text(data.Total);

            self.pageID = data.PageID;

            self.setLikeCommentInit();

            //self.loadNewComment();
        });
    }
};

CommentFptShop.prototype.loadNewComment = function () {
    var pidId = 0;

    clearInterval(pidId);
    pidId = setInterval(function () {
        $.ajax({
            type: 'GET',
            url: UtilCommentFS.linkAjax().linkGetNewComment,
            data: { pageId: this.pageID, modulId: this.option.moduleId, currentLastId: $('#listCommentCate').find('.fshop-cmt-numlike').first().attr('data-id') }
        }).done(function (data) {
            if (data && Number(data.Total) > 0) {
                var htmlNotification = $([
                    "<div class='new-comment-ntc'>",
                        "<span>Bạn có <strong>0</strong> comment mới.</span>",
                        "<a href='javascript:void(0);'>Click để xem</a>",
                    "</div>"
                ].join('\n'));

                $('#listCommentCate').data('view', data.View);
                $(document).find('.new-comment-ntc').remove();
                htmlNotification.insertBefore('.fshop-cmt-head').fadeIn('300').find("strong").text(data.Total);
            }
        });
    }.bind(this), UtilCommentFS.configConstant().timerGetNewComment);
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used for paging comment
 */
CommentFptShop.prototype.pagingComment = function () {
    var self = this;

    $('#wrapper-nt-comment').find('#ntc-viewmore-comment').off('click').on('click', function () {
        var dataPage = $(this).attr('data-page'),
            valueFilter = self.getValueFilter();

        self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, dataPage, true);
        $('.fshop-cmt-main').scrollTop($('.fshop-cmt-main')[0].scrollHeight);
    });
};
/**
 * @author Nghiatc2.
 * @function
 * @description The function used send comment to server.
 */
CommentFptShop.prototype.sendComment = function () {
    var self = this,
        commentKeyup = '';

    $('#wrapper-nt-comment').off('click', '.fshop-cmt-tabtn').on('click', '.fshop-cmt-tabtn', function (event) {
        event.preventDefault();

        var $self = $(this),
            comment = $self.prev().val(),
            idComment = $self.attr('data-id') || 0,
            $fcmLogin = $self.closest('.fshop-cmt-tabox').parent().next();

        comment = UtilCommentFS.standardizedString(comment);

        if ($.type(comment) === 'undefined' || comment.length < 4) {
            ToastFts.showToast({
                text: 'Bạn cần nhập nội dung lớn hơn 3 ký tự.',
                type: 'Warning'
            });
            return;
        }

    });

    $(document).on('keyup', '.fshop-cmt-textarea', function () {
        var userName = '',
            phone = '',
            email = '',
            $self = $(this),
            $fshopCmtTabtn = $self.next(),
            $fcmLogin = $self.closest('.fshop-cmt-tabox').parent().next(),
            idComment = $self.attr('data-id') || 0;

        commentKeyup = $self.val();

        if (commentKeyup.length > 3) {
            $fshopCmtTabtn.hide();
            $fcmLogin.show('slow', function () {
                $(this).find('.fcm-login-btn').off('click').on('click', function (e) {					
                    e.preventDefault();
                    var $selfFcmLoginBtn = $(this);

                    userName = $selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="name"]').val();
                    email = $selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="email"]').val();
                    phone = $selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="phone"]').val();

                    if (!userName) {
                        ToastFts.showToast({
                            text: 'Bạn cần nhập họ tên!.',
                            type: 'Warning'
                        });
                        return false;
                    }

                    //if (!UtilCommentFS.isValidatePhone(phone)) {
                    //    ToastFts.showToast({
                    //        text: 'Bạn chưa nhập số điện thoại hoặc Số điện thoại sai định dạng!.',
                    //        type: 'Warning'
                    //    });
                    //    return false;
                    //}

                    $fcmLogin.hide('slow');
                    UtilCommentFS.resetInput(['.fshop-cmt-textarea', '.fcm-login-txt']);
                    $.ajax({
                        type: 'POST',
                        url: UtilCommentFS.linkAjax().linkApiAddComment,
                        data: {
                            pageId: self.pageID,
                            shopCommentID: idComment,
                            content: commentKeyup,
                            name: userName,
                            email: email,
                            phone: phone
                        }
                    }).done(function (data) {
                        if (data.ID === -1) {
                            ToastFts.showToast({
                                text: 'Bạn phải vào trang FPTShop mới có thể bình luận',
                                type: 'Warning'
                            });
                            return false;
                        } else if (data.ID === -2) {
                            ToastFts.showToast({
                                text: 'Bạn không thể bình luận liên tiếp trong 10 giây',
                                type: 'Warning'
                            });
                            return false;
                        } else {
                            if (idComment === 0) {
                                $('#wrapper-nt-comment').find('#listCommentCate').prepend(self.buildHtmlComment(true, {
                                    id: data.ID,
                                    username: userName,
                                    comment: commentKeyup
                                }));
                            } else {
                                $self.closest('.fshop-cmt-hide').after(self.buildHtmlComment(false, {
                                    id: data.ID,
                                    username: userName,
                                    comment: commentKeyup
                                })).hide();
                            }

                            self.pageID = data.PageID;

                            //self.SendAnsync({
                            //    linkAnsyn: UtilCommentFS.linkAjax().linkApiAsync,
                            //    contenComment: commentKeyup,
                            //    ID: data.ID,
                            //    title: ($("head title")[0]).text,
                            //    modulId: self.option.moduleId
                            //});

                            ToastFts.showToast({
                                text: UtilCommentFS.configConstant().messageSuccess
                            });
                        }
                    });
                    $fshopCmtTabtn.show();
                    return false;
                });
            });
        }
    });
};

CommentFptShop.prototype.SendAnsync = function (option) {
    $.post(option.linkAnsyn,
    {
        message: option.contenComment,
        commentId: option.ID,
        title: option.title,
        modulId: option.modulId
    },
    function () {

        console.log("da gui thong bao");
    });
};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used for filter comment.
 */
CommentFptShop.prototype.filterComment = function () {
    var self = this;

    $('#wrapper-nt-comment').on('keyup', '#txt-filter-comment', function (e) {
        var valueFilter = self.getValueFilter();

        if (e.keyCode == 13) {

            if (!valueFilter.keyword) {
                alert("Bạn chưa nhập thông tin tìm kiếm");
                return false;
            }

            self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, false);
            $('#wrapper-nt-comment').find('#ntc-viewmore-comment').attr('data-page', 2);
        }
        return false;
    });
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used for sort comment
 */
CommentFptShop.prototype.sortComment = function () {
    var self = this;

    $('#wrapper-nt-comment').on('click', '.fshop-cm-hsort span', function () {
        var $self = $(this);

        $self.closest('.fshop-cm-hsort').find('.active').removeClass('active');

        $self.addClass('active');

        var valueFilter = self.getValueFilter();

        self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, false);

        $('#wrapper-nt-comment').find('#ntc-viewmore-comment').attr('data-page', 2);
    });
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used get all value use for filter.
 * @return {object}
 */
CommentFptShop.prototype.getValueFilter = function () {
    var valueFilter = $.extend({
        keyword: '',
        searchin: 0,
        sort: 1
    }, {
        keyword: UtilCommentFS.standardizedString($('#wrapper-nt-comment').find('#txt-filter-comment').val()),
        searchin: $('#wrapper-nt-comment').find('#select-condition-filter-comment').val(),
        sort: $('#wrapper-nt-comment').find('.fshop-cm-hsort').find('.active').attr('data-value')
    });
    return valueFilter;
};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used when user like or unlike comment.
 */
CommentFptShop.prototype.likeComment = function () {
    var self = this;

    $('#wrapper-nt-comment').on('click', '.fshop-cmt-btnlike', function () {
        var $self = $(this),
            idComment = $self.next('.fshop-cmt-numlike').attr('data-id'),
            elementNumberLike = $self.next('.fshop-cmt-numlike').find('span');

        // used unlike
        if ($self.hasClass('liked')) {
            $self.removeClass('liked');

            //decrease like
            elementNumberLike.text(Number(elementNumberLike.text()) - 1);

            $self.text('Thích');

            $.post(UtilCommentFS.linkAjax().linkApiUnLike, { CommentID: idComment }).done(function () {
                self.saveLikeCommentToCookie(idComment, false);
            });
        } else {
            $self.addClass('liked');

            // increase like up 1.
            elementNumberLike.text(Number(elementNumberLike.text()) + 1);

            $self.text("Bỏ thích");

            $.post(UtilCommentFS.linkAjax().linkApiLike, { CommentID: idComment }).done(function (data) {
                self.saveLikeCommentToCookie(idComment, true);
            });
        }
    });
};

CommentFptShop.prototype.buildHtmlComment = function (isParent, option) {
    var html = "";

    if (isParent) {
        html = $([
            "<div class='fshop-cmt-item'>",
                "<div class='fshop-cmt-ask'>",
                    "<div class='fshop-cmt-textmain'>" + option.comment + "</div>",
                    "<div class='fshop-cmt-bottmain clearfix'>",
                        "<div class='fshop-cmt-col6'>",
                            "<img class='fshop-cmt-avatar' src='http://fptshop.com.vn/Content/assest/images/no-avatar.png?v=9999' alt=''>",
                            "<span class='fshop-cmt-user'>",
                                "<strong>" + option.username + "</strong> - " + UtilCommentFS.getBackDate(new Date()),
                            "</span>",
                        "</div>",
                        "<div class='fshop-cmt-col6'>",
                            "<p class='fshop-cmt-relate'>",
                                "<span class='fshop-cmt-btnreply' data-id='" + option.id + "'>Trả lời</span>",
                                "<span class='fshop-cmt-btnlike'>Thích</span>",
                                "<span class='fshop-cmt-numlike' data-id='" + option.id + "'>",
                                    "<img src='Content/Publishing/Comment/img/icon-numlike.png'>",
                                    "<span class='number-like'>0</span>",
                                "</span>",
                            "</p>",
                        "</div>",
                    "</div>",
                "</div>",
                "<div class='fshop-cmt-reply fshop-cmt-hide'>",
                    "<form>",
                        "<div class='fshop-cmt-tabox'>",
                            "<textarea class='fshop-cmt-textarea' rows='2' placeholder='Viết bình luận của bạn...'></textarea>",
                            "<input data-id='" + option.id + "' type='button' class='fshop-cmt-tabtn btn-reply-comment' value='Bình luận'>",
                        "</div>",
                    "</form>",
                "</div>",
            "</div>"
        ].join("\n"));
    } else {
        html = $([
            "<div class='fshop-cmt-reply'>",
                "<div class='fshop-cmt-textmain'>" + option.comment + "</div>",
                "<div class='fshop-cmt-bottmain clearfix'>",
                    "<div class='fshop-cmt-col6'>",
                        "<img class='fshop-cmt-avatar' src='http://fptshop.com.vn/Content/assest/images/no-avatar.png?v=9999' alt=''>",
                        "<span class='fshop-cmt-user'>",
                            "<strong>" + option.username + "</strong>" + "<i></i> - " + UtilCommentFS.getBackDate(new Date()),
                        "</span>",
                    "</div>",
                    "<div class='fshop-cmt-col6'>",
                        "<p class='fshop-cmt-relate'>",
                            "<span class='fshop-cmt-btnlike'>Thích</span>",
                            "<span class='fshop-cmt-numlike' data-id='" + option.id + "'>",
                                "<img src='http://fptshop.com.vn/Content/Publishing/Comment/img/icon-numlike.png' alt=''>",
                                "<span class='number-like'>0</span>",
                            "</span>",
                        "</p>",
                    "</div>",
                "</div>",
            "</div>"
        ].join("\n"));
    }
    return html;
};

CommentFptShop.prototype.replyComment = function () {
    $('#wrapper-nt-comment').on('click', '.fshop-cmt-btnreply', function () {
        var $self = $(this);

        $self.closest('.fshop-cmt-ask').next().toggle(300);
    });
};

/**
 * @author Nghiatc2.
 * @function.
 */
CommentFptShop.prototype.setLikeCommentInit = function () {
    var cookieLikeObject = UtilCommentFS.getCookie(UtilCommentFS.configConstant().nameLikeCookie),
        cookieLike;

    if ($.trim(cookieLikeObject) !== '') {
        cookieLike = JSON.parse(cookieLikeObject);

        $('#wrapper-nt-comment').find('.fshop-cmt-btnlike').each(function () {
            var $self = $(this),
                idComment = $self.next().attr('data-id');

            $.each(cookieLike, function (i, v) {
                if (Number(idComment) === Number(v)) {
                    $self.addClass('liked').text('Bỏ thích');
                }
            });
        });
    }
};

CommentFptShop.prototype.saveLikeCommentToCookie = function (idComment, isLike) {
    var cookieLikeObject = UtilCommentFS.getCookie(UtilCommentFS.configConstant().nameLikeCookie),
        cookieLike = [];

    if ($.trim(cookieLikeObject)) {
        cookieLike = JSON.parse(cookieLikeObject);
    }

    if (isLike) {
        cookieLike.push(idComment);
    } else {
        cookieLike = $.grep(cookieLike, function (value) {
            return Number(value) != Number(idComment);
        });
    }

    UtilCommentFS.setCookie(UtilCommentFS.configConstant().nameLikeCookie, JSON.stringify(cookieLike), 365);
};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function add icon emotion to parent comment
 */
CommentFptShop.prototype.setIconEmotionComment = function() {
    $(document).find('#ntc-wrapper-add-icon').find('span').off('click').on('click', function() {
        $(this).closest('.ntc-icon-smile').prev().find('.fshop-cmt-textarea').val($(this).html());
    });
};


var UtilCommentFS = (function ($) {
    var linkAjax, standardizedString,
        setCookie, getCookie,
        configConstant, getBackDate,
        checkEmail,
        resetInput;

    linkAjax = function () {
        var linkApi = "http://api.fptshop.com.vn/Ajax/Comment/";

        return {
            linkApiGetListComment: linkApi + "GetListComment",
            linkApiAddComment: linkApi + "AddComment",
            linkApiLike: linkApi + "Like",
            linkApiUnLike: linkApi + "Unlike",
            linkGetNewComment: linkApi + "GetLastestComment",
            linkApiAsync: "http://api.fptshop.com.vn/message"
        };
    };

    /**
     * @author Nghiatc2.
     * @function.
     * @description Chuẩn hóa chuỗi.
     * @param {string} chuỗi cần chuẩn hóa.
     */
    standardizedString = function (string) {
        var stringTemp = string,
            newValue = '';

        if (stringTemp) {

            /*Loại bỏ các ký tự đặc biệt*/
            stringTemp = stringTemp.replace(/!|\$|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\'| |\"|\&|\#|\[|\]|~/g, " ");

            var arrStr = stringTemp.match(/\S+/g);

            $.each(arrStr, function (i, v) {
                newValue += $.trim(v) + ' ';
            });
        }

        return stringTemp;
    };

    getCookie = function (cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';'),
            i = 0,
            length = ca.length;

        for (; i < length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
        }
        return "";
    };

    setCookie = function (cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires=" + d.toUTCString();
        document.cookie = cname + "=" + cvalue + "; " + expires;
    };

    configConstant = function () {
        return {
            nameEmailCookie: "ftscustomerEmail",
            nameCustomerCookie: "ftscustomerName",
            namePhoneCookie: 'ftscustomerPhone',
            nameLikeCookie: 'ftsCokkieLL',
            messageSuccess: "<span>Bình luận của bạn đã được ghi nhận</span>.</br><span>Chúng tôi sẽ phản hồi bạn sau ít phút nhé!</span>",
            imgLoading: "<img src='http://fptshop.com.vn/Content/images/ajax_loader_small.gif'>",
            imgBigLoading: "<img style='margin:0 auto;' src='http://fptshop.com.vn/Content/images/ajax_loader_big.gif'>",
            timerGetNewComment: 120000
        };
    };

    getBackDate = function (currentDateTime) {
        var result = "";

        var day = Math.round((new Date() - currentDateTime) / (24 * 60 * 60 * 1000));
        var hours = Math.round(((new Date() - currentDateTime) / 1000 / 60 / 60), 1);
        var minute = Math.round((new Date() - currentDateTime) / 6000, 1);
        var second = Math.round((new Date() - currentDateTime) / 1000, 1);

        result = second + " giây trước";

        if (minute > 0) {
            result = minute + " phút trước";
        }

        if (hours > 0) {
            result = hours + " giờ trước";
        }

        if (day > 0) {
            result = day + " ngày trước";
        }

        if (day > 30) {
            result = "vào ngày " + currentDateTime.getDate() + "/" + date.getMonth() + 1 + "/" + date.getFullYear();
        }

        return result;
    };

    checkEmail = function (email) {
        var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
        return re.test(email);
    };

    isValidatePhone = function (phone) {
        var regex = /^0[0-9]{9,10}$/;

        if (phone.match(regex)) {
            return true;
        } else {
            return false;
        }
    }

    resetInput = function (arrayName) {
        if (arrayName) {
            $.each(arrayName, function (i, v) {
                $(document).find(v).val('');
            });
        }
    };

    return {
        linkAjax: linkAjax,
        standardizedString: standardizedString,
        setCookie: setCookie,
        getCookie: getCookie,
        configConstant: configConstant,
        getBackDate: getBackDate,
        checkEmail: checkEmail,
        resetInput: resetInput,
        isValidatePhone: isValidatePhone
    };
})(jQuery);

var ToastFts = (function ($) {
    var showToast,
        buildHtml,
        closeToast;

    buildHtml = function (options) {
        var cssObj = {
            background: '#71b371',
            img: 'http://fptshop.com.vn/Content/v3/images/icon_success.png',
            color: '#fff'
        };

        if (options.type === 'Warning') {
            cssObj.background = '#C14D4D';
            cssObj.img = 'Content/v3/images/icon_warning.png';
            cssObj.color = '#F7F7F7';
        }

        var html = $([
           "<div class='nts-toast' style='width:298px;z-index:9999;margin: 0 auto;position: fixed;top: 50%;left: 50%;margin-left: -145px;margin-top: -26px;'>",
            "<div class='nts-wrapper' style='border:1px #71b371 solid;background: " + cssObj.background + ";color: " + cssObj.color + ";height: auto;border-radius: 3px;-moz-border-radius: 3px;-webkit-border-radius: 3px;padding:12px 12px 10px 1px;;font-size:12px;line-height: 24px;position: relative;'>",
                "<div class='nts-close' style='position: absolute;right: 5px;top: 0;cursor: pointer'>x</div>",
                "<div class='nts-icon-success' style='position: absolute;background: url(" + cssObj.img + ");width: 32px;height : 32px;left:7px'>",
                "</div>",
                "<div class='nts-content' style='padding-left: 40px;text-align: center;'>" + options.textMessage + "</div>",
            "</div>",
        "</div>"
        ].join('\n'));
        return html;
    };

    closeToast = function () {
        $(document).on('click', '.nts-close', function () {
            $('body').find('.nts-toast').fadeOut('slow', function () {
                setTimeout(function () {
                    this.remove();
                }.bind($(this)), 1000);
            });
        });
    };

    showToast = function (options) {
        var settings = $.extend({
            type: 'success',
            text: '',
            stayTime: 5000
        }, options),
            htmlToast = '';

        htmlToast = buildHtml({
            textMessage: settings.text,
            type: settings.type
        });

        $('body').append(htmlToast);

        setTimeout(function () {
            $('body').find('.nts-toast').fadeOut('slow', function () {
                setTimeout(function () {
                    this.remove();
                }.bind($(this)), 1000);
            });
        }, 3000);

        closeToast();
    };

    return {
        showToast: showToast
    };
})(jQuery);
/**
Process for facebook login
**/

window.fbAsyncInit = function () {
    FB.init({
        appId: '1468144196840722', // App ID 346099572207846 localhost: 557842437665346
        status: true, // check login status
        cookie: true, // enable cookies to allow the server to access the session
        xfbml: true  // parse XFBML
    });
};

// Load the SDK asynchronously
(function (d) {
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) { return; }
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "../cdn.fptshop.com.vn/Content/all.js";
    ref.parentNode.insertBefore(js, ref);
}(document));

function LoginFacebook(jqueyObject) {
    FB.login(function (response) {
        if (response.status === 'connected') {
            getLogin(jqueyObject);
        } else {
            console.log('User cancelled login or did not fully authorize.');
        }
    }, { scope: 'email,public_profile,user_friends' });
}

function getLogin(jqueyObject) {
    FB.api('/me?fields=name,email', function (response) {
        var userName = '',
            email = '';

        if (response) {
            userName = response.name;
            email = response.email;
			
			var $selfFcmLoginBtn = $('.fcm-login-btn');
			
            $selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="name"]').val(userName);
            $selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="email"]').val(email);
            //$selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="phone"]').val('');
			
			console.log('set gia tri cho text box name');		
            UtilCommentFS.setCookie(UtilCommentFS.configConstant().nameCustomerCookie, userName, 1);
            UtilCommentFS.setCookie(UtilCommentFS.configConstant().nameEmailCookie, email, 1);

            //$('.fcm-login').hide('slow');

            jqueyObject.closest('.fcm-login').prev().find('.fshop-cmt-textarea').focus();
            jqueyObject.closest('.fcm-login').prev().find('.fshop-cmt-tabtn').show();
        }
    });
}
/*End process login facebook*/

