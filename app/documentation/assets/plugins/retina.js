(function (a, b) {
  'object' == typeof exports && 'undefined' != typeof module ? (module.exports = b()) : 'function' == typeof define && define.amd ? define(b) : (a.retinajs = b());
})(this, function () {
  'use strict';
  function a(a) {
    return Array.prototype.slice.call(a);
  }
  function b(a) {
    var b = parseInt(a, 10);
    return k < b ? k : b;
  }
  function c(a) {
    return (
      a.hasAttribute('data-no-resize') ||
        (0 === a.offsetWidth && 0 === a.offsetHeight ? (a.setAttribute('width', a.naturalWidth), a.setAttribute('height', a.naturalHeight)) : (a.setAttribute('width', a.offsetWidth), a.setAttribute('height', a.offsetHeight))),
      a
    );
  }
  function d(a, b) {
    var d = a.nodeName.toLowerCase(),
      e = document.createElement('img');
    e.addEventListener('load', function () {
      'img' === d ? c(a).setAttribute('src', b) : (a.style.backgroundImage = 'url(' + b + ')');
    }),
      e.setAttribute('src', b),
      a.setAttribute(o, !0);
  }
  function e(a, c) {
    var e = 2 < arguments.length && void 0 !== arguments[2] ? arguments[2] : 1,
      f = b(e);
    if (c && 1 < f) {
      var g = c.replace(l, '@' + f + 'x$1');
      d(a, g);
    }
  }
  function f(a, b, c) {
    1 < k && d(a, c);
  }
  function g(b) {
    return b ? ('function' == typeof b.forEach ? b : a(b)) : 'undefined' == typeof document ? [] : a(document.querySelectorAll(n));
  }
  function h(a) {
    return a.style.backgroundImage.replace(m, '$2');
  }
  function i(a) {
    g(a).forEach(function (a) {
      if (!a.getAttribute(o)) {
        var b = 'img' === a.nodeName.toLowerCase(),
          c = b ? a.getAttribute('src') : h(a),
          d = a.getAttribute('data-rjs'),
          g = !isNaN(parseInt(d, 10));
        if (null === d) return;
        g ? e(a, c, d) : f(a, c, d);
      }
    });
  }
  var j = 'undefined' != typeof window,
    k = Math.round(j ? window.devicePixelRatio || 1 : 1),
    l = /(\.[A-z]{3,4}\/?(\?.*)?)$/,
    m = /url\(('|")?([^)'"]+)('|")?\)/i,
    n = '[data-rjs]',
    o = 'data-rjs-processed';
  return (
    j &&
      (window.addEventListener('load', function () {
        i();
      }),
      (window.retinajs = i)),
    i
  );
});
//# sourceMappingURL=retina.min.js.map
