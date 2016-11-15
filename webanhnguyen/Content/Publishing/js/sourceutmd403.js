if (window.location.href.indexOf("masoffer") > 0) {
    if (getQueryParams("utm_source") != null) {
        utm_createCookie("srf_b686d28583fc", getQueryParams("utm_source") + "/#" + getQueryParams("traffic_id"), 30);
    }
   
}
else {
	var  beginSRF=$.cookie('srf_b686d28583fc');
    if (getQueryParams("utm_source") != null) {
	
        utm_createCookie("srf_b686d28583fc", beginSRF +"/#"+ getQueryParams("utm_source") + "/#" + getQueryParams("utm_campaign"), 7);
    }
    else {
        if (document.referrer != "" && document.referrer.indexOf("fptshop.com.vn") < 0) {
            utm_createCookie("srf_b686d28583fc",beginSRF +"/#"+ document.referrer, 7);
        }
    }
}

function getQueryParams(name) {
    return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null;
}

function utm_createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    }
    else var expires = "";

    document.cookie = name + "=" + value + expires + "; path=/";
}

function utm_readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function utm_eraseCookie(name) {
    createCookie(name, "", -1);
}