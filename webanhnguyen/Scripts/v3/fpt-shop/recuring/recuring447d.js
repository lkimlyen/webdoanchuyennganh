(function ($) {
    var slickHome1 = {
        init: function () {
            slickHome1.events();
        },
        events: function () {
            $('#tgLsZero').slick({
                arrows: true,
                dots: false,
                slidesToShow: 3,
                slidesToScroll: 3,
                responsive: [
                    {
                        breakpoint: 992,
                        settings: {
                            slidesToShow: 2,
                            slidesToScroll: 2,
                            autoplay: true,
                            autoplaySpeed: 3000
                        }
                    },
                    {
                        breakpoint: 690,
                        settings: {
                            slidesToShow: 1,
                            slidesToScroll: 1,
                            autoplay: true,
                            autoplaySpeed: 3000
                        }
                    }
                ]
            });
        }
    };
    var slickHome2 = {
        init: function () {
            slickHome2.events();
        },
        events: function () {
            $('#tgKcttr').slick({
                arrows: true,
                dots: false,
                slidesToShow: 3,
                slidesToScroll: 3,
                responsive: [
                    {
                        breakpoint: 992,
                        settings: {
                            slidesToShow: 2,
                            slidesToScroll: 2,
                            autoplay: true,
                            autoplaySpeed: 3000
                        }
                    },
                    {
                        breakpoint: 690,
                        settings: {
                            slidesToShow: 1,
                            slidesToScroll: 1,
                            autoplay: true,
                            autoplaySpeed: 3000
                        }
                    }
                ]
            });
        }
    };

    $(document).ready(function () {
        if ($("#tgLsZero").length > 0) {
            slickHome1.init();
        }
        if ($("#tgKcttr").length > 0) {
            slickHome2.init();
        }

        $('.trg-btnviewpac').click(function () {
            $('.trg-secpack').slideDown();
        });

        $('.trg-lmore').click(function () {
//            $('.trg-plan').toggleClass('active');
              $(this).parent().parent().parent().toggleClass('active');
        });

        function autoTab(current, next) {
            if (current.getAttribute && current.value.length == current.getAttribute("maxlength"))
                next.focus();
        }
        $(".numeric").keypress(function (e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });


    });
})(window.jQuery);

