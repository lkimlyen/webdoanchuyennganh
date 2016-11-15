jQuery(document).ready(function ($) {
    var calculatePricePrivacyNotApple = new CalculatePricePrivacy({
        elementDate: '#calendar-icon-not-apple',
        elementPrice: '#vnd-icon-not-apple',
        elementStatus: '#policy-drop-not-apple',
        elementTitle: '#msg-not-apple',
        url: UtilModules.linkToServer().linkGetPricePrivacy
    });
    calculatePricePrivacyNotApple.run();

    var calculatePricePrivacyApple = new CalculatePricePrivacy({
        elementDate: '#calendar-icon-apple',
        elementPrice: '#vnd-icon-apple',
        elementStatus: '#policy-drop-apple',
        elementTitle: '#msg-apple',
        url: UtilModules.linkToServer().linkGetPricePrivacy
    });
    calculatePricePrivacyApple.run();

    var menuPrivacy = new MenuPrivacy('.policy-menu');
    menuPrivacy.setActive();

    var brandWarranty = new BrandWarranty({
        elementBrandWarranty: '.ntc-brand-warranty',
        urlGetWarrantyCenter: UtilModules.linkToServer().linkGetWarrantyCenter,
        dataBrandCode: 'data-code',
        elementWrapperAllWarrantyCener: '#ntc-wrapper-all-warranty'
    });
    brandWarranty.loadWarrantyCenter();
  
    $('#vnd-icon-not-apple').keydown(function (event) {
        var $self = $(this);

        if (event.keyCode > 31 && (event.keyCode < 48 || event.keyCode > 57)) {
            event.preventDefault();
        }
    });

    $('#vnd-icon-not-apple').on('keyup', function (event) {
        var $self = $(this);
        var price = $.trim($self.val());

        if (price !== '') {
            price = price.replace(/\x2E/g, '');
            price = Number(price).format(0, 3, '.', '.');
            $self.val(price);
        }
    });

    $('.csbh-more span').click(function () {
        $('.csbh-scroll').addClass('csbh-scall');
        $('.csbh-more').hide();
    })

});

$(window).load(function () {
    $('#calendar-icon-not-apple').datepicker({
        format: 'dd/mm/yyyy'
    });
});

/**
 * @author Nghiatc2.
 * @constructor
 * @description
 * Tạo một lớp tính toán giá trị đổi trả.
 * @param options = > Nhận vào một đối tượng có các tham thuộc tính
 * elementDate => id hoặc class của element mà người dùng nhập ngày mua.
 * elementPrice => id hoặc class của element mà người dùng nhập giá.
 * elementStatus => id hoặc class của element lựa chọn trạng thái của sản phẩm.
 * elementTitle => id hoặc class của element hiện thông báo giá và ngày mua.
 * url => link to hàm trên server để tính toán tỷ giá.
 **/
var CalculatePricePrivacy = function (options) {
    this.elementDate = options.elementDate || '';
    this.elementPrice = options.elementPrice || '';
    this.elementStatus = options.elementStatus || '';
    this.elementTitle = options.elementTitle || '';
    this.url = options.url || '';
};

/**
 * @author Nghiatc2.
 * @function
 * @description
 * Tính toán tỷ giá đổi trả.
 **/
