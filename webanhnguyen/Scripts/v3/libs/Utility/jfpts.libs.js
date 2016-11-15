var jfpts = jfpts || {};

jfpts.libs = jfpts.libs || {};

(function () {
    /**
     * @author Nghiatc2.
     * @description:Hàm thực hiện chức năng ẩn một mảng các element html.
     * @param {string[]} arrayElement - ['#idName','.className']
     * @example jfpts.libs.hideArrayElementHtml(['#idName','.className']) <=> $('#idName').hide();$('.className').hide();
     */
    this.hideArrayElementHtml = function (arrayElement) {
        if ($.isArray(arrayElement) && arrayElement.length > 0) {
            $.each(arrayElement, function (i, v) {
                $(v).hide();
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description:Hàm thực hiện chức năng show một mảng các element html.
     * @param {string[]} arrayElement - ['#idName','.className']
     * @example jfpts.libs.showArrayElement(['#idName','.className']) <=> $('#idName').show();$('.className').show();
     */
    this.showArrayElement = function (arrayElement) {
        if ($.isArray(arrayElement) && arrayElement.length > 0) {
            $.each(arrayElement, function (i, v) {
                $(v).show();
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description:Hàm thực hiện chức năng xét lại giá trị mặc định cho các input.
     * @param {string[]} arrayElement - ['#idName','.className']
     * @example jfpts.libs.resetArayInput(['#idName','.className']) <=> $('#idName').val('');$('.className').val('');
     */
    this.resetArayInput = function (arrayInput) {
        if ($.isArray(arrayInput) && arrayInput.length > 0) {
            $.each(arrayInput, function (i, v) {
                $(v).val('');
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description Hàm dùng để chọn option mặc định cho thẻ select.
     * @param {string[]} mảng các id hoặc class của select.
     * @param {string} giá trị của option cần lựa chọn.
     * @example jfpts.libs.resetArraySelect(['#id','.class'],0)
     */
    this.resetArraySelect = function (arraySelecttion, valueReset) {
        if ($.isArray(arraySelecttion) && arraySelecttion.length > 0) {
            $.each(arraySelecttion, function (i, v) {
                $(v).find('option[value="' + valueReset + '"]').prop('selected', true)
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description:Hàm thực hiện chức năng xóa một phần tử trong mảng.
     * @param {Array} array - [a,b,c].
     * @param value - giá trị cần loại bỏ trong array.
     * @example 
     * var arrayTest = ['a','b','c']
     * jfpts.libs.removeElementArray('a',arrayTest) => ['b','c'].
     * @return {Array} - mảng mới sau khi đã xóa phần tử.
     */
    this.removeElementArray = function (value, array) {
        if ($.isArray(array) && array.length > 0) {
            return $.grep(array, function (n, i) {
                return n !== value;
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description Xóa object json trong một mảng.
     * @param {array} array - mảng json.
     * @param propertyNameObject {string} thuộc tính của đối tượng cần xóa.
     * @param valueRemove giá trị của thuộc tính
     * @example jfpts.libs.removeObjectInArray([{id: 1,name:'nghia'},{id:2,name:'b'}],'id',1) = >[{id:2,name:'b'}]
     */
    this.removeObjectInArray = function (array,propertyNameObject,valueRemove) {
        if (array.length > 0) {
            return $.grep(array, function (n, i) {
                return n[propertyNameObject] != valueRemove;
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description:Hàm thực hiện chức năng xóa class cho nhiều phần tử html.
     * @param {Array} arrayElement - ['#id','.class'].
     * @param {string} nameClass - tên của class cần xóa bỏ.
     * @example 
     * jfpts.libs.deleteClassOfArrayElement(['#id','.class'],'b') <=> $('#id').removeClass('b');$('.class').removeClass('b')
     * @return {Array} - mảng mới sau khi đã xóa phần tử.
     */
    this.deleteClassOfArrayElement = function (arrayElement, nameClass) {
        if ($.isArray(arrayElement) && arrayElement.length > 0) {
            $.each(arrayElement, function (i, v) {
                $(v).removeClass(nameClass);
            });
        }
    };

    /**
     * @author Nghiatc2.
     * @description: Hàm thực hiện chức năng kiểm tra xem đang chạy trên trình duyệt mobile nào.
     * @example:
     * if (jfpts.libs.isRequestMobile().any()) {chạy code điện thoại}
     */
    this.isRequestMobile = function () {
        var isMobile = {};

        try {
            isMobile = {
                Android: function () {
                    return navigator.userAgent.match(/Android/i);
                },
                BlackBerry: function () {
                    return navigator.userAgent.match(/BlackBerry/i);
                },
                iOS: function () {
                    return navigator.userAgent.match(/iPhone|iPad|iPod/i);
                },
                Opera: function () {
                    return navigator.userAgent.match(/Opera Mini/i);
                },
                Windows: function () {
                    return navigator.userAgent.match(/IEMobile/i);
                },
                any: function () {
                    return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
                }
            };

            return isMobile;

        } catch (err) {
            return isMobile;
        }
    };

    /**
     * @author Nghiatc2.
     * @description: Kiểm tra số di động có đúng định dạng(10-11 số).
     * @param phone
     * @example:
     * if (jfpts.libs.isValidPhone()) {Đúng định dạng}
     * @return {boolean}
     */
    this.isValidatePhone = function (phone) {

        var regex = /^0[0-9]{9,10}$/;

        if (phone.match(regex)) {
            return true;
        } else {
            return false;
        }
    };

    /**
     * @author Nghiatc2.
     * @description: Xóa toàn bộ khoảng trắng trong chuỗi.
     * @example:jfpts.libs.removeSpace('a b c 9 c') => 'abc9c'
     * @return {boolean}
     */
    this.removeSpace = function (string) {
        var newString = string;
        if ($.trim(newString).length > 0) {
            newString = newString.replace(/\s/igm, '');
        }
        return newString;
    };

    /**
     * @author Nghiatc2.
     * @function shuffleArray.
     * @decription Hàm nhận vào một mảng và xáo trộn mảng một cách ngẫu nhiên.
     * @param [array] array chứa các danh sách cần xáo trộn.
     * @return array mảng đã được xáo trộn một cách ngẫu nhiên.
     * @example.
     * var arrayExam = [1,2,3,4,5];
     * arrayExam = jfpts.libs.shuffle(arrayExam);
     */
    this.shuffleArray = function (array) {
        var i = array.length,
            j = 0,
            temp;

        while (i--) {
            j = Math.floor(Math.random() * (i + 1));

            temp = array[i];
            array[i] = array[j];
            array[j] = temp;
        }
        return array;
    };

    /**
     * @author Không rõ.
     * @description Chuyển chuỗi string sang dạng name ascii.
     * @param {string} Chuỗi cần chuyển đổi.
     * @return {string} chuỗi sau khi chuyển.
     * @example jfpts.libs.convertToAscii('web đẹp') = > web-dep
     */
    this.convertToAscii = function (str) {
        str = str.toLowerCase();
        str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
        str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
        str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
        str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
        str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
        str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
        str = str.replace(/đ/g, "d");
        str = str.replace(/!|@|\$|%|\^|\*|\(|\)|\+|\=|\<|\>|\?|\/|,|\.|\:|\'| |\"|\&|\#|\[|\]|~/g, "-");
        str = str.replace(/-+-/g, "-"); //thay thế 2- thành 1-
        str = str.replace(/^\-+|\-+$/g, "");//cắt bỏ ký tự - ở đầu và cuối chuỗi
        return str;
    };

    /**
     * @author Không rõ.
     * @description Chuyễn chuỗi có dấu sang không dấu.
     * @param {string} Chuỗi ký tự cần chuyển đổi.
     * @return {string} Chuỗi đã chuyển đổi.
     * @example jfpts.libs.removeVietnamese('web đẹp') = > web dep
     */
    this.removeVietnamese = function (str) {
        str = str.toLowerCase();
        str = str.replace(/à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ/g, "a");
        str = str.replace(/è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ/g, "e");
        str = str.replace(/ì|í|ị|ỉ|ĩ/g, "i");
        str = str.replace(/ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ/g, "o");
        str = str.replace(/ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ/g, "u");
        str = str.replace(/ỳ|ý|ỵ|ỷ|ỹ/g, "y");
        str = str.replace(/đ/g, "d");
        return str;
    };

    /**
    * @author Nghiatc2.
    * @function.
    * @description Chuẩn hóa chuỗi.
    * @param {string} chuỗi cần chuẩn hóa.
    * @example jfpts.libs.standardizedString('xin     chao') => xin chao
    */
    this.standardizedString = function (string) {
        var stringTemp = string,
            newValue = '';

        if (stringTemp !== '') {
            var arrStr = stringTemp.match(/\S+/g);

            $.each(arrStr, function (i, v) {
                newValue += $.trim(v) + ' ';
            });
        }

        return newValue
    };

    /**
     * @author Không rõ.
     * @description Lấy giá trị của query string.
     * @param {string} name - Tên của query string.
     * @return {string || null}
     */
    this.getURLParameter = function(name) {
        return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null;
    }

    /**
     * @author Không rõ.
     * @description Định dạng lại tiền tệ.
     * @param {string} str - số tiền cần định dạng lại.
     * @example 
     * th1 : jfpts.libs.formatPrice('3000000') => 3000.000
     * th2 : jfpts.libs.formatPrice(Math.round(20149772.328).toString()) => 20.149.772
     */
    this.formatPrice = function (str) {

        if (str == null) {
            return '0';
        }

        str = typeof str != 'string' ? str.toString() : parseFloat(str).toString();

        return str.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1.");
    };


}).apply(jfpts.libs);