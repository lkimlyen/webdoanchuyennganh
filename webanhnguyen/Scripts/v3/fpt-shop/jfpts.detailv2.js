jfpts.main.callConsult = function () {
    $('.modal-get-phone').modal('show');
};

jfpts.productdetail = (function () {

    var directionsDisplay;
    var map;
    var markers = [];
    var directionsService;

    function activeSlide() { 
        $('.box-media').removeClass('active-media');
        $('.detail-image-box').addClass('active-media');
    }

    function activeGallery() {
        $('.box-media').removeClass('active-media');
        $('.detail-gallery-box').addClass('active-media');

        var swiperGallery = new Swiper('.detail-gallery-box .swiper-container', {
            grabCursor: true,
            nextButton: '.media-gallery-next',
            prevButton: '.media-gallery-prev',
            loop: true
        });

    }

    function activeVideo() {
        $('.box-media').removeClass('active-media');
        $('.detail-video-box').addClass('active-media');

        $('.detail-video').html('<iframe class="embed-responsive-item" src="' + $('.detail-video').attr('data-src') + '"></iframe>');
    }

    function active360() {
        $('.box-media').removeClass('active-media');
        $('.detail-360-box').addClass('active-media');

        var listImg360 = $('.detail-360').attr('data-img').split(',');

        $('.img360').ThreeSixty({
            totalFrames: listImg360.length, // Total no. of image you have for 360 slider
            endFrame: listImg360.length, // end frame for the auto spin animation
            currentFrame: 1, // This the start frame for auto spin
            imgList: '.threesixty_images', // selector for image list
            progress: '.spinner', // selector to show the loading progress
            imgArray: listImg360.reverse(),
            height: 415,
            width: 792,
            navigation: false
        });
    }

    function initMedia() {

        if ($('.fshop-lpslnews-swiper').length > 0) {
            var lpslnews = new Swiper('.fshop-lpslnews-swiper', {
                spaceBetween: 30,
                slidesPerView: 1,
                centeredSlides: true,
                autoplay: 4000,
                autoplayDisableOnInteraction: false,
                direction: 'vertical',
                loop: true
            });
        }

        if ($('.detail-image-box').length > 0) {
            var imageSlide = new Swiper('.detail-image-box .swiper-container', {
                grabCursor: true,
                nextButton: '.media-slide-next',
                prevButton: '.media-slide-prev',
                loop: true,
                onInit: function (swiper) {
                    common.swiperControl(swiper);
                }
            });
        }

        if ($('.detail-image-box').length == 0 && $('.detail-gallery-box').length > 0) {
            var swiperGallery = new Swiper('.detail-gallery-box .swiper-container', {
                grabCursor: true,
                nextButton: '.media-gallery-next',
                prevButton: '.media-gallery-prev',
                loop: true,
                onInit: function (swiper) {
                    common.swiperControl(swiper);
                }
            });
        }
    }

    function initMap() {

        directionsService = new google.maps.DirectionsService();
        directionsDisplay = new google.maps.DirectionsRenderer();
        var positonCenter = new google.maps.LatLng(21.031795, 105.851356);
        var optionsMap = {
            zoom: 15,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            center: positonCenter,
            maxZoom: 18,
            minZoom: 10
        };

        map = new google.maps.Map(document.getElementById("map-canvas"), optionsMap);

        // bounds of the desired area
        var allowedBounds = new google.maps.LatLngBounds(
          new google.maps.LatLng(8.407168, 102.957001),
          new google.maps.LatLng(23.402765, 109.329071)
        );
        var boundLimits = {
            maxLat: allowedBounds.getNorthEast().lat(),
            maxLng: allowedBounds.getNorthEast().lng(),
            minLat: allowedBounds.getSouthWest().lat(),
            minLng: allowedBounds.getSouthWest().lng()
        };

        var lastValidCenter = map.getCenter();

        var newLat, newLng;

        google.maps.event.addListener(map, 'center_changed', function () {
            center = map.getCenter();
            if (allowedBounds.contains(center)) {
                // still within valid bounds, so save the last valid position
                lastValidCenter = map.getCenter();
                return;
            }

            newLat = lastValidCenter.lat();

            newLng = lastValidCenter.lng();

            if (center.lng() > boundLimits.minLng && center.lng() < boundLimits.maxLng) {
                newLng = center.lng();
            }

            if (center.lat() > boundLimits.minLat && center.lat() < boundLimits.maxLat) {
                newLat = center.lat();
            }

            map.panTo(new google.maps.LatLng(newLat, newLng));

        });

        directionsDisplay.setMap(map);

        $.get("/Ajax/Shop/GetAllShop", {}, function (data) {

            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }

            markers = [];

            var infowindow = new google.maps.InfoWindow();

            $('.searchresult span').text(data.list.length);

            $('.list-shop').html("");
            $.each(data.list, function (i, val) {

                $('.list-shop').append('<li class="item-shop" data-x="' + val.Xvalue + '" data-y="' + val.Yvalue + '"><h3><strong>' + val.Name + '</strong></h3><p>Địa chỉ: ' + val.Address + '<br />Số ĐT:' + val.Phone + '</p><p>Giờ hoạt động: ' + val.ActiveTime + '</p></li>');

                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(val.Xvalue, val.Yvalue),
                    map: map,
                    title: val.Name
                });

                var content = "<b>" + val.Name + "</b>" + "<br />Địa chỉ: " + val.Address + "<br />Số  ĐT: " + val.Phone;

                markers.push(marker);

                google.maps.event.addListener(marker, 'click', (function (marker, content) {
                    return function () {
                        map.setZoom(18);
                        map.setCenter(marker.getPosition());
                        infowindow.setContent(content);
                        infowindow.open(map, marker);
                    };
                })(marker, content));

                infowindow.open(map, marker);
            });

        }).complete(function (e) {
            var scrollShop = new IScroll('.scroll-shop');
        });
    }

    function findShop(type, id) {
        var url = "/Ajax/Shop/GetStoreByDistrictId";
        if (type == "cityId") {
            url = "/Ajax/Shop/GetStoreByCityId";
        }
        if (id == 0) {
            url = "/Ajax/Shop/GetStoreByCityId";
            id = $('.list-city-findshop').val();
        }
        $.get(url, { id: id }, function (data) {

            for (var i = 0; i < markers.length; i++) {
                markers[i].setMap(null);
            }
            markers = [];

            var infowindow = new google.maps.InfoWindow();

            $('.list-shop').html("");

            $.each(data.list, function (i, val) {

                $('.list-shop').append('<li class="item-shop" data-x="' + val.Xvalue + '" data-y="' + val.Yvalue + '"><p><strong>' + val.Name + '</strong></p><p>Địa chỉ: ' + val.Address + '</p><p>Số ĐT:' + val.Phone + '</p><p>Giờ hoạt động: ' + val.ActiveTime + '</p></li>');

                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(val.Xvalue, val.Yvalue),
                    map: map,
                    title: val.Name
                });

                var content = val.Name + "<br />Địa chỉ: " + val.Address + "<br />Số  ĐT: " + val.Phone;
                markers.push(marker);
                google.maps.event.addListener(marker, 'click', (function (marker, content) {
                    return function () {
                        map.setZoom(18);
                        map.setCenter(marker.getPosition());
                        infowindow.setContent(content);
                        infowindow.open(map, marker);
                    };
                })(marker, content));

                infowindow.open(map, marker);

                if (i == 0) {
                    var positonCenter = new google.maps.LatLng(val.Xvalue, val.Yvalue);
                    map.setCenter(positonCenter);
                    map.setZoom(12);
                }
            });

            var scrollShop = new IScroll('.scroll-shop');

            $('.searchresult span').text(data.list.length);

        });
    }

    function initTabWaCe() {

        $.get("/Ajax/Product/FindShop", { brandAscii: $('.warranty-center').attr('data-brand'), productType: $('.warranty-center').attr('data-type') }, function (data) {

            $('.warranty-center').html(data);

            $('.list-city-wace').change(function () {

                $('.list-detail-wace').html('<p class="msg-not-find"><img src="../Content/Publishing/css/images/loaderA64.gif" /></p>');

                $.get("/Ajax/Product/GetWarrantyCenter", { brandCode: $('.list-detail-wace').attr('data-bcode'), cityCode: $('.list-city-wace').val(), productType: $('#productdetailpage').attr('data-type') }, function (res) {

                    if (res.error == false) {

                        $('.list-detail-wace').html('');

                        $.each(res.list, function (i, v) {

                            $('.list-detail-wace').append('<div class="item-detail-wace">' +
                                                        '<label class="city-detail-wace">' +
                                                            v.RegionHierachyName +
                                                        '</label>' +
                                                        '<p class="address-detail-wace">' +
                                                            v.Address +
                                                            '<br />' +
                                                            '<span class="phone-detail-wace">ĐT: ' + v.PhoneNumber + '</span>' +
                                                        '</p>' +
                                                    '</div>');

                        });

                        if (res.list.length == 0) {
                            $('.list-detail-wace').html('<p class="msg-not-find">Chưa có TTBH tại nơi bạn muốn tìm.</p>');
                        }
                    }

                    if (res.error) {
                        $('.list-detail-wace').html('<p class="msg-not-find">Có lỗi xảy ra bạn hãy thử lại.</p>');
                    }

                });

            });

        }).complete(function () {

            $.getScript("https://maps.googleapis.com/maps/api/js?sensor=false&amp;async=2&amp;callback=jfpts.productdetail.initMap", function (data, textStatus, jqxhr) {

                $(".list-city-findshop").change(function () {
                    var cityId = $(this).val();
                    $.get("/Ajax/Shop/getDistrictByCity", { "cityId": cityId }, function (data) {
                        $(".list-district-findshop").html("");
                        $(".list-district-findshop").append("<option value='0'>Tất cả</option>");
                        $.each(data.list, function (i, val) {
                            $(".list-district-findshop").append("<option value='" + val.ID + "'>" + val.Name + "</option>");
                        });
                    }).complete(function (e) {
                        jfpts.productdetail.findShop("cityId", cityId);
                    });
                });

                $(".list-district-findshop").change(function () {
                    var districtId = $(this).val();
                    jfpts.productdetail.findShop("districtId", districtId);
                });

                $(document).on('click', '.item-shop', function (e) {
                    if ($(this).hasClass('active') == false) {
                        $(this).parent().find('.active').removeClass('active');
                        $(this).addClass('active');
                        var x = $(this).data('x');
                        var y = $(this).data('y');

                        map.setCenter(new google.maps.LatLng(x, y));
                        map.setZoom(15);
                    }
                });
            });

        });
    }

    function addOrder(_this) {

        if ($(_this).hasClass('not-orderdt') == false) {

            $(_this).addClass('not-orderdt');

            var productId = $('#productId').val();
            var productvariantID = $('.chosen-color:first').attr('data-id');
            var talesSales = null;
            var campaignId = 0;
            var delivery = 1;
            var money = $('.detail-current-price').attr('data-price');
            if ($(_this).hasClass('detail-order-bulk')) {
                jfpts.data.addOrderBulk(productId, productvariantID, talesSales, campaignId, delivery, money);
            }
            else if ($(_this).hasClass('detail-btntragop')) {

                jfpts.data.addOrderRecuring(productId, productvariantID, talesSales, campaignId, delivery, money);
            }
            else {
                jfpts.data.addOrder(productId, productvariantID, talesSales, campaignId, delivery, money);
            }

        }

    }

    function buildPrice(price, pricemarket, sku) {

        var priceText = '';

        if (price > 0) {

            priceText += '<span>Giá sản phẩm: </span><strong class="detail-current-price" data-price="' + price + '">' + jfpts.utility.formatPrice(price) + 'đ</strong>'

        }

        if (price > 0 && price < pricemarket) {

            priceText += ' <span class="fshop-dtv2-priceshop">' + jfpts.utility.formatPrice(pricemarket) + 'đ</span>';

        }

        //if ($('.detail-listkm').length > 0) {
        //    priceText += '<div class="detail-listkm">' + $('.detail-listkm').html() + '</div>';
        //}

        $('.fshop-dtv2-price').html(priceText);

        $('.fshop-dprodsku').text('(No.' + sku + ')');

    }

    function buildButton(showbutton, price, pricemarket, callPrice, isrecurring, isLanding, isSeller, seller, support, bestpricecampaign, pricerecurring, ispaymentonline, isnotbusiness) {

        var button = '';

        var productId = $('#productId').val();

        if (!showbutton) {

            button += '<li>'
                        + '<a class="detail-order-out">'
                            + '<label>Tạm hết hàng</label>'
                        + '</a>'
                    + '</li>';

        }

        if (showbutton && !isnotbusiness) {

            button += '<li>'
                        + '<a href="javascrpit:;" onclick="jfpts.productdetail.addOrder(this)" class="detail-order-now">'
                            + '<label>Đặt trước Online<span>(Giữ hàng tại shop, không mua không sao)</span></label>'
                        + '</a>'
                    + '</li>'
                    + '<li>'
                        + '<a href="javascrpit:;" onclick="jfpts.productdetail.addOrder(this)" class="detail-ordermores detail-order-bulk">'
                            + '<label>Đặt số lượng lớn<span>(Giá ưu đãi hấp dẫn)</span></label>'
                        + '</a>'
                    + '</li>';

        }

        if (showbutton && !isnotbusiness && isSeller) {

            button += '<li>'
                        + '<a href="javascrpit:;" onclick="jfpts.productdetail.addOrder(this)" class="detail-order-now" data-id="' + productId + '" data-tales="' + seller + '">'
                            + '<label>Đặt qua tổng đài</label>'
                        + '</a>'
                    + '</li>'
                    + '<li>'
                        + '<a href="javascrpit:;" onclick="jfpts.productdetail.addOrder(this)" class="detail-order-now" data-id="' + productId + '" data-tales="' + support + '">'
                            + '<label>Đặt qua chat</label>'
                        + '</a>'
                    + '</li>';
        }

        if (showbutton && !isnotbusiness && ispaymentonline) {
            button += '<li>'
                         + '<a href="javascript:;" id="btnOrderPaymentOnline" data-id="' + productId + '" class="detail-order-instalments">'
                            + '<label>Thanh toán online<span>(Visa, Master)</span></label>'
                        + '</a>' +
                     '</li>';
        }

        if (showbutton && !isnotbusiness && isrecurring) {

            button += '<li>'
                        + '<a href="' + document.location.pathname + '/tra-gop" class="detail-btntragop">'
                            + '<label>Trả góp<span>(Từ ' + jfpts.utility.formatPrice(pricerecurring) + ' đ/tháng)</span></label>'
                        + '</a>'
                    + '</li>';

        }

        if (showbutton && isnotbusiness) {

            button += '<li>'
                         + '<a class="detail-order-out">'
                            + '<label>Ngừng kinh doanh</label>'
                         + '</a>'
                     + '</li>';
        }

        $('.fshop-xhdt-listbtn').html(button);

    }

    function getDataFromFTG(isLoad) {

        $.get('/Ajax/Product/GetRecommendProduct', { isExperiment: isLoad, productId: $('#productId').val() }, function (data, status, xhr) {

            if (data.recommend != '' && data.recommend != null) {
                $('.rcmcyl').html(data.recommend);
            }

            //if (data.purchased != '' && data.purchased != null) {
            //    $('.rcmcyl').html(data.purchased);
            //}

            //if (data.viewed != '' && data.viewed != null) {
            //    $('.rcmcyl').html(data.viewed);
            //}

        });

    }

    function PhoneNumberDetect(numberTelephone) {
        var check = false;
        var link = "/ajax/TOPUP/ValidatePhoneNumber";

        var lenght = numberTelephone.length;
        var header = "";
        if (lenght == 10) {
            header = numberTelephone.substr(0, 3);
        }
        else {
            header = numberTelephone.substr(0, 4);
        }
        var paymentObject = {
            phone: header,
            len: lenght
        };
        if (typeof this.xhr !== 'undefined')
            this.xhr.abort();
        this.xhr = $.ajax({
            type: 'POST',
            url: link,
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            cache: false,
            data: JSON.stringify(paymentObject),

            error: function () {
                alert("Đã có lỗi xảy ra. Vui lòng thử lại");
                check = false;
            },
            success: function (returnData) {
                var receiveData = returnData["Data"];
                if (receiveData["error"] == true) {
                    alert("Số điện thoại không đúng.Vui lòng thử lại");
                    check = false;
                }
                else {
                    check = true;
                }
            }
        });

        return check;
    }

    function addProductCompare(id) {

        if ($('.fshop-dtv2-pvulbox > li[data-id="' + id + '"]').length > 0) {
            jfpts.utility.notifyWarning('Sản phẩm đã có trong danh sách so sánh !');
            return;
        }

        $.get("/Ajax/Product/GetCompareProduct", { "id": id }, function (data) {

            if (!data.error) {

                var item = data.data;

                var str = '<li class="fshop-dtv2-pvli" data-id="' + item.ID + '" data-ascii="' + item.NameAscii + '">'
                            + '<div class="p-item">'
                                + '<span class="fshop-dtv2-remove"><i class="glyphicon glyphicon-remove"></i></span>'
                                + '<div class="p-badge"><img src="' + jfpts.utility.getUrlPicture(item.UrlLabelPicture) + '" alt="' + item.Name + '" /></div>'
                                + '<div class="p-item-bound">'
                                    + '<a href="/' + item.ProductType.NameAscii + "/" + item.NameAscii + '" class="p-link-prod"></a>'
                                    + '<figure class="p-image">'
                                        + '<span>'
                                            + '<a href="/' + item.ProductType.NameAscii + "/" + item.NameAscii + '" title="' + item.Name + '">'
                                                + '<img src="' + jfpts.utility.getUrlPicture(item.UrlPicture) + '" alt="' + item.Name + '" />'
                                            + '</a>'
                                        + '</span>'
                                    + '</figure>'
                                    + '<div class="p-info">'
                                        + '<div class="p-top-info">'
                                            + '<div class="p-info-show">'
                                                + '<div class="p-name">'
                                                    + '<h3><a href="/' + item.ProductType.NameAscii + "/" + item.NameAscii + '" title="' + item.Name + '">' + item.Name + '</a> </h3>'
                                                + '</div>'
                                                + '<div class="p-price">';

                if (item.ProductVariant.PriceMarket > 0 && item.ProductVariant.PriceMarket > item.ProductVariant.Price) {
                    str += '<span class="p-old-price">' + jfpts.utility.formatPrice(item.ProductVariant.PriceMarket) + '<span>đ</span></span>'
                }

                if (item.ProductVariant.Price > 0) {
                    str += '<span class="p-current-price">' + jfpts.utility.formatPrice(item.ProductVariant.Price) + '<span>đ</span></span>'
                }

                str += '</div>'
                                    + '</div>'
                                + '</div>'
                                + '<div class="p-hide-info">'
                                    + '<div class="best-seller-order">' + item.PromotionInfo + '</div>'
                                    + '<div class="p-promotion">' + item.HightlightsDes + '</div>'
                                + '</div>'
                            + '</div>'
                        + '</div>'
                    + '</div>'
                + '</li>';

                $('.fshop-dtv2-pvulbox li:first').after(str);

                $('.compare-more').attr('href', $('.compare-more').attr('href') + '-vs-' + item.NameAscii);

            }

        });

    }

    function changeColor(_this) {

        $('.pd-box-color.choosen').removeClass('choosen');

        $(_this).parent().addClass('choosen');

        var showbutton = $(_this).attr('data-button').toLowerCase() == 'true';
        var price = parseFloat($(_this).attr('data-price'));
        var pricemarket = parseFloat($(_this).attr('data-pricemarket'));
        var callPrice = $(_this).attr('data-callprice').toLowerCase() == 'true';
        var isrecurring = $(_this).attr('data-isrecurring').toLowerCase() == 'true';
        var isLanding = $(_this).attr('data-islanding').toLowerCase() == 'true';
        var isSeller = $(_this).attr('data-isseller').toLowerCase() == 'true';
        var seller = $(_this).attr('data-seller');
        var support = $(_this).attr('data-support');
        var bestpricecampaign = $(_this).attr('data-bestpricecampaign');
        var pricerecurring = parseFloat($(_this).attr('data-pricerecurring'));
        var sku = $(_this).attr('data-sku');
        var ispaymentonline = $(this).attr('data-ispaymentonline').toLowerCase() == 'true';
        var isnotbusiness = $(this).attr('data-isnotbusiness').toLowerCase() == 'true';
        buildPrice(price, pricemarket, sku);
        buildButton(showbutton, price, pricemarket, callPrice, isrecurring, isLanding, isSeller, seller, support, bestpricecampaign, pricerecurring, ispaymentonline, isnotbusiness);

    }

    function reportPrice() {

        if ($('.show-report-price').hasClass('lfrp')) {
            return;
        }

        $('.show-report-price').addClass('lfrp');

        var id = $('#productId').val();

        $.get("/Ajax/Product/ReportHighPrice", { productId: id }, function (data) {

            var strModal = '<div class="modal fade modal-report-price" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">'
                              + '<div class="modal-dialog"><form id="form-report-price">'
                                + '<div class="modal-content">'
                                    + '<div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button><h4 class="modal-title">Báo giá cao</h4></div>'
                                    + '<div class="modal-body">'
                                        + data
                                    + '</div>'
                                    + '<div class="modal-footer"><button type="submit" class="btn btn-danger">Gửi thông tin</button></div>'
                                + '</div>'
                              + '</form></div>'
                            + '</div>';

            $('body').append(strModal);

            $('.modal-report-price').modal('show');

            $('.modal-report-price').on('hidden.bs.modal', function (e) {
                $('.show-report-price').removeClass('lfrp');
                $('.modal-report-price').remove();
            });

        }).complete(function () {

            $('#form-report-price').validate({
                rules: {
                    price: {
                        required: true,
                        number: true
                    },
                    note: {
                        required: true
                    },
                    name: {
                        required: true
                    },
                    phone: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                    price: 'Bạn vui lòng nhập giá bạn muốn mua sản phẩm.',
                    note: 'Bạn vui lòng nhập lý do.',
                    name: 'Bạn vui lòng nhập tên.',
                    phone: 'Bạn vui lòng nhập số điện thoại.'
                },
                submitHandler: function (form) {
                    //form.preventDefault();

                    $.post("/Ajax/Product/AddReportHighPrice", $('#form-report-price').serialize(), function (data) {
                        if (data.Error == true) {
                            $('.modal-report-price').modal('hide');
                            jfpts.utility.notifySuccess('Cảm ơn bạn đã quan tâm đến sản phẩm tại FPTShop.');
                        } else {
                            jfpts.utility.notifyWarning('Xin lỗi, có lỗi xảy ra bạn hãy thao tác lại.');
                        }
                    }).complete(function () {
                    });

                }
            });

        });

    }

    function initValidateForms() {

        if ($('.ppo_best_form').length > 0) {

            //get phone
            $('.ppo_best_form').validate({
                rules: {
                    phone: {
                        required: true,
                        minlength: 9,
                        number: true
                    }
                },
                messages: {
                    phone: 'Bạn vui lòng nhập số điện thoại.'
                },
                submitHandler: function (form) {
                    //form.preventDefault();

                    var phone = $('.ppo_best_form input[name="phone"]').val();
                    var productvariantid = $(".detail-color .chosen-color:first").attr("data-id");;
                    var name = 'BestSeller';

                    $.post("/Ajax/Order/AddOrder", {
                        'sourceName': 'Đặt từ SĐT đăng ký', 'CampaignID': 0, 'TotalPriceCampaignOrder': '', 'productVariantId': productvariantid,
                        'gender': 1, 'name': name, 'email': '', 'phone': phone, 'address': '',
                        'city': 0, 'district': 0, 'couponCode': '', 'accessories': '', 'talesSales': 1,
                        'ArrPromotioID': '', 'typePayment': 'boxselectShop', 'refered': 'jfpts.com.vn', 'shopname': '', 'storeid': 0, 'sendoid': '', 'codeEmployee': ''
                    }, function (data) {

                        if (data.Error.toString() == "false") {
                            $('.ppo_best_form input[name="phone"]').val('');

                            //$('.pbsell_product').hide();
                            //$('.ppo_thank_main').show();

                            $('.modal-get-phone').modal('hide');

                            $('body').append(data.Messenger);

                            $('.modal-order').modal('show');

                            $('.modal-order').on('hidden.bs.modal', function (e) {
                                $('.not-orderdt').removeClass('not-orderdt');
                                $('.modal-order').remove();
                            });

                        } else {
                            jfpts.utility.notifyWarning('Xin lỗi ! gửi thông tin không thành công. Bạn vui lòng thử lại');
                        }

                    });

                    return false;

                }
            });

        }

        if ($(".box-get-info form").length > 0) {
            //box get info get promotion 
            $(".box-get-info form").validate({
                rules: {
                    name: {
                        required: true
                    },
                    phone: {
                        required: true,
                        number: true
                    }
                },
                messages: {
                    name: 'Bạn vui lòng nhập tên.',
                    phone: 'Bạn vui lòng nhập số điện thoại.'
                },
                submitHandler: function (form) {
                    //form.preventDefault();

                    if ($('.detail-order .btn-success').hasClass('updata') == true) {
                        return false;
                    }

                    if ($('.detail-order .btn-success').hasClass('isUpdata') == true) {
                        jfpts.utility.notifyWarning('Xin lỗi ! Bạn đã đăng ký nhận thông tin.');
                        return false;
                    }

                    $('.detail-order .btn-success').addClass('updata');

                    jfpts.utility.showLoading();

                    var productId = $('#productId').val();
                    var name = $('.box-get-info input[name="name"]').val();
                    var phone = $('.box-get-info input[name="phone"]').val();

                    $.post('/Ajax/Product/AddEmailReceivePromotion', { productId: productId, name: name, phone: phone }, function (res) {

                        jfpts.utility.hideLoading();

                        if (res.error) {
                            jfpts.utility.notifyWarning('Xin lỗi ! đăng ký nhận thông tin không thành công. Bạn hãy thử lại');
                        } else {
                            jfpts.utility.notifySuccess('Bạn đã đăng ký nhận thông tin thành công.');
                            $('.detail-order .btn-success').removeClass('updata').addClass('isUpdata');
                        }
                    }).error(function () {
                        jfpts.utility.notifyWarning('Xin lỗi ! có lỗi xảy ra. Bạn hãy thử lại');
                    });

                    return false;

                }
            });
        }

        if ($("#frmRating").length > 0) {
            //rating
            $("#frmRating").validate({
                rules: {
                    txtNoteRating: {
                        required: true
                    },
                    txtNameRating: {
                        required: true
                    },
                    txtEmailRating: {
                        required: true,
                        email: true
                    }
                },
                messages: {
                    txtNoteRating: 'Bạn đánh giá sản phẩm ?',
                    txtNameRating: 'Bạn cần nhập tên',
                    txtEmailRating: 'Bạn cần nhập email'
                },
                submitHandler: function (form) {
                    //form.preventDefault();

                    var valueTxtAre = $('#txtNoteRating').val();
                    var valueName = $('#txtNameRating').val();
                    var valueEmail = $('#txtEmailRating').val();
                    var valueRating = $('.box-star-submit .icons[data-mark="true"]').length;

                    jfpts.utility.showLoading();

                    $.post('/Ajax/Product/AddRattingProduct', { note: valueTxtAre, name: valueName, email: valueEmail, rating: valueRating, idProduct: $('#productId').val() }, function (res) {

                        jfpts.utility.hideLoading();

                        if (res.error) {
                            jfpts.utility.notifyWarning('Có lỗi xảy ra, bạn hãy thử lại !');
                        } else {

                            $('.detail-rating-dropdown').remove();

                            jfpts.utility.notifySuccess('Đánh giá thành công.');

                        }
                    });

                    return false;

                }
            });
        }
    }

    function frmRating() {

        //$('#act-rating').popover({ template: '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title">Đánh giá</h3><div class="popover-content">Form</div></div>' });

    }

    return {
        activeSlide: activeSlide,
        activeGallery: activeGallery,
        activeVideo: activeVideo,
        active360: active360,
        initMedia: initMedia,
        initMap: initMap,
        findShop: findShop,
        initTabWaCe: initTabWaCe,
        addOrder: addOrder,
        changeColor: changeColor,
        getDataFromFTG: getDataFromFTG,
        reportPrice: reportPrice,
        addProductCompare: addProductCompare,
        initValidateForms: initValidateForms,
        frmRating: frmRating
    };

})();