jQuery(document).ready(function ($) {

    jfpts_recuring_nc.recuringObj().init();

    $('#tgh-openchtg').click(function () {
        $('.tgp-tbbox').slideUp();
        $('.tgp-packbox').slideDown();
        $('.tgp-ln2').hide();
    });
    $('#tgh-closechtg').click(function () {
        $('.tgp-tbbox').slideDown();
        $('.tgp-packbox').slideUp();
        $('.tgp-ln2').show();
    });

    $('#sl-city').on('change', function () {
        var cityId = $(this).val();
        jfpts_recuring_nc.recuringObj().loadDistrict(cityId);
    });

    $(document).on('click', '.atModal', function () {
        jfpts_recuring_nc.recuringObj().showModal($(this));
    });

    $('#view-price-pray').on('click', function () {

        jfpts_recuring_nc.recuringObj().loadRecurringCustomerChoose({
            proid: $('#sl-exhibit').find('option:selected').val(),
            prepay: $('#sl-prepay').find('option:selected').attr('data-val'),
            termID: $('#sl-Amortizations').val()
        });
    });

    $(document).on('click', '.a-close', function () {
        $('#abc').modal('hide');
    });

    $(".numeric").keypress(function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    $('.btn_odn').click(function (e) {
        e.preventDefault();

        var id = $(this).attr('data-id');

        jfpts.data.addOrder(id, undefined, null, 0, null, '20000');

    });

    $('.search-recurring').on('keyup', function () {
        jfpts_recuring_nc.recuringObj().search($(this));
    });
});

var jfpts_recuring_nc = (function () {
    var ajaxUrl = {
        GetListDistrict: '/Ajax/Shop/getDistrictByCity',
        GetListAmortizations: '/Ajax/Installment/GetListAmortizations',
        GetListExhibit: '/Ajax/Installment/GetListExhibit',
        GetListPercentPrePay: '/Ajax/Installment/GetListPercentPrePay',
        GetRecuringCustomerChoose: '/Ajax/Installment/GetRecuringCustomerChoose',
        InsertOrderRecuring: '/Ajax/Installment/InsertOrderRecuring',
        GetListCutomerTypeRecurring: '/Ajax/Installment/GetListCutomerTypeRecurring',
        GetRecurringByVariantId: '/Ajax/Installment/GetRecurringByVariantId',
        GetListRecuringProductBySku: '/Ajax/Installment/GetListRecuringProductBySku',
        SearchLucene: '/Ajax/SearchLucene/AutoCompleteRecuring'
    };

    var util = {
        hideArrayElement: function (arrayElement) {
            if (arrayElement.length > 0) {
                $.each(arrayElement, function (i, v) {
                    $(v).hide();
                });
            }
        },
        showArrayElement: function (arrayElement) {
            if ($.isArray(arrayElement) && arrayElement.length > 0) {
                $.each(arrayElement, function (i, v) {
                    $(v).show();
                });
            }
        },
        isPhone: function (phone) {
            var regex = /^0[0-9]{9,10}$/;
            if (phone.match(regex)) {
                return true;
            } else {
                return false;
            }
        },
        isCmd: function (cmd) {
            var regex = /^[0-9]{9,12}$/;

            if (cmd.match(regex)) {
                return true;
            } else {
                return false;
            }
        },
        isEmail : function(email) {
            var regex = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/igm;

            if (email.match(regex)) {
                return true;
            } else {
                return false;
            }
        },
        isBirth: function (birthday) {
            var regex = /[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}/igm;

            if (birthday.match(regex)) {
                return true;
            } else {
                return false;
            }
        },
        isBirth: function (date, month, year) {
            var newDate = date + "-" + month + "-" + year,
             regex = /[0-9]{1,2}-[0-9]{1,2}-[0-9]{4}/igm,
             mess = {};

            if (!newDate.match(regex)) {
                return {
                    error: false,
                    messages: 'Vui lòng nhập đúng ngày tháng năm sinh.(ngày/tháng/năm)'
                };
            }
            
            if (date < 1 || date > 31) {
                return {
                    error: false,
                    messages: 'Ngày sinh không hợp lệ'
                };
            } else if (month < 1 || month > 12) {
                return {
                    error: false,
                    messages: 'Tháng sinh không hợp lệ'
                };
            } else if ((month == 4 || month == 6 || month == 9 || month == 11) && date == 31) {
                return {
                    error: false,
                    messages: 'Ngày sinh không hợp lệ'
                };
            } else if (month == 2) {
                var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));

                if (date > 29 || (date == 29 && !isleap)) {
                    return {
                        error: false,
                        messages: 'Ngày sinh không hợp lệ'
                    };
                }
            } else if (new Date(year, Number(month) - 1, date) > new Date()) {
                return {
                    error: false,
                    messages: 'Ngày tháng năm sinh không được lớn hơn ngày hiện tại'
                };
            } else if ((Number(new Date().getFullYear()) - Number(year)) < 18) {
                return {
                    error: false,
                    messages: 'Bạn chưa đủ 18 tuổi'
                };
            } else if ((Number(new Date().getFullYear()) - Number(year)) > 100) {
                return {
                    error: false,
                    messages: 'Số tuổi không được quá 100 tuổi'
                };
            }

            return {
                error: true,
                messages: ''
            };
        },
        calculatePricePrepay: function (priceProduct, percentPrice) {
            var price = 0;

            var priceProductTemp = priceProduct.replace(/\./igm, '');

            price = (Number(priceProductTemp) * Number(percentPrice) / 100);

            return price.format(0, 3, '.', '.');
        },
        config: {
            'FE': 1002,
            'ACS': 1,
            'Home': 2,
            'HDS': 1003,
            nameLocalStoreCustomerChoose: "csm_rc_cs",
            Mpost: 'tra-gop-mpos'
        },
        resetInput: function (arrayInput) {
            if ($.isArray(arrayInput) && arrayInput.length > 0) {
                $.each(arrayInput, function (i, v) {
                    $(v).val('');
                });
            }
        },
        resetSelect: function (arraySelecttion) {
            if ($.isArray(arraySelecttion) && arraySelecttion.length > 0) {
                $.each(arraySelecttion, function (i, v) {
                    $(v).find('option[value="0"]').prop('selected', true)
                });
            }
        },
        getIdCredit: function (name) {
            var creditId = 0;

            if (name.indexOf('FE') !== -1) {
                creditId = util.config.FE;
            } else if (name.indexOf('ACS') !== -1) {
                creditId = util.config.ACS;
            } else if (name.indexOf('Home') !== -1) {
                creditId = util.config.Home;
            } else if (name.indexOf('HD') !== -1) {
                creditId = util.config.HDS;
            }
            return creditId;
        },
        convertDateToServer: function (stringDate) {
            var arr = stringDate.split('-'),
                newDate = '',
                monthConvert,
                    dayConvert;

            if (Number(arr[1]) > 0 && Number(arr[1]) < 10) {
                monthConvert = "0" + Number(arr[1]);
            } else {
                monthConvert = Number(arr[1]);
            }

            if (Number(arr[0]) > 0 && Number(arr[0]) < 10) {
                dayConvert = "0" + Number(arr[0]);
            } else {
                dayConvert = Number(arr[0]);
            }
            return newDate = arr[2] + "-" + monthConvert + "-" + dayConvert;
        },
        convertDateToServer: function (day, month, year) {
            var newDate = '',
                monthConvert,
                dayConvert;

            if (Number(month) > 0 && Number(month) < 10) {
                monthConvert = "0" + Number(month);
            } else {
                monthConvert = Number(month);
            }

            if (Number(day) > 0 && Number(day) < 10) {
                dayConvert = "0" + Number(day);
            } else {
                dayConvert = Number(day);
            }
            return newDate = year + "-" + monthConvert + "-" + dayConvert;
        },
        deleteClass: function (arrayElement, nameClass) {
            if ($.isArray(arrayElement) && arrayElement.length > 0) {
                $.each(arrayElement, function (i, v) {
                    $(v).removeClass(nameClass);
                });
            }
        },
        removeElementArray: function (value, array) {
            if (array.length > 0) {
                return $.grep(array, function (n, i) {
                    return n !== value;
                });
            }
        }
    };

    var Recuring = function () { }

    Recuring.prototype.init = function () {
        localStorage.removeItem(util.config.nameLocalStoreCustomerChoose);
        util.hideArrayElement(['#err-mess']);
        this.loadAmortizations();
        this.loadExhibit();
        this.loadPerSendPrepay();
        this.loadRecuringCustomerChooseDefault();

        $('#TgPopup').on('hidden.bs.modal', function (e) {
            util.resetInput(['#txtName', '#txtPhone', '#txtAddress']);
            util.resetSelect(['#sl-city', '#sl-district']);
            util.hideArrayElement(["#err-mess"]);
        });
    };

    Recuring.prototype.loadRecuringCustomerChooseDefault = function () {
        if ($('#wrapper-recuring-one').is(':visible') === false && $('#hidden-val').length > 0) {
            $('.trg-titm').html('Chọn gói trả góp theo nhu cầu của bạn');
            this.loadRecurringCustomerChoose({
                proid: 4,
                prepay: 30,
                termID: 12
            });
            $('.trg-secpack').slideDown();
        }
    };

    Recuring.prototype.loadDistrict = function (idCity) {
        $.ajax({
            url: ajaxUrl.GetListDistrict,
            type: 'GET',
            data: { cityId: idCity },
            beforeSend: function () {
                $('#sl-district').html('<option>Đang xử lý...</option>');
            }
        }).done(function (data) {
            var htmlOption = '<option value="0">Quận/Huyện</option>';

            $.each(data.list, function (i, v) {
                htmlOption += '<option value="' + v.ID + '">' + v.Name + '</option>';
            });

            $('#sl-district').html(htmlOption);
        })

    };

    Recuring.prototype.showModal = function (context) {
        var priceProduct = context.attr('data-price'),
            priceBefore = context.attr('data-pricebefore'),
            precentPrepay = context.attr('data-precent'),
            pricePrayPerMonth = context.attr('data-price-a-month'),
            monthPray = context.attr('data-month'),
            exhibit = context.attr('data-exhibit'),//giay to,
            credit = context.attr('data-credit'),
            urlImage = context.attr('data-img'),
            nameProduct = context.attr('data-name'),
            laisuatthuc = context.attr('data-laisuatthuc'),
            namePackage = context.attr('data-packe');
        $tgPopup = $('#TgPopup'),
        self = this;

        $tgPopup.find('#pop-name-product').text(nameProduct);
        $tgPopup.find('#pop-price').text(priceProduct + '₫');
        $tgPopup.find('#pop-prepayment').text(priceBefore + 'đ' + '(' + precentPrepay + '%)');
        $tgPopup.find('#pricePrayPerMonth-pop').text(pricePrayPerMonth + 'đ');
        $tgPopup.find('#month-pay').text(monthPray);
        $tgPopup.find('#cmd-pop').text(exhibit);
        $tgPopup.find('#credit-pop').text(credit);
        $tgPopup.modal('show');
        ga('send', 'event', 'ProductDetail', 'OrderRecurring', nameProduct);
        $('#frm-recuring-pop').off("submit").on('submit', function (event) {
            event.preventDefault();
            self.sendDataRecuring($(this), {
                priceProduct: priceProduct,
                priceBefore: priceBefore,
                precentPrepay: precentPrepay,
                pricePrayPerMonth: pricePrayPerMonth,
                monthPray: monthPray,
                exhibit: exhibit,
                userid: location.hash.substr(1),
                credit: credit,
                laisuatthuc: laisuatthuc,
                namePackage: namePackage
            });
            return false;
        });
    }

    Recuring.prototype.sendDataRecuring = function (context, data) {
        var self = this;

        if (this.validateFrm() === true) {
            util.hideArrayElement(["#err-mess"]);
            var gender = 0;

            $('.gender-popo').each(function () {
                if ($(this).is(':checked')) {
                    gender = $(this).val();
                }
            });

            $.ajax({
                url: ajaxUrl.InsertOrderRecuring,
                type: 'POST',
                data: {
                    variantId: self.getHiddenVal().productVariant,
                    customerName: self.buildNameCustomer(),
                    customerPhone: $('#txtPhone').val(),
                    identityCardNo: $('#txtCmd').val(),
                    birthDay: util.convertDateToServer($('#num1').val(), $('#num2').val(), $('#num3').val()),
                    cityId: $('#sl-city').val(),
                    districtId: $('#sl-district').val(),
                    customerAddress: $('#txtAddress').val(),
                    percentPrepay: data.precentPrepay,
                    pricePayPerMonth: data.pricePrayPerMonth,
                    prepaid: data.priceBefore,
                    gender: gender == 0 ? false : true,
                    monthBorrowing: $.trim(data.monthPray.replace('Tháng', '')),
                    recuringId: util.getIdCredit(data.credit),
                    exhibit: data.exhibit,
                    laisuat: data.laisuatthuc,
                    namePackage: data.namePackage,
                    userid: data.userid,
                    reffer: typeof $.cookie(nameCookieJsScript) != 'undefined' ? $.cookie(nameCookieJsScript) : document.referrer,
                    email: ''//$('#txtEmail').val()
                },
                beforeSend: function () {
                    util.hideArrayElement(['#btn-submit']);
                    util.showArrayElement(['#img-pop-loading']);
                }
            }).done(function (data) {
                if (data.Erros == false) {
                    util.hideArrayElement(['#img-pop-loading']);
                    util.showArrayElement(['#btn-submit']);
                    $('#TgPopup').modal('hide');
                    $('#mess-popup').html(data.Message);
                    $('#abc').modal('show');

                    $('#abc').on('hidden.bs.modal', function (e) {
                        $('#mess-popup').html('');
                        util.resetInput(['#txtName', '#txtPhone', '#txtAddress']);
                        util.resetSelect(['#sl-city', '#sl-district']);
                    })
                }
            });
        };

    };

    /**
     * @description Lay danh sach ky han vay
     */
    Recuring.prototype.loadAmortizations = function () {
        var self = this;
        if ($('#sl-Amortizations').length > 0) {
            $.ajax({
                url: ajaxUrl.GetListAmortizations,
                type: 'GET',
                beforeSend: function () {
                    $('#sl-Amortizations').html('<option>Đang xử lý dữ liệu...</option>')
                }
            }).done(function (data) {
                if (data.error == false) {
                    var htmlOption = '';

                    $.each(data.modal, function (i, v) {
                        htmlOption += '<option value="' + v.TemID + '">' + v.TemName + '</option>';
                    });
                    $('#sl-Amortizations').html(htmlOption);

                    $('#sl-Amortizations').find('option').each(function () {
                        if ($(this).val() == 12) {
                            $(this).attr('selected', 'selected');
                        }
                    });
                } else {

                }
            });
        }
    }

    /**
     * @descrition Lấy ra danh sách giấy tờ.
     */
    Recuring.prototype.loadExhibit = function () {
        if ($('#sl-exhibit').length > 0) {
            $.ajax({
                url: ajaxUrl.GetListExhibit,
                type: 'GET',
                beforeSend: function () {
                    $('#sl-exhibit').html('<option>Đang xử lý dữ liệu...</option>');
                }
            }).done(function (data) {
                if (data.error == false) {
                    var htmlOption = '';

                    $.each(data.modal, function (i, v) {
                        htmlOption += '<option value="' + v.ID + '">' + v.ProValue + '</option>'
                    });
                    $('#sl-exhibit').html(htmlOption);

                    $('#sl-exhibit').find('option').each(function () {
                        if ($(this).val() == 4) {
                            $(this).attr('selected', 'selected');
                        }
                    });
                }
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @descriptin Hàm lấy ra danh sách phần trăm trả trước
     */
    Recuring.prototype.loadPerSendPrepay = function () {
        var self = this;
        if ($('#sl-prepay').length > 0) {
            $.ajax({
                url: ajaxUrl.GetListPercentPrePay,
                type: 'GET',
                beforeSend: function () {
                    $('#sl-prepay').html('<option>Đang xử lý dữ liệu...</option>');
                }
            }).done(function (data) {
                if (data.error == false) {
                    var htmlOption = '';

                    $.each(data.modal, function (i, v) {
                        htmlOption += '<option data-val="' + v.PrePayValue + '" value="' + v.ID + '">' + v.PrePayName + '(' + util.calculatePricePrepay(self.getHiddenVal().price, v.PrePayValue) + ')₫' + '</option>';
                    });
                    $('#sl-prepay').html(htmlOption);
                    $('#sl-prepay').find('option').each(function () {
                        if ($(this).val() == 4) {
                            $(this).attr('selected', 'selected');
                        }
                    });
                }
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description : Hàm có chức năng load ra thông tin trả góp do người 
     * dùng lựa chọn
     */
    Recuring.prototype.loadRecurringCustomerChoose = function (datat) {
        var self = this,
            itemcode = self.getHiddenVal().sku,
            proid = datat.proid,
            prepay = datat.prepay,
            termID = datat.termID,
            toast,
            objStore = JSON.parse(localStorage.getItem(util.config.nameLocalStoreCustomerChoose));

        if (objStore !== null && objStore.proid === datat.proid && objStore.prepay === datat.prepay && objStore.termID === datat.termID && datat.init === false) {
            return false;
        } else if (objStore === null ||
            (objStore !== null && (objStore.proid !== datat.proid || objStore.prepay !== datat.prepay || objStore.termID !== datat.termID)) ||
            (objStore !== null && objStore.proid === datat.proid && objStore.prepay === datat.prepay && objStore.termID === datat.termID && datat.init === true)) {
            objStore = { proid: datat.proid, prepay: datat.prepay, termID: datat.termID };
            localStorage.removeItem(util.config.nameLocalStoreCustomerChoose);
            localStorage.setItem(util.config.nameLocalStoreCustomerChoose, JSON.stringify(objStore));
            $('.tbl-choose').removeClass('active');

            $.ajax({
                url: ajaxUrl.GetRecuringCustomerChoose,
                type: 'GET',
                data: { itemCode: itemcode, price: self.getHiddenVal().price.replace(/\./igm, ""), proid: proid, prepay: prepay, termID: termID },
                beforeSend: function () {
                    toast = toast = $().toastmessage('showToast', {
                        text: 'Bạn vui lòng chờ trong giây lát...',
                        sticky: true,
                        position: 'bottom-right',
                        type: 'warning'
                    });
                    self.resetTableCreditCustomerChoose(1);
                    self.resetTableCreditCustomerChoose(2);
                    self.resetTableCreditCustomerChoose(3);
                    self.resetTableCreditCustomerChoose(4);
                    util.deleteClass([$('.tbl-choose').eq(1).find('li:eq(9)').find('button'),
                                      $('.tbl-choose').eq(2).find('li:eq(9)').find('button'),
                                      $('.tbl-choose').eq(3).find('li:eq(9)').find('button'),
                                      $('.tbl-choose').eq(4).find('li:eq(9)').find('button')], "atModal");
                }
            }).done(function (data) {
                $().toastmessage('removeToast', toast);

                if (data.error == false) {
                    var companyCredit = '';

                    if (data.modal.length > 0) {
                        companyCredit = data.modal[0].CongTyDuyet;
                    }

                    var arrayNameCredit = ['FE CREDIT', 'HOME CREDIT', 'ACS', 'HD SAISON'];

                    $.each(data.modal, function (i, v) {
                        if (companyCredit == v.CongTyDuyet && data.modal.length > 1) {
                            $('.tbl-choose').eq(i + 1).addClass('active')
                        }
                        self.setValueRecurringCustomerChoose(i + 1, v);
                        var nameCredit = v.CongTyDuyet.toUpperCase();
                        arrayNameCredit = util.removeElementArray(nameCredit, arrayNameCredit);
                    });

                    $.each(arrayNameCredit, function (i, v) {
                        $('.tbl-choose').eq((4 - arrayNameCredit.length) + (i + 1)).find('li:eq(0)').find('h3').html(v);
                    });
                }
            })
        }
    };

    Recuring.prototype.validateFrm = function () {
        if ($.trim($('#txtName').val()) === '') {
            $('#err-mess').text('Vui lòng nhập họ và tên.');
            util.showArrayElement(['#err-mess']);
            return false;
        } else if ($.trim($('#txtName').val()).length > 150) {
            $('#err-mess').text('Họ tên không quá 150 ký tự');
            util.showArrayElement(['#err-mess']);
            return false;
        }
        else if (util.isPhone($('#txtPhone').val() || '') === false) {
            $('#err-mess').text('Số điện thoại cần là số di động (9 hoặc 11 số).');
            util.showArrayElement(['#err-mess']);
            return false;
        } else
            if (util.isCmd($('#txtCmd').val() || '') === false) {
            $('#err-mess').text('Vui lòng nhập số CMND (9 hoặc 12 số).');
            util.showArrayElement(['#err-mess']);
            return false;
        } else if (util.isBirth($('#num1').val(), $('#num2').val(), $('#num3').val()).error === false) {
            $('#err-mess').text(util.isBirth($('#num1').val(), $('#num2').val(), $('#num3').val()).messages);
            util.showArrayElement(['#err-mess']);
            return false;
        } else
            if ($('#sl-city').val() === '0') {
            $('#err-mess').text('Vui lòng chọn tỉnh thành bạn đang sinh sống.');
            util.showArrayElement(['#err-mess']);
            return false;
        } else if ($('#sl-district').val() === '0') {
            $('#err-mess').text('Vui lòng chọn quận huyện bạn đang sinh sống.');
            util.showArrayElement(['#err-mess']);
            return false;
        } else if ($.trim($('#txtAddress').val()) === '') {
            $('#err-mess').text('Vui lòng nhập số nhà/địa chỉ của bạn.');
            util.showArrayElement(['#err-mess']);
            return false;
        } else
            //if (util.isEmail($('#txtEmail').val()) === false) {
            //$('#err-mess').text('Email chưa đúng định dạng.');
            //util.showArrayElement(['#err-mess']);
            //return false;
            //} else
            {
            util.hideArrayElement(['#err-mess']);
            return true;
        }
    };

    /**
     * @author nghiatc2.
     * @description Xét giá trị cho bảng trả góp khi người dùng chọn.
     */
    Recuring.prototype.setValueRecurringCustomerChoose = function (position, v) {
        var self = this;

        if (typeof v.CongTyDuyet !== 'undefined' && v.CongTyDuyet !== null) {
            $('.tbl-choose').eq(position).find('li:eq(0)').find('h3').html(v.CongTyDuyet.toUpperCase());
        } else {
            $('.tbl-choose').eq(position).find('li:eq(0)').find('h3').text('-');
        }

        if (typeof v.TienTraTruoc !== 'undefined' && v.TienTraTruoc !== null) {
            $('.tbl-choose').eq(position).find('li:eq(1)').find('p').html("<strong>" + Math.round(Number(v.TienTraTruoc)).format(0, 3, '.', '.') + '₫' + "<strong>");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(1)').find('p').text('-');
        }

        if (typeof v.TienTraTruoc !== 'undefined' && v.TienTraTruoc !== null) {
            $('.tbl-choose').eq(position).find('li:eq(1)').find('p').html("<strong>" + Math.round(Number(v.TienTraTruoc)).format(0, 3, '.', '.') + '₫' + "<strong>");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(1)').find('p').text('-');
        }

        if (typeof v.GopMoiThang !== 'undefined' && v.GopMoiThang !== null) {
            $('.tbl-choose').eq(position).find('li:eq(2)').find('p').html("<strong class='tr-dcr'>" + Math.round(Number(v.GopMoiThang)).format(0, 3, '.', '.') + '₫' + "<strong>");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(2)').find('p').text('-');
        }

        if (typeof v.LaiSuatPhang !== 'undefined' && v.LaiSuatPhang !== null && typeof v.LaiSuatThuc !== 'undefined' && v.LaiSuatThuc !== null) {
            $('.tbl-choose').eq(position).find('li:eq(3)').find('p').text(parseFloat(v.LaiSuatPhang.toFixed(5)) + "% / " + parseFloat(v.LaiSuatThuc.toFixed(5)) + "%");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(3)').find('p').text('-');
        }

        if (typeof v.PhiThuHo !== 'undefined' && v.PhiThuHo !== null) {
            $('.tbl-choose').eq(position).find('li:eq(4)').find('p').text(Math.round(Number(v.PhiThuHo)).format(0, 3, '.', '.') + '₫/tháng');
        } else {
            $('.tbl-choose').eq(position).find('li:eq(4)').find('p').text('-');
        }

        if (typeof v.PhiBaoHiem !== 'undefined' && v.PhiBaoHiem !== null) {
            $('.tbl-choose').eq(position).find('li:eq(5)').find('p').text(Math.round(Number(v.PhiBaoHiem)).format(0, 3, '.', '.') + ' ₫/tháng');
        } else {
            $('.tbl-choose').eq(position).find('li:eq(5)').find('p').text('-');
        }

        if (typeof v.TongTienTra !== 'undefined' && v.TongTienTra !== null) {
            $('.tbl-choose').eq(position).find('li:eq(6)').find('p').html("<strong>" + Math.round(Number(v.TongTienTra)).format(0, 3, '.', '.') + '₫' + "</strong>");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(6)').find('p').text('-');
        }

        if (typeof v.TienChenhLech !== 'undefined' && v.TienChenhLech !== null) {
            $('.tbl-choose').eq(position).find('li:eq(7)').find('p').html("<strong>" + Math.round(Number(v.TienChenhLech)).format(0, 3, '.', '.') + '₫' + "</strong>");
        } else {
            $('.tbl-choose').eq(position).find('li:eq(7)').find('p').text('-');
        }

        if (typeof v !== 'undefined' && v !== null) {
            $('.tbl-choose').eq(position).find('li:eq(8)').find('button').html('Chọn ' + v.CongTyDuyet).attr({
                'data-price': self.getHiddenVal().price,
                'data-pricebefore': Math.round(Number(v.TienTraTruoc)).format(0, 3, '.', '.'),
                'data-precent': v.PhanTramTraTruoc,
                'data-price-a-month': Math.round(Number(v.GopMoiThang)).format(0, 3, '.', '.'),
                'data-month': v.SoThangTra,
                'data-exhibit': $('#sl-exhibit').find('option:selected').text(),
                'data-credit': v.CongTyDuyet,
                'data-name': self.getHiddenVal().name,
                'data-packe': 'GÓI LÃI SUẤT THƯỜNG',
                'data-laisuatthuc': v.LaiSuatThuc.toString().replace(/\./igm, ',')
            }).addClass('atModal').show();
            $('.tbl-choose').eq(position).find('li:eq(8)').find('p').hide();
        }
    };

    /**
     * @author Nghiatc2.
     * @description  Reset value trong bảng recuring người dùng lựa chọn
     */
    Recuring.prototype.resetTableCreditCustomerChoose = function (position) {
        $('.tbl-choose').eq(position).find('li:eq(0)').find('h3').text('-');
        $('.tbl-choose').eq(position).find('li:eq(1)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(2)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(3)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(4)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(5)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(6)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(7)').find('p').text('-');
        $('.tbl-choose').eq(position).find('li:eq(8)').find('p').show();
        $('.tbl-choose').eq(position).find('li:eq(8)').find('button').hide();
    }


    Recuring.prototype.buildLabelCompanyRepayment = function (nameCompany) {
        var htmlLabelCompany = "";

        switch (nameCompany) {
            case "ACS":
                htmlLabelCompany += "<p class='tgp-price tgp-clr1'>";
                htmlLabelCompany += "<img src='http://fptshop.com.vn/Content/v3/images/tragop/icon-tg-asc.jpg'/>";
                htmlLabelCompany += "</p>";
                break;
            case "FE Credit":
                htmlLabelCompany += "<p class='tgp-price tgp-clr2'><img src='http://fptshop.com.vn/Content/v3/images/tragop/icon-tg-fe.jpg' /></p>";
                break;
            case "Home Credit":
                htmlLabelCompany += "<p class='tgp-price tgp-clr3'><img src='http://fptshop.com.vn/Content/v3/images/tragop/icon-tg-hc.jpg' /></p>";
                break;
            case "HD SAISON":
                htmlLabelCompany += "<p class='tgp-price tgp-clr4'><img src='http://fptshop.com.vn/Content/v3/images/tragop/icon-tg-hdsaigon.jpg' /></p>";
                break;
            default:
                htmlLabelCompany += "<p class='tgp-price tgp-clr4'>-</p>";
                break;
        }
        return htmlLabelCompany;
    }

    Recuring.prototype.search = function (context) {
        var keyword = context.val();
        $('.trg-suggest').html('');
        $.ajax({
            url: ajaxUrl.SearchLucene,
            type: 'GET',
            dataType: 'json',   //you may use jsonp for cross origin request
            crossDomain: true,
            contentType: "text/plain",
            data: { searchTerm: keyword, searchField: 'NameProduct', searchDefault: '' }
        }).done(function (data) {
            var result = "<ul>";
            if (data.searchRecuringResults == '') {
                result += "<div>Không tìm thấy kết quả với <strong>" + keyword + "</strong></div>";
            } else {
                $.each(data.searchRecuringResults, function (i, v) {
                    var t = v.NameProduct.toLowerCase().replace(keyword.toLowerCase(), "<b>" + keyword.toLowerCase() + "</b>"),
                        href = "/" + v.TypeNameAscii + "/" + v.NameAscii + "/" + v.ProductID + "/tra-gop";

                    result += '<li><a href="' + href + '">' + t + '</a></li>';
                });
            }
            result += "</ul>";
            $('.trg-suggest').html(result);
        });
    };

    /**
     * @author Nghiatc2
     * @descrtion Hàm trả ra các giá trị ẩn trong html.
     */
    Recuring.prototype.getHiddenVal = function () {
        return {
            sku: $('#hidden-val').attr('data-sku'),
            price: $('#hidden-val').attr('data-price'),
            name: $('#hidden-val').attr('data-name'),
            productVariant: $('#hidden-val').attr('data-variant')
        };
    };

    /**
     *@author Nghiatc2.
     * @description Hàm trả về tên khách hàng
     */
    Recuring.prototype.buildNameCustomer = function () {
        var nameCutomer = $('#txtName').val();

        if (window.location.href.indexOf(util.config.Mpost) > -1) {
            nameCutomer = 'mpot-test-' + $('#txtName').val();
        }
        return nameCutomer;
    }
    return {
        recuringObj: function () {
            var recuringObj = new Recuring();
            return recuringObj;
        }
    }
})();

/**
 * Number.prototype.format(n, x, s, c)
 * 
 * @param integer n: length of decimal
 * @param integer x: length of whole part
 * @param mixed   s: sections delimiter
 * @param mixed   c: decimal delimiter
 */
Number.prototype.format = function (n, x, s, c) {
    "use strict";
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\D' : '$') + ')',
        num = this;
    num = num.toString();

    return (c ? num.replace(',', c) : num).replace(/\d(?=(\d{3})+$)/g, '$&.');
};