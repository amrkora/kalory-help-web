// Theme toggle (init is in inline <head> script to prevent FOUC)
(function () {
  var toggle = document.querySelector('.theme-toggle');
  if (!toggle) return;

  toggle.addEventListener('click', function () {
    var attr = document.documentElement.getAttribute('data-theme');
    var isDark;
    if (attr === 'dark') isDark = true;
    else if (attr === 'light') isDark = false;
    else isDark = window.matchMedia('(prefers-color-scheme: dark)').matches;

    var next = isDark ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    try { localStorage.setItem('theme', next); } catch (e) {}
  });

  // Sync if OS preference changes mid-session (only when no explicit choice)
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', function () {
    if (!document.documentElement.getAttribute('data-theme')) return;
    var saved;
    try { saved = localStorage.getItem('theme'); } catch (e) {}
    if (!saved) document.documentElement.removeAttribute('data-theme');
  });
})();

// Navbar scroll effect (throttled with rAF)
(function () {
  var navbar = document.querySelector('.navbar');
  if (!navbar) return;
  var ticking = false;
  window.addEventListener('scroll', function () {
    if (!ticking) {
      requestAnimationFrame(function () {
        navbar.classList.toggle('scrolled', window.scrollY > 20);
        ticking = false;
      });
      ticking = true;
    }
  });
})();

// Mobile hamburger menu
(function () {
  var hamburger = document.querySelector('.hamburger');
  var navLinks = document.querySelector('.nav-links');
  if (!hamburger || !navLinks) return;

  function closeMenu() {
    hamburger.classList.remove('open');
    navLinks.classList.remove('open');
    hamburger.setAttribute('aria-expanded', 'false');
  }

  hamburger.addEventListener('click', function () {
    var isOpen = hamburger.classList.toggle('open');
    navLinks.classList.toggle('open');
    hamburger.setAttribute('aria-expanded', String(isOpen));
  });

  // Close menu on link click
  navLinks.querySelectorAll('a').forEach(function (link) {
    link.addEventListener('click', closeMenu);
  });

  // Close on ESC key
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && navLinks.classList.contains('open')) closeMenu();
  });

  // Close on click outside
  document.addEventListener('click', function (e) {
    if (navLinks.classList.contains('open') && !navLinks.contains(e.target) && !hamburger.contains(e.target)) {
      closeMenu();
    }
  });
})();

// Scroll animations (fade-in, fade-in-left, fade-in-right, scale-in)
(function () {
  var animatedElements = document.querySelectorAll('.fade-in, .fade-in-left, .fade-in-right, .scale-in');
  if (!animatedElements.length) return;

  var scrollObserver = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          scrollObserver.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.1 }
  );

  animatedElements.forEach(function (el) { scrollObserver.observe(el); });
})();

// Chart bar animation (triggered on scroll)
(function () {
  var chartBars = document.querySelectorAll('.chart-bar');
  if (!chartBars.length) return;

  var chartObserver = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (entry.isIntersecting) {
          entry.target.classList.add('visible');
          chartObserver.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.3 }
  );

  chartBars.forEach(function (bar) { chartObserver.observe(bar); });
})();

// Stat counter animation
(function () {
  var statNumbers = document.querySelectorAll('.stat-number[data-target]');
  if (!statNumbers.length) return;

  var prefersReduced = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  var counterObserver = new IntersectionObserver(
    function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) return;

        var el = entry.target;
        var target = parseInt(el.dataset.target, 10);
        var suffix = el.dataset.suffix || '';

        if (isNaN(target)) return;

        if (prefersReduced) {
          el.textContent = target + suffix;
          counterObserver.unobserve(el);
          return;
        }

        var duration = 1500;
        var start = performance.now();

        function animate(now) {
          var elapsed = now - start;
          var progress = Math.min(elapsed / duration, 1);
          var eased = 1 - Math.pow(1 - progress, 3);
          el.textContent = Math.round(target * eased) + suffix;
          if (progress < 1) requestAnimationFrame(animate);
        }

        requestAnimationFrame(animate);
        counterObserver.unobserve(el);
      });
    },
    { threshold: 0.5 }
  );

  statNumbers.forEach(function (el) { counterObserver.observe(el); });
})();

// FAQ accordion
(function () {
  var faqButtons = document.querySelectorAll('.faq-question');
  if (!faqButtons.length) return;

  faqButtons.forEach(function (btn) {
    btn.addEventListener('click', function () {
      var item = btn.parentElement;
      var answer = item.querySelector('.faq-answer');
      var isOpen = item.classList.contains('open');

      // Close all
      document.querySelectorAll('.faq-item').forEach(function (i) {
        i.classList.remove('open');
        i.querySelector('.faq-question').setAttribute('aria-expanded', 'false');
        i.querySelector('.faq-answer').style.maxHeight = null;
      });

      // Open clicked (if it was closed)
      if (!isOpen) {
        item.classList.add('open');
        btn.setAttribute('aria-expanded', 'true');
        answer.style.maxHeight = answer.scrollHeight + 'px';
      }
    });
  });
})();
