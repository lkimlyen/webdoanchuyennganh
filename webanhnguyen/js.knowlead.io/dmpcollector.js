/*
 Copyright 2014 GoDataDriven B.V.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/
'use strict';(function(h){function C(d,a){var c;if(d){c=N();var e=g.referrer,b=(new Date).getTime(),e={p:u,s:v,v:w,e:c,c:b,n:q?"t":"f",f:x?"t":"f",l:h.location.href,r:e?e:void 0,i:D,j:E,k:h.devicePixelRatio,w:K(),h:L(),t:d,d:F(),z:G()},k="",f={},y=function(a,b){0<k.length&&(k+="\x26");var c=f[a];"undefined"===typeof c&&(c=[],f[a]=c);c.push(b);k+=a+"\x3d"+encodeURIComponent(b)},l;for(l in e)if(e.hasOwnProperty(l)){var m=e[l];switch(typeof m){case "undefined":break;case "number":y(l,m.toString(36));
break;default:y(l,m)}}"undefined"!==typeof a&&y("u",O(a));x=q=!1;M("_dvs",v,1800,b);M("_dvp",u,63072E3,b);y("x",P(f).toString(36));Q.g(k)}else c=void 0;return c}function P(d){var a=[],c;for(c in d)d.hasOwnProperty(c)&&a.push(c);a.sort();c="";for(var e=0;e<a.length;++e){var b=a[e],k=d[b];c+=b;c+="\x3d";for(b=0;b<k.length;++b)c+=k[b],c+=",";c+=";"}return R(unescape(encodeURIComponent(c)))}function H(){this.a=[]}function M(d,a,c,e){d=d+"\x3d"+a+"; path\x3d/; expires\x3d"+(new Date(e+1E3*c)).toUTCString()+
"; max-age\x3d"+c;g.cookie=d+"; domain\x3djs.knowlead.io"}function I(d){return g.cookie.replace(new RegExp("(?:(?:^|.*;)\\s*"+d+"\\s*\\\x3d\\s*([^;]*).*$)|^.*$"),"$1")||null}function G(){if(void 0==h._klCookies||null==h._klCookies)return null;var d,a,c=h._klCookies,e=[];d=0;for(a=c.length;d<a;++d)e.push(c[d]+":"+I(c[d]));return e.toString()}function F(){return void 0==h._klDmp||null==h._klDmp?null:h._klDmp}function L(){return h.innerHeight||g.documentElement.clientHeight||n().clientHeight||g.documentElement.offsetHeight||
n().offsetHeight}function K(){return h.innerWidth||g.documentElement.clientWidth||n().clientWidth||g.documentElement.offsetWidth||n().offsetWidth}function n(){return g.body||g.getElementsByTagName("body").item(0)}var g=h.document,z=h.navigator,r=function(){function d(){throw"Knowlead could not initialize itself.";}var a=g.currentScript,c;if("undefined"===typeof a)for(var a=g.getElementsByTagName("script"),e=new RegExp("^(:?.*/)?"+"dmpcollector.js".replace(/[.*+?^${}()|[\]\\]/g,"\\$\x26")+"(:?[?#].*)?$"),
b=a.length-1;0<=b;--b){var k=a.item(b).src;e.test(k)&&("undefined"==typeof c?c=k:d())}else c=a.src;"undefined"===typeof c&&d();return c}(),S=r.substr(0,1+r.lastIndexOf("/")),D=h.screen.availWidth,E=h.screen.availHeight,T=function(){var d=[0,10,20,5,15,16,1,11,21,6,7,17,2,12,22,23,8,18,3,13,14,24,9,19,4],a=[1,32898,32906,2147516416,32907,2147483649,2147516545,32777,138,136,2147516425,2147483658,2147516555,139,32905,32771,32770,128,32778,2147483658,2147516545,32896],c=[0,1,30,28,27,4,12,6,23,20,3,10,
11,25,7,9,13,15,21,8,18,2,29,24,14];return function(e){var b,k=[];for(b=0;25>b;b+=1)k[b]=0;if(15===e.length%16)e+="\u8001";else{for(e+="\u0001";15!==e.length%16;)e+="\x00";e+="\u8000"}for(var f=0;f<e.length;f+=16){for(b=0;16>b;b+=2)k[b/2]^=e.charCodeAt(f+b)+65536*e.charCodeAt(f+b+1);for(var h=0;22>h;h+=1){var l=[];for(b=0;5>b;b+=1)l[b]=k[b]^k[b+5]^k[b+10]^k[b+15]^k[b+20];var m=[];for(b=0;5>b;b+=1){var A=l[(b+1)%5];m[b]=l[(b+4)%5]^(A<<1|A>>>31)}l=[];for(b=0;25>b;b+=1){var A=k[b]^m[b%5],g=c[b];l[d[b]]=
A<<g|A>>>32-g}for(b=0;5>b;b+=1)for(m=0;25>m;m+=5)k[m+b]=l[m+b]^~l[m+(b+1)%5]&l[m+(b+2)%5];k[0]^=a[h]}}e=[];for(b=0;8>b;++b)f=k[b],e.push(f&255,f>>>8,f>>>16,f>>>24);return e}}(),R=function(){function d(a,c){var d=c&65535;return((c-d)*a|0)+(d*a|0)|0}return function(a,c){for(var e=a.length,b="undefined"!==typeof c?c:0,h=e&-4,f,g=0;g<h;g+=4)f=a.charCodeAt(g)&255|(a.charCodeAt(g+1)&255)<<8|(a.charCodeAt(g+2)&255)<<16|(a.charCodeAt(g+3)&255)<<24,f=d(f,3432918353),f=(f&131071)<<15|f>>>17,f=d(f,461845907),
b^=f,b=(b&524287)<<13|b>>>19,b=5*b+3864292196|0;f=0;switch(e%4){case 3:f=(a.charCodeAt(h+2)&255)<<16;case 2:f|=(a.charCodeAt(h+1)&255)<<8;case 1:f|=a.charCodeAt(h)&255,f=d(f,3432918353),f=d((f&131071)<<15|f>>>17,461845907),b^=f}e=b^e;e=d(e^e>>>16,2246822507);e^=e>>>13;e=d(e,3266489909);return b=e^=e>>>16}}(),J=function(){function d(){var a=K(),b=L(),c,d=z.mimeTypes;if(d){c="plugins:";for(var e=0,p=g.length;e<p;++e)c+=g[e]in d?"1":"0"}else c="";var d=z.userAgent||"",e=z.platform||"",p=z.language||
"",r=z.systemLanguage||"",t=z.userLanguage||"",u=D?D.toString(36):"",v=E?E.toString(36):"",w=a?a.toString(36):"",a=b?a.toString(36):"";if("ActiveXObject"in h)for(var b="activex:",q=0,x=f.length;q<x;++q){var y=f[q];try{var n=new ActiveXObject(y),b=b+"1";"getVersions"in n?b+="("+n.getVersions()+")":"getVariable"in n&&(b+="("+n.getVariable("$version")+")")}catch(B){b+="0"}}else b="";return[d,e,p,r,t,u,v,w,a,c,b,F(),G()]}var a=Math,c=h.crypto||h.msCrypto,e="undefined"!==typeof c&&"undefined"!==typeof c.getRandomValues,
b=e?function(a){a=new Uint8Array(a);c.getRandomValues(a);return a}:function(b){for(var c=Array(b),d=0;d<b;++d)c[d]=a.floor(256*a.random());return c},g="application/pdf video/quicktime video/x-msvideo audio/x-pn-realaudio-plugin audio/mpeg3 application/googletalk application/x-mplayer2 application/x-director application/x-shockwave-flash application/x-java-vm application/x-googlegears application/x-silverlight".split(" "),f=["ShockwaveFlash.ShockwaveFlash.1","AcroPDF.PDF","AgControl.AgControl","QuickTime.QuickTime"],
p=(new Date).getTime();return function(a){var c;c=(new Date).getTime().toString(36);for(var f=h.location.href||"",g=b(32),k="",n=0;n<g.length;++n)k+=String.fromCharCode(g[n]);c=[c,f,k];e||c.push.apply(c,d());c=T(c.join(""));f="";g=0;for(k=c.length;g<k;++g)f+="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxzy0123456789~_".charAt(c[g]&63);e||(f+="!");c=f;return"0:"+(a?p.toString(36)+":"+c:c)}}(),u=I("_dvp"),v=I("_dvs"),w=function(d){var a=d.indexOf("#");d=-1!==a?d.substring(a+1):null;if(null!==d&&
-1!==d.indexOf("/"))throw"DVT not initialized correctly; page view ID may not contain a slash ('/').";return d}(r),q=!u,x=!v,r=Boolean(w);q&&(u=J(!0));x&&(v=J(!0));r||(w=J(!1));var N=function(){var d=0;return function(){var a=d++;return w+a.toString(16)}}();H.prototype.g=function(d){var a=this.a;a.push(d);1==a.length&&this.b()};H.prototype.b=function(){var d=this,a=new Image(1,1);a.onload=function(){var a=d.a;a.shift();0<a.length&&d.b()};a.src=S+"csc-event?"+this.a[0]};var Q=new H,O=function(){function d(){this.a=
"";this.g=null}d.prototype.F=function(){this.b("(")};d.prototype.B=function(){this.b(")")};d.prototype.D=function(){this.b("a")};d.prototype.A=function(){this.b(".")};d.prototype.C=function(a){this.g=a};d.prototype.b=function(a,c){this.a+=a;null!==this.g&&(this.a+=d.a(this.g),this.a+="!",this.g=null);c&&(this.a+=c)};d.a=function(){var a=/~!/g;return function(c){return c.replace(a,"~$\x26")}}();d.prototype.u=function(a){this.b("s",d.a(a)+"!")};d.prototype.o=function(a){if(isFinite(a)){var c=a===Math.floor(a)?
a.toString(36):null,d=a.toExponential();a=String(a);null!=c&&c.length<=d.length&&c.length<=a.length?this.b("d",c+"!"):this.b("j",(d.length<a.length?d:a)+"!")}else this.encode(null)};d.prototype.H=function(a){this.b(a?"t":"f")};d.prototype.m=function(){this.b("n")};d.prototype.G=function(a){this.D();for(var c=0;c<a.length;++c)this.encode(a[c]);this.A()};d.prototype.I=function(){function a(a,d){for(var b=d.toString();b.length<a;)b="0"+b;return b}return function(c){this.encode(isFinite(c.valueOf())?
c.getUTCFullYear()+"-"+a(2,c.getUTCMonth()+1)+"-"+a(2,c.getUTCDate())+"T"+a(2,c.getUTCHours())+":"+a(2,c.getUTCMinutes())+":"+a(2,c.getUTCSeconds())+"."+a(3,c.getUTCMilliseconds())+"Z":null)}}();d.prototype.J=function(a){this.F();for(var c in a)Object.prototype.hasOwnProperty.call(a,c)&&(this.C(c),this.encode(a[c]));this.B()};d.prototype.q=function(a){if(null===a)this.m();else if("function"===typeof a.toJSON)this.encode(a.toJSON());else switch(Object.prototype.toString.call(a)){case "[object Array]":this.G(a);
break;case "[object Date]":this.I(a);break;default:this.J(a)}};d.prototype.encode=function(a){switch(typeof a){case "string":this.u(a);break;case "number":this.o(a);break;case "boolean":this.H(a);break;case "object":this.q(a);break;default:throw"Cannot encode of type: "+typeof a;}};d.b=function(a){var c=new d;c.encode(a);return c.a};return d.b}(),B={partyId:u,sessionId:v,pageViewId:w,isNewPartyId:q,isFirstInSession:x,isServerPageView:r,signal:C,klDmp:F(),klCookies:void 0==h._klCookies||null==h._klCookies?
null:h._klCookies,getAllCookiesForMapping:G()};if("object"!==typeof h.knowlead){"function"===typeof h.define&&h.define.amd?h.define(function(){return B}):"undefined"!==typeof h.module&&h.module.exports?h.module.exports=B:h.knowlead=B;var p,t="none";"undefined"!==typeof g.hidden?(p="hidden",t="visibilitychange"):"undefined"!==typeof g.mozHidden?(p="mozHidden",t="mozvisibilitychange"):"undefined"!==typeof g.msHidden?(p="msHidden",t="msvisibilitychange"):"undefined"!==typeof g.webkitHidden&&(p="webkitHidden",
t="webkitvisibilitychange");"undefined"!==typeof p&&g[p]?g.addEventListener(t,function a(){!1===g[p]&&(C("pageView"),g.removeEventListener(t,a))}):C("pageView")}return B})("undefined"!==typeof window?window:this);