CalculatePricePrivacy.prototype.run = function () {
    var self = this;

    if ($(self.elementDate).length > 0 && $(self.elementPrice).length > 0 && $(self.elementStatus).length > 0) {

        $(self.elementStatus).on('change', function () {
            var $selfSatus = $(this),
                status = $.trim($selfSatus.val()),
                dateBuyProduct = $.trim($(self.elementDate).val()),
                priceBuy = $.trim($(self.elementPrice).val()),
                newDateBuyProduct = UtilModules.formatDateTimeFromString(dateBuyProduct, UtilModules.configConstant().configDdMmYy, UtilModules.configConstant().configMmDdYy),
                utcDate = new Date().toJSON().slice(0, 10),
                currentDate = UtilModules.formatDateTimeFromString(utcDate, UtilModules.configConstant().configYyMmDd, UtilModules.configConstant().configMmDdYy);

            if (status !== '') {
                if (dateBuyProduct === '') {
                    alert('bạn chưa nhập ngày mua');
                    $(self.elementTitle).hide();
                } else if (priceBuy === '') {
                    alert('bạn chưa nhập giá mua');
                    $(self.elementTitle).hide();
                } else if (UtilModules.validateDateTime(dateBuyProduct) === false) {
                    alert('Định dạng ngày tháng không đúng! Vui lòng nhập ngày tháng theo định dạng (ngày/tháng/năm)');
                    $(self.elementTitle).hide();
                } else {
                    priceBuy = priceBuy.replace(/\x2E/g, '');
                    var monthelapsed = UtilModules.calculateTotalMonthsDifference(newDateBuyProduct, currentDate),
                        dayElapes = UtilModules.calculateDistanceDay(newDateBuyProduct, currentDate);
                    
                    console.log(dayElapes);
                    if (dayElapes > 0) {
                        var priceChange = self.calCulate(dayElapes, priceBuy, status, monthelapsed);

                        $(self.elementTitle).html('Bạn mua máy được <strong class="colorred"> ' + dayElapes + ' ngày</strong>  phí đổi trả là: <strong class="colorred">' + priceChange + ' đ</strong>').show();
                    } else {
                        $(self.elementTitle).html('Không được chọn ngày lớn hơn ngày hiện tại.').show();
                    }

                    //$.ajax({
                    //    type: 'GET',
                    //    url: self.url,
                    //    cache: false,
                    //    data: { date: newDateBuyProduct, price: priceBuy, status: status },
                    //    beforeSend: function () {
                    //        $(self.elementTitle).show();
                    //        $(self.elementTitle).html('Đang xử lý dữ liệu');
                    //    }
                    //}).done(function (data) {
                    //    if (typeof data !== "undefined") {
                    //        if (data.error === false) {
                    //            $(self.elementTitle).html('Bạn mua máy được <strong class="colorred"> ' + data.dateBought + ' ngày</strong>  phí đổi trả là: <strong class="colorred">' + data.costChange + ' đ</strong>');
                    //        } else {
                    //            $(self.elementTitle).html(data.message);
                    //        }
                    //    } else {
                    //        $(self.elementTitle).html('Đã xảy ra lỗi!.Vui lòng thử lại sau ít phút.');
                    //    }
                    //});
                }
            }

        });
    }
};

/**
 * @author Nghiatc2.
 * @function
 * @description
 * Tính toán tỷ giá đổi trả.
 * @param {int} dayBuy, {float} priceBuy, {int}statusBuy
 **/
CalculatePricePrivacy.prototype.calCulate = function (day, price, statusBuy, monthelapsed) {
    var cost = 0;
    statusBuy = Number(statusBuy);

    switch (statusBuy) {
        case 0:
            if (day >= 0 && day <= 30) {
                cost = (price * 20) / 100;
            }

            if (day > 30) {
                var percent = ((monthelapsed * 5) + 20);
                cost = (price * percent)/100;
            }
            break;
        case 1:
            if (day >= 0 && day <= 30) {
                cost = (price * 20) / 100;
            }
          
            if (day > 30) {
                var percent = ((monthelapsed * 5) + 20);
                cost = (price * percent)/100;
            }
    }
    return Number(cost).format(0, 3, '.', '.');
};

/**
 * @author Nghiatc2.
 * @description
 * Khởi tạo một module util chứa các hàm xử lý tiện ích.
 **/
