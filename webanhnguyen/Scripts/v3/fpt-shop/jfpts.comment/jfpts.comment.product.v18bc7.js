/**
 * @author Nghiatc2.
 * @description Script for comment product.
 **/

jQuery(document).ready(function ($) {
	var $selfFcmLoginBtn = $('.fcm-login-btn');
	$selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="name"]').val(UtilModuleCommentProduct.getCookie('ftscustomerName'));
	$selfFcmLoginBtn.closest('.fcm-login-col').find('input[name="email"]').val(UtilModuleCommentProduct.getCookie('ftscustomerEmail'));

    var commentProduct = new CommentProduct({
        modulId: UtilModuleCommentProduct.modulId().productPage
    });
    commentProduct.init();

    // View total comment
    $('.detail-title label').text($('.detail-newsmo-mores.clearfix').attr("data-total"));

    $('.container-fluid').find('li a[href="#binh-luan"]').find('label').text($('.detail-newsmo-mores.clearfix').attr("data-total"));

    $('.trg-search-ulcmt a').click(function (e) {
        e.preventDefault();

        $('.trg-search-cmtchoise').text($(this).text()).attr('data-value', $(this).attr('data-value'));

    });

    $(document).on('click', '.answer-comment', function () {
        var $self = $(this);

        $self.closest('.media-body').find('.trg-cm-post').toggle(300);
    });

    $(document).on('click', '.order-product', function () {
        var idProduct = 0;
        var $self = $(this);
        idProduct = $self.data('id');
        jfpts.data.addOrder(idProduct, undefined, null, 0, null, '20000');
    });

    $(document).on('click', '.fcm-login-fb', function () {
        LoginFacebook($(this));
    });

    $(document).on('click', '.fcm-login-close', function () {
        $('.fcm-login').hide('slow');
        $(this).closest('.fcm-login').prev('.form-inline').show();
    });

    $(document).on('click', '.fcm-login-gg', function () {

    });

    $(document).on('click', '.new-comment-ntc a', function () {
        var htmlView = $('#list-comment').data('view');

        //$('#list-comment').find('#info-comment').insertAfter(htmlView);
        $(htmlView).insertAfter('#list-comment #info-comment');
        $(this).closest('.new-comment-ntc').remove();
    });
});

var CommentProduct = function (option) {
    this.option = jQuery.extend({
        modulId: UtilModuleCommentProduct.modulId().productPage
    }, option);
};

CommentProduct.prototype.pageID = 0;

CommentProduct.prototype.init = function () {
    $('.new-comment-ntc').hide();

    var self = this;

    self.focusInputComment();

    //self.loadComment(undefined, undefined, undefined, 1, false);

    self.sendComment();

    self.pagingComment();

    self.sortComment();

    self.filterComment();

    self.likeComment();

    self.toastNts = new ToastSuccess();
};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used load comment.
 * @param keyword Keyword used for search comment.
 * @param searchin Search by email or name.
 * @param sort Sort comment 1=>search by latest.
 */
