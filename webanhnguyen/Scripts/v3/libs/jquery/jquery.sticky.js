/* Sticky Plugin v1.0.0 for jQuery
 =============
 Author: Anthony Garand
 Improvements by German M. Bravo (Kronuz) and Ruud Kamphuis (ruudk)
 Improvements by Leonardo C. Daronco (daronco)
 Created: 2/14/2011
 Date: 2/12/2012
 Website: http://labs.anthonygarand.com/sticky
 Description: Makes an element on the page stick on the screen as you scroll
       It will only set the 'top' and 'position' of your element, you
       might need to adjust the width in some cases.*/

(function($) {
  var defaults = {
      topSpacing: 0,
      bottomSpacing: 0,
      className: 'is-sticky',
      wrapperClassName: 'sticky-wrapper',
      center: false,
      getWidthFrom: '',
      responsiveWidth: false
    },
    $window = $(window),
    $document = $(document),
    sticked = [],
    windowHeight = $window.height(),
    scroller = function() {
      var scrollTop = $window.scrollTop(),
        documentHeight = $document.height(),
        dwh = documentHeight - windowHeight,
        extra = (scrollTop > dwh) ? dwh - scrollTop : 0;

      for (var i = 0; i < sticked.length; i++) {
        var s = sticked[i],
          elementTop = s.stickyWrapper.offset().top,
          etse = elementTop - s.topSpacing - extra;

        if (scrollTop <= etse) {
          if (s.currentTop !== null) {
            s.stickyElement
              .css('width', '')
              .css('position', '')
              .css('top', '');
            s.stickyElement.trigger('sticky-end', [s]).parent().removeClass(s.className);
            s.currentTop = null;
          }
        }
        else {
          var newTop = documentHeight - s.stickyElement.outerHeight()
            - s.topSpacing - s.bottomSpacing - scrollTop - extra;
          if (newTop < 0) {
            newTop = newTop + s.topSpacing;
          } else {
            newTop = s.topSpacing;
          }
          if (s.currentTop != newTop) {
            s.stickyElement
              .css('width', s.stickyElement.width())
              .css('position', 'fixed')
              .css('top', newTop);

            if (typeof s.getWidthFrom !== 'undefined') {
              s.stickyElement.css('width', $(s.getWidthFrom).width());
            }

            s.stickyElement.trigger('sticky-start', [s]).parent().addClass(s.className);
            s.currentTop = newTop;
          }
        }
      }
    },
    resizer = function() {
      windowHeight = $window.height();

      for (var i = 0; i < sticked.length; i++) {
          var s = sticked[i];
        if (typeof s.getWidthFrom !== 'undefined' && s.responsiveWidth === true) {
          s.stickyElement.css('width', $(s.getWidthFrom).width());
        }
      }
    },
    methods = {
      init: function(options) {
        var o = $.extend({}, defaults, options);
        return this.each(function() {
          var stickyElement = $(this);

          var stickyId = stickyElement.attr('id');
          var wrapperId = stickyId ? stickyId + '-' + defaults.wrapperClassName : defaults.wrapperClassName 
          var wrapper = $('<div></div>')
            .attr('id', stickyId + '-sticky-wrapper')
            .addClass(o.wrapperClassName);
          stickyElement.wrapAll(wrapper);

          if (o.center) {
            stickyElement.parent().css({width:stickyElement.outerWidth(),marginLeft:"auto",marginRight:"auto"});
          }

          if (stickyElement.css("float") == "right") {
            stickyElement.css({"float":"none"}).parent().css({"float":"right"});
          }

          var stickyWrapper = stickyElement.parent();
          stickyWrapper.css('height', stickyElement.outerHeight());
          sticked.push({
            topSpacing: o.topSpacing,
            bottomSpacing: o.bottomSpacing,
            stickyElement: stickyElement,
            currentTop: null,
            stickyWrapper: stickyWrapper,
            className: o.className,
            getWidthFrom: o.getWidthFrom,
            responsiveWidth: o.responsiveWidth
          });
        });
      },
      update: scroller,
      unstick: function(options) {
        return this.each(function() {
          var unstickyElement = $(this);

          var removeIdx = -1;
          for (var i = 0; i < sticked.length; i++)
          {
            if (sticked[i].stickyElement.get(0) == unstickyElement.get(0))
            {
                removeIdx = i;
            }
          }
          if(removeIdx != -1)
          {
            sticked.splice(removeIdx,1);
            unstickyElement.unwrap();
            unstickyElement.removeAttr('style');
          }
        });
      }
    };

  /* should be more efficient than using $window.scroll(scroller) and $window.resize(resizer):*/
  if (window.addEventListener) {
    window.addEventListener('scroll', scroller, false);
    window.addEventListener('resize', resizer, false);
  } else if (window.attachEvent) {
    window.attachEvent('onscroll', scroller);
    window.attachEvent('onresize', resizer);
  }

  $.fn.sticky = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.sticky');
    }
  };

  $.fn.unstick = function(method) {
    if (methods[method]) {
      return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
    } else if (typeof method === 'object' || !method ) {
      return methods.unstick.apply( this, arguments );
    } else {
      $.error('Method ' + method + ' does not exist on jQuery.sticky');
    }

  };
  $(function() {
    setTimeout(scroller, 0);
  });
})(jQuery);