var UtilModules = (function () {
    var linkToServer,
        removeSpaces,
        formatDateTimeFromString,
        configConstant,
        validateDateTime,
        calculateDistanceDay,
        treatAsUTC,
        getCurrentDateTime;

    var calculateTotalMonthsDifference = function (firstDate, secondDate) {
        var firstDateTemp = new Date(firstDate);
        var secondDateTemp = new Date(secondDate);

        var fm = firstDateTemp.getMonth();
        var fy = firstDateTemp.getFullYear();
        var sm = secondDateTemp.getMonth();
        var sy = secondDateTemp.getFullYear();
        var months = Math.abs(((fy - sy) * 12) + fm - sm);
        var firstBefore = firstDateTemp > secondDateTemp;
        firstDateTemp.setFullYear(sy);
        firstDateTemp.setMonth(sm);
        firstBefore ? firstDateTemp < secondDateTemp ? months-- : "" : secondDateTemp < firstDateTemp ? months-- : "";
        return months;
    };

    linkToServer = function () {
        return {
            linkGetPricePrivacy: '/Ajax/Guide/CalculatorPercenChangeDevice',
            linkGetWarrantyCenter: '/Ajax/Guide/GetListWarrantyCenter'
        };
    };

    removeSpaces = function (string) {
        return string.split(' ').join('');
    };

    treatAsUTC = function (date) {
        var result = new Date(date);

        result.setMinutes(result.getMinutes() - result.getTimezoneOffset());
        return result;
    };

    /**
     * @author Nghiatc2.
     * @function.
     * @description Hàm có chức năng convert định dạng ngày tháng năm.
     * @param {string} strDateTime Ngày tháng muốn chuyển đổi.
     * @param {string} fromFormat Định dạng ban đầu.
     * @param {string} toFormat Định dạng muốn convert đến.
     * @return {string} newDateTimeFormat Định dạng mới.
     * @example 
     * var dateTime = "7/2/2015";
     * var fromFormat = "dd/mm/yy";
     * var toFormat = "mm/dd/yy";
     * var newDateTime = formatDateTimeFromString(dateTime,fromFormat,toFormat);
     * result => 2/7/2015.
     */
    formatDateTimeFromString = function (strDateTime, fromFormat, toFormat) {
        var strDateTimeTemp = [], newDateTimeFormat = "";

        if ($.trim(fromFormat) === configConstant().configDdMmYy && $.trim(toFormat) === configConstant().configMmDdYy) {

            strDateTimeTemp = strDateTime.split('../index.html');

            /* Kiểm tra xem ngày tháng truyền vào có hợp lệ*/
            if (strDateTimeTemp.length > 3 || typeof strDateTimeTemp === 'undefined' || strDateTimeTemp === null) {
                newDateTimeFormat = "";
            } else {
                newDateTimeFormat = strDateTimeTemp[1] + '/' + strDateTimeTemp[0] + '/' + strDateTimeTemp[2];
            }
        } else if ($.trim(fromFormat) === configConstant().configYyMmDd && $.trim(toFormat) === configConstant().configMmDdYy) {
            strDateTimeTemp = strDateTime.split('-');
           
            /* Kiểm tra xem ngày tháng truyền vào có hợp lệ*/
            if (strDateTimeTemp.length > 3 || typeof strDateTimeTemp === 'undefined' || strDateTimeTemp === null) {
                newDateTimeFormat = "";
            } else {
                newDateTimeFormat = strDateTimeTemp[1] + '/' + strDateTimeTemp[2] + '/' + strDateTimeTemp[0];
            }
        }
        return newDateTimeFormat;
    };

    /**
     * @author Nghiatc2.
     * @function.
     * @description Hàm có chức năng chứa các thông tin cấu hình cũng như các hằng số,config.
     */
    configConstant = function () {
        return {
            configDdMmYy: 'dd/mm/yy',
            configMmDdYy: 'mm/dd/yy',
            configYyMmDd:'yy/mm/dd'
        };
    };

    /**
     * @author Nghiatc2.
     * @function.
     * @description Hàm có chức năng validate ngày tháng năm theo định dang (dd/mm/yyy).
     * @param {string} strDateTime Ngày tháng cần validate.
     */
    validateDateTime = function (strDateTime) {
        var strDateTimeTemp = $.trim(strDateTime),
            regexDatePartner = /^(\d{1,2})(\x2f)(\d{1,2})(\x2f)(\d{4})$/,
            dtDay = 0, dtMonth = 0, dtYear = 0, arrDate = [];


        if (strDateTimeTemp === '') {
            return false;
        } else if (strDateTimeTemp.indexOf('../index.html') === -1) {
            return false;
        } else if (strDateTimeTemp.match(regexDatePartner) === null) {
            return false;
        }

        arrDate = strDateTimeTemp.split('../index.html');
        dtDay = arrDate[0];
        dtMonth = arrDate[1];
        dtYear = arrDate[2];

        if (arrDate.length > 3) {
            return false;
        } else if (dtDay < 1 || dtDay > 31) {
            return false;
        } else if (dtMonth < 1 || dtMonth > 12) {
            return false;
        } else if ((dtMonth == 4 || dtMonth == 6 || dtMonth == 9 || dtMonth == 11) && dtDay == 31) {
            return false;
        } else if (dtMonth === 2) {
            var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));

            if (dtDay > 29 || (dtDay == 29 && !isleap)) {
                return false;
            }
        }

        return true;
    }

    calculateDistanceDay = function (startDate,endDate) {
        var millisecondsPerDay = 24 * 60 * 60 * 1000;
        
        return (treatAsUTC(endDate) - treatAsUTC(startDate)) / millisecondsPerDay;
    };

    getCurrentDateTime = function() {

    };
    return {
        linkToServer: linkToServer,
        removeSpaces: removeSpaces,
        formatDateTimeFromString: formatDateTimeFromString,
        configConstant: configConstant,
        validateDateTime: validateDateTime,
        calculateDistanceDay: calculateDistanceDay,
        calculateTotalMonthsDifference: calculateTotalMonthsDifference
    };
}());