CommentProduct.prototype.loadComment = function (keyword, searchin, sort, currentPage, isPaging) {
    var self = this,
    keywordTemp = keyword || "",
    searchinTemp = searchin || 0,
    sortTemp = sort || 1,
    currentPageTemp = currentPage || 1,
    $listComment = $('#list-comment'),
    brandId = $('#brand-id').attr('data-id') || 0,
    typeId = $('#type-product').attr('data-id') || 0;

    $.ajax({
        type: 'GET',
        url: UtilModuleCommentProduct.linkAjax().linkApiGetListComment,
        data: {
            pageId: self.pageID,
            modulId: self.option.modulId,
            referID: $('#productId').length > 0 ? $('#productId').val() : 0,
            title: ($("head title")[0]).text,
            orderby: sortTemp,
            keyword: keywordTemp,
            catesearch: searchinTemp,
            page: currentPageTemp,
            isNewTemplate: true,
            brandId: brandId,
            typeId: typeId
        },
        beforeSend: function () {
            if (!isPaging) {
                $listComment.html(UtilModuleCommentProduct.configConstant().imgBigLoading);
            }
        }
    }).done(function (data) {

        if (data.TotalRecordRest > 0) {
            $('.trg-comment-more').show().find('.btn-load-comment strong').text(data.TotalRecordRest);
        } else {
            $('.trg-comment-more').hide();
        }

        if (isPaging) {
            $('.trg-comment-more').removeClass('is-loading-comment');
            $listComment.html(data.View);
            $('#list-comment').attr('data-page', Number(currentPageTemp) + 1);
        } else {
            $listComment.html(data.View);
        }

        // View total comment
        $('.detail-title label').text(data.Total);

        $('.container-fluid').find('li a[href="#binh-luan"]').find('label').text(data.Total);

        self.pageID = data.PageID;

        self.setLikeCommentInit();

        self.getListNewComment();
    });
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used for paging comment
 */
CommentProduct.prototype.pagingComment = function () {
    var self = this;

    //$('.btn-load-comment').off('click').on('click', function () {
    //    var datapage = $('#list-comment').attr('data-page'),
    //        valueFilter = self.getValueFilter();

    //    $('.trg-comment-more').addClass('is-loading-comment');
    //    self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, datapage, true);
    //});

    $(document).on('click', 'a.pageNumber', function () {
        $("html, body").animate({ scrollTop: $('#list-comment').offset().top }, 1000);
        var currentPage = parseInt($(this).attr('data-page'));
        var pageSize = parseInt($('.detail-newsmo-mores.clearfix').attr('data-pagesize'));
        var total = parseInt($('.detail-newsmo-mores.clearfix').attr('data-total'));
        var stepRecord = parseInt($('.detail-newsmo-mores.clearfix').attr('data-step'));

        var datapage = $(this).attr('data-page'),
            valueFilter = self.getValueFilter();

        $('.detail-newsmo-mores.clearfix').html(CommentProduct.prototype.buidPaging(stepRecord, currentPage, pageSize, total));

        $('.trg-comment-more').addClass('is-loading-comment');
        self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, datapage, true);

        /*add by phenv2 18-03-2016*/
        var url = $('.detail-newsmo-mores.clearfix').attr('data-link');
        var temUrl = "";
        if (url.indexOf('?') < 0) {
            temUrl = url + "?binhluan=" + currentPage;
        }
        else {
            if (url.indexOf('binhluan') < 0) {
                temUrl = url + "&binhluan=" + currentPage;
            }
            else {
                if (url.indexOf('?binhluan') < 0) {
                    temUrl = url.replace(/&binhluan=\d/i, '&binhluan=' + currentPage);
                }
                else {
                    temUrl = url.replace(/\?binhluan=\d/i, '?binhluan=' + currentPage);
                }
            }
        }

        history.pushState({}, null, temUrl);

        /*end*/

    });

};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used to get list new comment
 * when user not reload page...
 */
CommentProduct.prototype.getListNewComment = function () {
    var pidId = 0;

    clearInterval(pidId);
    pidId = setInterval(function () {
        $.ajax({
            type: 'GET',
            url: UtilModuleCommentProduct.linkAjax().linkGetNewComment,
            data: { pageId: this.pageID, modulId: this.option.modulId, currentLastId: $('#list-comment').find('.like-comment').first().attr('data-id') }
        }).done(function (data) {
            if (data && Number(data.Total) > 0) {
                var htmlNotification = $([
                    "<div class='new-comment-ntc'>",
                        "<span>Bạn có <strong>0</strong> comment mới.</span>",
                        "<a href='javascript:void(0);'>Click để xem</a>",
                    "</div>"
                ].join('\n'));

                $('#list-comment').data('view', data.View);

                $(document).find('.new-comment-ntc').remove();
                htmlNotification.insertAfter('.trg-cm-header').fadeIn('300').find("strong").text(data.Total);
            }
        });
    }.bind(this), UtilModuleCommentProduct.configConstant().timerGetNewComment);
};


/**
 * @author Nghiatc2.
 * @function
 * @description The function used get all value use for filter.
 * @return {object}
 */
