var AT = {
    JET_LAG: 200, // 200 miniseconds
    cookie_domain: null,
    cookie_duration: 30, // 30 days

    check_scope: function () {
        var utm_source = this.get_utm_source() || this.get_param("utm_source");
        if (utm_source == "accesstrade")
            return true;
        return false;
    },


    init: function (settings) {
        this.cookie_domain = settings.cookie_domain || null;
        this.cookie_duration = settings.cookie_duration || 30;
    },

    track: function () {
        var sid = this.get_param("aff_sid");
        var utm_source = this.get_param("utm_source");
        if (utm_source == "accesstrade") {
            this.set_cookie("_aff_network", "accesstrade", this.cookie_duration);
            if (sid) {
                this.set_cookie("_aff_sid", sid, this.cookie_duration);
            }
        }

        if (this.check_scope()) {
            setTimeout(function () {
                AT.track_conversion();
            }, AT.JET_LAG);
        }
    },


    track_conversion: function () {
        var sid = this.get_session_id();
        if (sid === undefined || sid == null || sid.trim() === "") {
            console.log("[AT] There is no session id found");
            return false;
        }

        if (typeof at_order_info === "undefined") {
            return false;
        }

        console.log("[AT] Tracking conversion...");

        var y = JSON.stringify(accesstrade_order_info);
        var param = [];
        var contact = JSON.parse(y);
        var keys = Object.keys(contact);
        for (var key = 0; key < keys.length; key++) {
            if (keys[key] === "products") {
                var goods = contact[keys[key]];
                for (var i = 0; i < goods.length; i++) {
                    var goodsDetail = goods[i];
                    var goodsParam = goodsDetail.id + "." + goodsDetail.quantity + "." + goodsDetail.price;
                    delete goodsDetail.id;
                    delete goodsDetail.quantity;
                    delete goodsDetail.price;
                    for (var detailKeyNo = 0; detailKeyNo < Object.keys(goodsDetail).length; detailKeyNo++) {
                        var detailKey = Object.keys(goodsDetail)[detailKeyNo];
                        goodsParam += "." + detailKey + ":" + goodsDetail[detailKey];
                    }
                    param.push("goods=" + encodeURIComponent(goodsParam));
                }
            } else {
                param.push(keys[key] + "=" + encodeURIComponent(contact[keys[key]]));
            }
        }

        param.push("time=" + String((new Date).getTime()));
        var a = document.createElement("img");
        a.width = 1;
        a.height = 1;
        a.border = 0;
        a.src = "https://cv.accesstrade.vn/cv.php?" + param.join("&");
        console.log("[AT] Pixel tracking url: " + a.src);

        //var b = document.getElementsByTagName("script")[0];
        //b.parentNode.insertBefore(a,b);
        document.body.appendChild(a);
    },

    get_param: function (name, url) {
        if (!url) url = location.href;
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regexS = "[\\?&]" + name + "=([^&#]*)";
        var regex = new RegExp(regexS);
        var results = regex.exec(url);
        return results == null ? null : results[1];
    },

    set_cookie: function (n, v, e) {
        var d = new Date();
        d.setTime(d.getTime() + (e * 24 * 60 * 60 * 1000));
        var ee = "expires=" + d.toUTCString();
        cookie_domain = this.cookie_domain || window.location.hostname;
        document.cookie = n + "=" + v + "; " + ee + ";domain=" + cookie_domain + "; path=/";
    },

    get_cookie: function (cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') c = c.substring(1);
            if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
        }
        return undefined;
    },

    get_session_id: function () {
        return this.get_cookie('_aff_sid') || "";
    },

    get_utm_source: function () {
        return this.get_cookie('_aff_network') || "";
    },
}