/**
 * @author Nghiatc2.
 * @constructor
 * @description
 * Tạo một đối tượng xử lý menu chính sách.
 * @param {string} elementWrapperMenu Element cha của menu.
 **/
var MenuPrivacy = function (elementWrapperMenu) {
    this.elementWrapperMenu = elementWrapperMenu || '';
};

/**
 * @author Nghiatc2.
 * @function
 * @description
 * Hàm xử lý set active cho menu.
 **/
MenuPrivacy.prototype.setActive = function () {
    var self = this,
        currentUrl = $.trim(window.location.pathname);

    if ($(self.elementWrapperMenu).length > 0) {
        $(self.elementWrapperMenu).find('a').each(function () {
            var $self = $(this),
                hrefLink = $self.attr('href');

            if ($self.hasClass('active')) {
                $self.removeClass('active');
            } else if (hrefLink.match(currentUrl)) {
                $self.addClass('active');
            }
        });
    }
};

/**
 * @author Nghiatc2.
 * @constructor.
 * @description Khởi tạo một đối tượng hãng bảo hành.
 * @param {object} options Một đối tượng chứa các tham số đầu vào.
 * @property {string} elementBrandWarranty => Id hoặc class của div chứa hãng bảo hành.
 * @property {string} urlGetWarrantyCenter => url lấy danh sách trung tâm bảo hành.
 * @property {string} dataBrandCode => thuộc tính data của thẻ html chứa mã hãng bảo hành.
 * @property {string} elementWrapperAllWarrantyCener => Id hoặc class của div bao quanh có id ntc-wrapper-all-warranty.
 */
var BrandWarranty = function (options) {

    this.elementBrandWarranty = $.trim(options.elementBrandWarranty || '');
    this.elementWrapperAllWarrantyCener = $.trim(options.elementWrapperAllWarrantyCener || '');
    this.urlGetWarrantyCenter = $.trim(options.urlGetWarrantyCenter || '');
    this.dataBrandCode = $.trim(options.dataBrandCode || '');

    this.warrantyCenter = new WarrantyCenter({
        elementWrapperWarrantyCenter: '#ntc-warraper-center'
    });
    this.filterWarrantyCenter = new FilterWarranty({
        elementSelectFilter: '#ntc-select-filter-warranty'
    });
};

/**
 * @author Nghiatc2.
 * @function loadWarrantyCenter.
 * @description Khi click vào biểu tượng từng hãng thì gọi tới hàm GetListWarrantyCenter trên server.
 */
BrandWarranty.prototype.loadWarrantyCenter = function () {
    var self = this;

    if ($(self.elementBrandWarranty).length > 0) {

        $(self.elementBrandWarranty).off('click').on('click', function () {
            var $self = $(this), brandCode = $self.attr(self.dataBrandCode),
                nameBrandWarranty = $self.attr('title');

            $('#csbh-scroller').data('nameBrandWarranty', nameBrandWarranty);

            $.ajax({
                type: 'GET',
                url: self.urlGetWarrantyCenter,
                data: { sHierarchyCode: brandCode, sRegionHierarchyCode: undefined },
                cache: false,
                beforeSend: function () {
                    $('#load-ajax').show();
                    $(self.elementWrapperAllWarrantyCener).hide();
                }
            }).done(function (data) {
                if (typeof data !== "undefined") {

                    $('#load-ajax').hide();

                    setTextTotalWrantyCenter(data.Total, nameBrandWarranty, undefined);

                    $(self.elementWrapperAllWarrantyCener).show();

                    /* 
                     * Triệu gọi hàm load của đối tượng warrantyCenter,
                     * hiển thị danh sách các trung tâm bảo hành.
                     */
                    self.warrantyCenter.load(data.ViewListWarrantyCenter);

                    /* 
                     * Triệu gọi hàm loadListRegion của đối tượng filterWarrantyCenter,
                     * hiển thị danh sách vùng của trung tâm bảo hành.
                     */
                    self.filterWarrantyCenter.loadListRegion(data.ViewSelectRegion);

                    /* 
                     * Triệu gọi hàm filterWarranty của đối tượng filterWarrantyCenter.
                     * Lọc danh sách trung tâm bảo hành theo vùng miền.
                     */
                    self.filterWarrantyCenter.filterWarranty(self.warrantyCenter, brandCode, self.urlGetWarrantyCenter);

                    $('#ntc-select-filter-warranty').find('option:contains("Toàn quốc")').attr('selected', 'selected');
					
        $('html, body').animate({ scrollTop: $(".csbh-tblmain").offset().top - 100}, 1000);
 
                }
            });
        });
    }
};