/*
 Sticky-kit v1.1.1 | WTFPL | Leaf Corcoran 2014 | http://leafo.net
*/
(function () {
    var k, e; k = this.jQuery || window.jQuery; e = k(window); k.fn.stick_in_parent = function (d) {
        var v, y, n, p, h, C, s, G, q, H; null == d && (d = {}); s = d.sticky_class; y = d.inner_scrolling; C = d.recalc_every; h = d.parent; p = d.offset_top; n = d.spacer; v = d.bottoming; null == p && (p = 0); null == h && (h = void 0); null == y && (y = !0); null == s && (s = "is_stuck"); null == v && (v = !0); G = function (a, d, q, z, D, t, r, E) {
            var u, F, m, A, c, f, B, w, x, g, b; if (!a.data("sticky_kit")) {
                a.data("sticky_kit", !0); f = a.parent(); null != h && (f = f.closest(h)); if (!f.length) throw "failed to find stick parent";
                u = m = !1; (g = null != n ? n && a.closest(n) : k("<div />")) && g.css("position", a.css("position")); B = function () {
                    var c, e, l; if (!E && (c = parseInt(f.css("border-top-width"), 10), e = parseInt(f.css("padding-top"), 10), d = parseInt(f.css("padding-bottom"), 10), q = f.offset().top + c + e, z = f.height(), m && (u = m = !1, null == n && (a.insertAfter(g), g.detach()), a.css({ position: "", top: "", width: "", bottom: "" }).removeClass(s), l = !0), D = a.offset().top - parseInt(a.css("margin-top"), 10) - p, t = a.outerHeight(!0), r = a.css("float"), g && g.css({
                        width: a.outerWidth(!0),
                        height: t, display: a.css("display"), "vertical-align": a.css("vertical-align"), "float": r
                    }), l)) return b()
                }; B(); if (t !== z) return A = void 0, c = p, x = C, b = function () {
                    var b, k, l, h; if (!E && (null != x && (--x, 0 >= x && (x = C, B())), l = e.scrollTop(), null != A && (k = l - A), A = l, m ? (v && (h = l + t + c > z + q, u && !h && (u = !1, a.css({ position: "fixed", bottom: "", top: c }).trigger("sticky_kit:unbottom"))), l < D && (m = !1, c = p, null == n && ("left" !== r && "right" !== r || a.insertAfter(g), g.detach()), b = { position: "", width: "", top: "" }, a.css(b).removeClass(s).trigger("sticky_kit:unstick")),
                    y && (b = e.height(), t + p > b && !u && (c -= k, c = Math.max(b - t, c), c = Math.min(p, c), m && a.css({ top: c + "px" })))) : l > D && (m = !0, b = { position: "fixed", top: c }, b.width = "border-box" === a.css("box-sizing") ? a.outerWidth() + "px" : a.width() + "px", a.css(b).addClass(s), null == n && (a.after(g), "left" !== r && "right" !== r || g.append(a)), a.trigger("sticky_kit:stick")), m && v && (null == h && (h = l + t + c > z + q), !u && h))) return u = !0, "static" === f.css("position") && f.css({ position: "relative" }), a.css({ position: "absolute", bottom: d, top: "auto" }).trigger("sticky_kit:bottom")
                },
                w = function () { B(); return b() }, F = function () { E = !0; e.off("touchmove", b); e.off("scroll", b); e.off("resize", w); k(document.body).off("sticky_kit:recalc", w); a.off("sticky_kit:detach", F); a.removeData("sticky_kit"); a.css({ position: "", bottom: "", top: "", width: "" }); f.position("position", ""); if (m) return null == n && ("left" !== r && "right" !== r || a.insertAfter(g), g.remove()), a.removeClass(s) }, e.on("touchmove", b), e.on("scroll", b), e.on("resize", w), k(document.body).on("sticky_kit:recalc", w), a.on("sticky_kit:detach", F), setTimeout(b,
                0)
            }
        }; q = 0; for (H = this.length; q < H; q++) d = this[q], G(k(d)); return this
    }
}).call(this);