CommentProduct.prototype.getValueFilter = function () {
    var valueFilter = $.extend({
        keyword: '',
        searchin: 0,
        sort: 1
    }, {
        keyword: UtilModuleCommentProduct.standardizedString($('.txt-search-comment').val()),
        searchin: $('.trg-search-cmtchoise').attr('data-value'),
        sort: $('.trg-cm-hsort .active').attr('data-value')
    });
    return valueFilter;
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used send comment to server.
 */
CommentProduct.prototype.sendComment = function () {
    var self = this,
        commentKeyup = '';

    // click show form register information for send comment.
    $(document).on('click', '.trg-bnt-post', function () {
        var $self = $(this),
            contenComment = $self.closest('.media-body').find('textarea').val(),
            trgCmPostSub = $self.closest('.trg-cm-post-sub'),
            idParentComment = $self.attr('data-id') || 0;

        contenComment = UtilModuleCommentProduct.standardizedString(contenComment);

        if ($.type(contenComment) === 'undefined' || contenComment.length < 4) {
            jfpts.utility.notifyWarningCenter('Bạn cần nhập nội dung lớn hơn 3 ký tự.');
            return;
        }
    });

    $(document).on('keyup', '.comment-box textarea', function () {
        /*Lấy về cookie của user*/
        var emailUser = '',		
            customerName = '',
            phone = '',
            $self = $(this),
            $fcmLogin = $self.parent('.comment-box').find('.fcm-login'),
            $frmInline = $self.parent('.comment-box').find('.form-inline'),
            trgCmPostSub = $self.closest('.trg-cm-post-sub'),
            idParentComment = $self.attr('data-id') || 0;

        commentKeyup = $self.val();
		//debugger;
		console.log('vao debug');
		
        if (!customerName && commentKeyup.length > 3) {
            $frmInline.hide();
            $fcmLogin.show('slow', function () {
                var $thisFcm = $(this);

                $thisFcm.find('#register-information').validate({
                    rules: {
                        name: {
                            required: true,
                            minlength: 2
                        }
						//,
                        //phone: {
                         //   required: true,
                         //   minlength: 10,
                         //   maxlength: 11,
                         //   number: true
                        //}
                    },
                    messages: {
                        name: {
                            required: 'Bạn cần nhập tên',
                            minlength: 'Họ và tên cần lớn hơn 2 ký tự',
                        }//,
                        //phone: {
                         //   required: 'Bạn cần nhập số điện thoại',
                        //   minlength: 'Số điện thoại tối thiểu 10 số',
                        //    maxlength: 'Số điện thoại tối đa 11 số',
                        //    number: 'Vui lòng nhập đúng định dạng'
                        //}
                    },
                    submitHandler: function (e) {
                        // Get information of user from popup.
						
						if(emailUser == '')
                        emailUser = $thisFcm.find('#register-information').find('input[name="email"]').val().toString();
						
						if(customerName == '')
                        customerName = $thisFcm.find('#register-information').find('input[name="name"]').val().toString();
                        phone = $thisFcm.find('#register-information').find('input[name="phone"]').val();

                        $.ajax({
                            type: 'POST',
                            url: UtilModuleCommentProduct.linkAjax().linkApiAddComment,
                            data: {
                                pageId: self.pageID,
                                shopCommentID: idParentComment,
                                content: commentKeyup,
                                name: customerName,
                                email: emailUser,
                                phone: phone
                            }
                        }).done(function (data) {
                            $fcmLogin.hide('slow');

                            if (data.ID === -1) {
                                jfpts.utility.notifyWarningCenter('Bạn phải vào trang FPTShop mới có thể bình luận');
                                return false;
                            } else if (data.ID === -2) {
                                jfpts.utility.notifyWarningCenter('Bạn không thể bình luận liên tiếp trong 10 giây.');
                                return false;
                            } else {
                                if (idParentComment === 0) {
                                    $('#info-comment').after(self.buildImmediateComment(true, {
                                        id: data.ID,
                                        username: customerName,
                                        comment: commentKeyup
                                    }));
                                } else {
                                    trgCmPostSub.before(self.buildImmediateComment(false, {
                                        id: data.ID,
                                        username: customerName,
                                        comment: commentKeyup
                                    })).hide();
                                }

                                self.pageID = data.PageID;

                                //self.SendAnsync({
                                //    linkAnsyn: UtilModuleCommentProduct.linkAjax().linkApiAsync,
                                //    contenComment: commentKeyup,
                                //    ID: data.ID,
                                //    title: ($("head title")[0]).text,
                                //    modulId: self.option.modulId
                                //});
                                self.toastNts.show(UtilModuleCommentProduct.configConstant().messageSuccess);
                            }
                            UtilModuleCommentProduct.resetInput(['.comment-box textarea', '.fcm-login-txt']);
                        });
                        return false;
                    }
                });
            });
        }
    });

};

CommentProduct.prototype.SendAnsync = function (option) {
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
 * @function
 * @description The function used for sort comment
 */
CommentProduct.prototype.sortComment = function () {
    var self = this;

    $('.trg-cm-hsort span').on('click', function () {
        var $self = $(this);

        $self.closest('.trg-cm-hsort').find('.active').removeClass('active');

        $self.addClass('active');

        var valueFilter = self.getValueFilter();

        self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, false);

        $('#list-comment').attr('data-page', 2);
    });
};

/**
 * @author Nghiatc2.
 * @function.
 * @description The function used for filter comment.
 */
CommentProduct.prototype.filterComment = function () {
    var self = this;

    $('.txt-search-comment').on('keyup', function (e) {
        var valueFilter = self.getValueFilter();

        if (e.keyCode == 13) {

            if ($.trim(valueFilter.keyword) === '') {
                jfpts.utility.notifyWarning("Bạn chưa nhập thông tin tìm kiếm");
                return;
            }
            self.loadComment(valueFilter.keyword, valueFilter.searchin, valueFilter.sort, false);

            $('#list-comment').attr('data-page', 2);
        }
    });
};

/**
 * @author Nghiatc2.
 * @function
 * @description The function used for like or unlike comment.
 */
CommentProduct.prototype.likeComment = function () {
    var self = this;

    $(document).on('click', '.like-comment', function () {
        var $self = $(this),
            idComment = $self.attr('data-id'),
            $elementNumberLike = $self.closest('.trg-botcmm').find('.number-like');

        /**
         * unkile
         * Nếu khi bấm nút mà có class liked
         * thì xóa class liked,chuyển text từ bỏ thích sang thích.
         * giảm số like đi 1.
        */
        if ($self.hasClass('liked')) {
            $self.removeClass('liked');

            // decrease like 
            $elementNumberLike.text(Number($elementNumberLike.text()) - 1);

            $self.text('Thích');

            $.post(UtilModuleCommentProduct.linkAjax().linkApiUnLike, { CommentID: idComment }).done(function () {
                self.saveLikeCommentToCookie(idComment, false);
            });
        } else {
            /**
            * like
            * Khi bấm nút mà chưa có class liked
            * thêm class liked,chuyển text từ thích sang bỏ thích,
            * tăng thích lên 1
            */
            $self.addClass('liked');

            // increase like up 1.
            $elementNumberLike.text(Number($elementNumberLike.text()) + 1);

            $self.text("Bỏ thích");

            $.post(UtilModuleCommentProduct.linkAjax().linkApiLike, { CommentID: idComment });

            self.saveLikeCommentToCookie(idComment, true);
        }
    });
};

CommentProduct.prototype.buildImmediateComment = function (isParent, option) {
    var htmlComment = '';

    if (isParent) {
        htmlComment = $([
            "<div class='media clearfix'>",
                "<div class='media-left'>",
                    "<a href='javascript:void(0);'>",
                        "<img src='../Content/assest/images/no-avatare0cb.png?v=9999'/>",
                    "</a>",
                "</div>",
                "<div class='media-body'>",
                    "<h4 class='media-heading'>" + option.username + "</h4>",
                    "" + option.comment,
                    "<div class='trg-botcmm clearfix'>",
                        "<div class='left'>",
                            "<span class='comment-date'>",
                                "" + UtilModuleCommentProduct.getBackDate(new Date()),
                            "</span>",
                            "<span class='comment-like'><i class='icons like-icon'></i> <label class='number-like'>0</label></span>",
                        "</div>",
                        "<div class='right'>",
                            "<a data-id='" + option.id + "' class='like-comment' href='javascript:void(0);'>Thích</a>",
                            "<a class='answer-comment' href='javascript:void(0);'>Trả lời</a>",
                        "</div>",
                    "</div>",
                    "<div class='media clearfix trg-cm-post trg-cm-post-sub'>",
                        "<div class='media-left'>",
                            "<a href='javascript:javascript:void(0);' title=''><img src='../Content/assest/images/no-avatare0cb.png?v=9999'/></a>",
                        "</div>",
                        "<div class='media-body comment-box'>",
                            "<textarea class='form-control' rows='2' placeholder='Viết bình luận của bạn...'></textarea>",
                            "<div class='form-inline'>",
                                "<div class='form-group'>",
                                    "<input type='button' class='trg-bnt-post form-control' value='Bình luận' data-id='" + option.id + "'>",
                                "<div>",
                            "</div>",
                        "</div>",
                    "</div>",
                "</div>",
            "</div>"
        ].join("\n"));
    } else {
        htmlComment = $([
            "<div class='media clearfix'>",
                "<div class='media-left'>",
                    "<a href='javascript:void(0);'>",
                        "<img src='../Content/assest/images/no-avatare0cb.png?v=9999'/>",
                    "</a>",
                "</div>",
                "<div class='media-body'>",
                    "<h4 class='media-heading'>" + option.username + "</h4>",
                    "" + option.comment,
                    "<div class='trg-botcmm clearfix'>",
                        "<div class='left'>",
                            "<span class='comment-date'>",
                                "" + UtilModuleCommentProduct.getBackDate(new Date()),
                            "</span>",
                            "<span class='comment-like'><i class='icons like-icon'></i> <label class='number-like'>0</label></span>",
                        "</div>",
                        "<div class='right'>",
                            "<a data-id='" + option.id + "' class='like-comment' href='javascript:void(0);'>Thích</a>",
                        "</div>",
                    "</div>",
                "</div>",
            "</div>"
        ].join("\n"));
    }
    return htmlComment;
};

/**
 * @author Nghiatc2.
 * @function
 * @description Display button send comment when focus textarea.
 */
CommentProduct.prototype.focusInputComment = function () {
    $(document).on('focus', '.comment-box textarea', function () {
        var $self = $(this);

        $(this).closest('.comment-box').find('.form-inline').show();
    });
};

/**
 * @author Nghiatc2.
 * @function.
 */
CommentProduct.prototype.setLikeCommentInit = function () {
    var cookieLikeObject = UtilModuleCommentProduct.getCookie(UtilModuleCommentProduct.configConstant().nameLikeCookie),
        cookieLike;

    if ($.trim(cookieLikeObject) !== '') {
        cookieLike = JSON.parse(cookieLikeObject);

        $(document).find('.like-comment').each(function () {
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

CommentProduct.prototype.saveLikeCommentToCookie = function (idComment, isLike) {
    var cookieLikeObject = UtilModuleCommentProduct.getCookie(UtilModuleCommentProduct.configConstant().nameLikeCookie),
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

    UtilModuleCommentProduct.setCookie(UtilModuleCommentProduct.configConstant().nameLikeCookie, JSON.stringify(cookieLike), 365);
};

/**
 * Object Toast Success
 */
var ToastSuccess = function () {
    this.closeToast();
};

ToastSuccess.prototype.buildHtmlToast = function (textMessage) {
    var html = $([
        "<div class='nts-toast' style='width:290px;z-index:9999;margin: 0 auto;position: fixed;top: 50%;left: 50%;margin-left: -145px;margin-top: -26px;'>",
            "<div class='nts-wrapper' style='border:1px #71b371 solid;background: #71b371;color: #fff;height: auto;border-radius: 3px;-moz-border-radius: 3px;-webkit-border-radius: 3px;padding:12px 12px 10px 1px;;font-size:12px;line-height: 24px;position: relative;'>",
                "<div class='nts-close' style='position: absolute;right: 5px;top: 0;cursor: pointer'>x</div>",
                "<div class='nts-icon-success' style='position: absolute;background: url(http://fptshop.com.vn/Content/v3/images/icon_success.png);width: 32px;height : 32px;'>",
                "</div>",
                "<div class='nts-content' style='padding-left: 40px;text-align: center;'>" + textMessage + "</div>",
            "</div>",
        "</div>"
    ].join('\n'));
    return html;
};

ToastSuccess.prototype.closeToast = function () {
    $(document).on('click', '.nts-close', function () {
        $('body').find('.nts-toast').fadeOut('slow', function () {
            setTimeout(function () {
                this.remove();
            }.bind($(this)), 1000);
        });
    });
};

ToastSuccess.prototype.show = function (message) {
    $('body').append(this.buildHtmlToast(message));

    setTimeout(function () {
        $('body').find('.nts-toast').fadeOut('slow', function () {
            setTimeout(function () {
                this.remove();
            }.bind($(this)), 1000);
        });
    }, 3000);
};

var UtilModuleCommentProduct = (function () {
    var linkAjax,
        modulId,
        standardizedString,
        getCookie,
        setCookie,
        configConstant,
        getBackDate,
        resetInput,
        showSuccessToast;

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

    modulId = function () {
        return {
            productPage: 1,
            news: 2,
            landing: 3,
            oldProduct: 4
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

        if (stringTemp !== '') {

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
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
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

    showSuccessToast = function () {
        $().toastmessage('showToast', {
            text: this.configConstant().messageSuccess,
            sticky: true,
            position: 'top-center',
            type: 'success'
        });
    };

    configConstant = function () {
        return {
            nameEmailCookie: "ftscustomerEmail",
            nameCustomerCookie: "ftscustomerName",
            namePhoneCookie: 'ftscustomerPhone',
            messageSuccess: "<span>Bình luận của bạn đã được ghi nhận</span><br/><span>Chúng tôi sẽ phản hồi bạn sau ít phút nhé!</span>",
            nameLikeCookie: 'ftsCokkieLL',
            imgLoading: "<img src='http://fptshop.com.vn/Content/images/ajax_loader_small.gif'>",
            imgBigLoading: "<img style='margin:0 auto;' src='http://fptshop.com.vn/Content/images/ajax_loader_big.gif'>",
            timerGetNewComment: 120000
        };
    };

    resetInput = function (arrayName) {
        if (arrayName) {
            $.each(arrayName, function (i, v) {
                $(document).find(v).val('');
            });
        }
    };


    return {
        linkAjax: linkAjax,
        modulId: modulId,
        standardizedString: standardizedString,
        getCookie: getCookie,
        setCookie: setCookie,
        getBackDate: getBackDate,
        configConstant: configConstant,
        resetInput: resetInput,
        showSuccessToast: showSuccessToast
    };
})();

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
    js.src = "../../connect.facebook.net/en_US/all.js";
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
            UtilModuleCommentProduct.setCookie(UtilModuleCommentProduct.configConstant().nameCustomerCookie, userName, 1);
            UtilModuleCommentProduct.setCookie(UtilModuleCommentProduct.configConstant().nameEmailCookie, email, 1);

            //$('.fcm-login').hide('slow');

            jqueyObject.closest('.comment-box').find('textarea').focus();
            jqueyObject.closest('.comment-box').find('.trg-bnt-post').show();
        }
    });
}
/*End process login facebook*/

//*add by phenv2 buid paging*//
CommentProduct.prototype.buidPaging = function (step, currentPage, pageSize, total) {
    var strPageHTML = "<ul class='tesst'>";

    var totalPage = total / pageSize;
    if (total % pageSize > 0) {
        totalPage = totalPage + 1;
    }

    if (currentPage > step + 1) {
        strPageHTML += "<li><a  class='pageNumber' data-page='1' href='javascript:;'>««</a></li>";
        strPageHTML += "<li><a class='pageNumber' data-page='" + (currentPage - 1) + "' href='javascript:;'>«</a></li>";
        strPageHTML += "<li>...</li>";

    }

    var BeginFor = ((currentPage - step) > 1) ? (currentPage - step) : 1;
    var EndFor = ((currentPage + step) > totalPage) ? totalPage : (currentPage + step);

    for (var pNumber = BeginFor; pNumber <= EndFor; pNumber++) {
        if (pNumber == currentPage)
            strPageHTML += "<li class=\"active\"><a class='pageNumber' data-page='" + pNumber + "' href='javascript:;'>" + pNumber + "</a></li>";
        else
            strPageHTML += "<li><a class='pageNumber' data-page='" + pNumber + "' href='javascript:;'>" + pNumber +
                           "</a></li>";
    }

    if (currentPage < (totalPage - step)) {
        strPageHTML += "<li>...</li>";
        strPageHTML += "<li><a class='pageNumber' data-page='" + (currentPage + 1) + "' href='javascript:;'>»</a></li>";
        strPageHTML += "<li><a class='pageNumber' data-page='" + totalPage + "' href='javascript:;'>»»</a></li>";
    }
    strPageHTML += "</ul>";
    if (totalPage > 1)
        return strPageHTML;
    return string.Empty;
};