/**
 * @author Nghiatc2.
 * @constructs.
 * @description Khởi tạo một đối tượng thực hiện các chức năng liên quan đến trung tâm bảo hành.
 * @param {object} options Đối tượng có chức năng chứa các tham số đầu vào.
 * @property {string} elementWrapperWarrantyCenter => Id hoặc class của div bao bọc tất cả nội dung trung tâm bảo hành.
 */
var WarrantyCenter = function (options) {
    this.elementWrapperWarrantyCenter = $.trim(options.elementWrapperWarrantyCenter || '');
};

/**
 * @author Nghiatc2.
 * @function load.
 * @description Hàm có chức năng thực hiện việc load danh sách trung tâm bảo hành.
 */
WarrantyCenter.prototype.load = function (htmlWarrantyCenter) {
    var self = this;

    $('#tbl-wranty-ntc').find('tbody').html(htmlWarrantyCenter);
};

/**
 * @author Nghiatc2.
 * @constructs.
 * @description Khởi tạo một đối tượng thực hiện các chức năng lọc trung tâm bảo hành theo vùng miền.
 * @param {object} options Đối tượng có chức năng chứa các tham số đầu vào.
 * @property {string} elementSelectFilter => Id hoặc class của select chứa danh sách tỉnh thành.
 */
var FilterWarranty = function (options) {
    this.elementSelectFilter = $.trim(options.elementSelectFilter || '');
};


/**
 * @author Nghiatc2.
 * @function loadListRegion.
 * @description Hàm có chức năng thực hiện load danh tỉnh thành ứng với hãng bảo hành.
 */
FilterWarranty.prototype.loadListRegion = function (htmlData) {
    var self = this;

    $(document).find(self.elementSelectFilter).html(htmlData);
};

/**
 * @author Nghiatc2.
 * @function filterWarranty.
 * @description Hàm có chức năng thực hiện lọc danh sách trung tâm bảo hành.
 */
FilterWarranty.prototype.filterWarranty = function (warrantyCenter, brandCode, urlFilter) {
    var self = this;
    console.log($(self.elementSelectFilter))
    $(self.elementSelectFilter).off('change').on('change', function () {
        var $self = $(this), regionCode = $self.val(),
            nameBrandWarnty = $('#csbh-scroller').data('nameBrandWarranty'),
            nameRegion = $self.find("option:selected").text();

        $.ajax({
            type: 'GET',
            url: urlFilter,
            data: { sHierarchyCode: brandCode, sRegionHierarchyCode: regionCode },
            cache: false,
            beforeSend: function () {
                warrantyCenter.load('<span>Đang xử lý dữ liệu</span><img src="../Content/Publishing/Privacy/images/wait.gif"/>');
            }
        }).done(function (data) {
            if (typeof data !== "undefined") {
                setTextTotalWrantyCenter(data.Total, nameBrandWarnty, nameRegion);

                warrantyCenter.load(data.ViewListWarrantyCenter);
            }
        });
    });
};


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

function setTextTotalWrantyCenter(total, nameBrandWranty, nameRegion) {
    $('#total-wranty-center').html(total);
    $('#name-wranty-center').html(nameBrandWranty);

    if ($.type(nameRegion) !== 'undefined') {
        $('#region-name').html(nameRegion);
    }

}

 $(function(){
	if ($(document).width() < 768){
		$('.shop-cs-sbartitlebox a').addClass('collapsed');
		$('.shop-cs-sbartitlebox a, .shop-cs-sbarlist').attr('aria-expanded','false');
		$('.shop-cs-sbarlist').removeClass('in');
	}
	else{
		$('.shop-cs-sbartitlebox a').removeClass('collapsed');
		$('.shop-cs-sbartitlebox a, .shop-cs-sbarlist').attr('aria-expanded','true');
		$('.shop-cs-sbarlist').addClass('in');
	}
})

$(window).resize(function() {
	if ($(document).width() < 768){
		$('.shop-cs-sbartitlebox a').addClass('collapsed');
		$('.shop-cs-sbartitlebox a, .shop-cs-sbarlist').attr('aria-expanded','false');
		$('.shop-cs-sbarlist').removeClass('in');
	}
	else{
		$('.shop-cs-sbartitlebox a').removeClass('collapsed');
		$('.shop-cs-sbartitlebox a, .shop-cs-sbarlist').attr('aria-expanded','true');
		$('.shop-cs-sbarlist').addClass('in');
	}
}); 