$(document).ready(function () {

    jfpts.productdetail.initValidateForms();

    jfpts.productdetail.initMedia();

    jfpts.productdetail.getDataFromFTG(true);

    //productComment.init();

    if ($("div").hasClass("fshop-dtv2-sales")) {
        $(".fshop-dtv2-sales").find("#f12").replaceWith("<a class='order-product' onclick='jfpts.productdetail.addOrder(this)' title='Đặt online' style='color:red;text-decoration: none;'><strong>Đặt Online</strong></a>");
    }

    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {

        if (e.target.hash == '#diem-bao-hanh') {
            jfpts.productdetail.initTabWaCe();
        }

    });

    $('.detail-nmright-list >li >a').each(function () {
        if (location.search.split('=')[2] == $(this).attr('data-name')) {
            $(this).css('font-weight', 'bold');
        }
    });
    //cowntdown
    if ($("#detail-countdown-clock").length > 0) {
        var sTime = $("#detail-countdown-clock").attr('data-val');
        $('#detail-countdown-clock').countdown(sTime, function (event) {

            $(this).html(event.strftime('%D <i>NGÀY</i> %H:%M:%S'));
        })
        .on('finish.countdown', function () {
            if ($(".detail-countdown").length > 0)
                $(".detail-countdown").remove();
            if ($(".detail-listorder").length > 0)
                $(".detail-listorder").remove();
            if ($(".detail-order-now").length > 0) {
                $(".detail-order-now").html('<label>Đặt ngay<span>(Tư vấn miễn phí, không mua không sao)</span></label>');
            }
        });
    }


    if ($('.fshop-dtv2-adsright').length > 0) {
        $('.fshop-dtv2-adsright').sticky({
            topSpacing: 80,
            bottomSpacing: $('footer').outerHeight(!0) + 30
        });
    }

    if ($('.tooltip-preorder').length > 0) {

        $('.tooltip-preorder').tooltipster({
            offsetY: 2,
            theme: 'tooltipster-shadow'
        });
    }

    if ($('.ppo_best_main').length > 0) {
        setTimeout(function () { $('.modal-get-phone').modal('show'); }, 15000);
    }

    //$('.btn-fodp').click(function (e) {
    //    e.preventDefault();

    //    $('.detail-order .detail-order-now').trigger('click');

    //});

    $('.box-star .icons').hover(function (e) {
        e.preventDefault();

        $(this).attr({
            'class': 'icons yellow-star',
            'data-mark': 'true'
        });

        $(this).nextAll('.icons').removeAttr('class').attr({
            'class': 'icons grey-star',
            'data-mark': 'false'
        });

        $(this).prevAll('.icons').removeAttr('class').attr({
            'class': 'icons yellow-star',
            'data-mark': 'true'
        });

    }, function () {
    });

    $('.box-star').hover(function (e) {
        e.preventDefault();
    }, function () {

        $('.box-star .icons').each(function (i) {

            $(this).removeAttr('data-active');

            $(this).attr('class', $(this).data('old'));

        });

    });

    $('.open-rating').click(function (e) {
        e.preventDefault();

        $('.detail-rating.box-star .icons').each(function (i) {

            $('.box-star-submit .icons:nth(' + i + ')').attr({
                'class': $(this).attr('class'),
                'data-mark': $(this).attr('data-mark')
            });

        });

        $('.detail-rating-dropdown').toggle(100);

    });

    //compare

    $('body').click(function (e) {
        $('.atc-result').html('');
    });

    $(document).on('click', '.fshop-dtv2-remove', function (e) {
        e.preventDefault();

        $(this).closest('li').remove();

        $('.compare-more').attr('href', $('.compare-more').attr('href').replace('-vs-' + $(this).closest('li').attr('data-ascii'), ''));

    });

    $('.compare-search').keyup(function (e) {
        $keyword = $(this).val();
        if (typeof xhrComplete !== 'undefined') {
            xhrComplete.abort();
        }

        xhrComplete = $.get("/Ajax/SearchLucene/AutoComplete", { searchTerm: decodeURI($keyword), searchField: 'NameProduct', searchDefault: '' }, function (data) {
            if (data._searchResults == '') {
                $('.atc-result').html("<ul><li>Không tìm thấy</li></ul>");
            } else {
                $('.atc-result').html("<ul></ul>");
                $.each(data._searchResults, function (i, v) {
                    $('.atc-result ul').append('<li data-id="' + v.ID + '" onclick="jfpts.productdetail.addProductCompare(' + v.ID + ')">' + v.NameProduct + '</li>');
                });
            }
        });

    });

    //duongnt
    $(document).on("click", "#btnOrderPaymentOnline", function (e) {
        e.preventDefault();
        var productId = $(this).data("id");
        var source = getURLParameter('source');        
        ga('send', 'event', 'Order_' + productId, 'ThanhToanOnline_' + productId, 'ThanhToanOnline_' + productId);
        var campaignId = $(this).data("cam");
        var money = $(".lineprice span").attr("data-money");
        if (typeof campaignId === "undefined") campaignId = 0;
        if (typeof source === "null") source = "";
        if (money === "undefined") money = 0;
        if (typeof (key) === "undefined") key = false;

        jfpts.data.addOrderPayment(productId, campaignId, money, source);

    });

});