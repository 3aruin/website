/* ═════════════════════════════════════════════════════════════════
   WORKING FILE — theme toggle handler
   - data-theme set pre-paint by an inline script in each page's <head>
     (defaulting to system preference, falling back to DARK if no
     preference is detected).
   - This file: binds the click handler, mirrors data-theme into
     aria-pressed on the toggle button so screen readers announce
     state, and follows system-preference changes when the user
     hasn't made an explicit choice.
   ═════════════════════════════════════════════════════════════════ */
(function () {
  const root = document.documentElement;
  const btn = document.getElementById('themeToggle');

  function syncPressed() {
    if (!btn) return;
    const isDark = root.getAttribute('data-theme') === 'dark';
    btn.setAttribute('aria-pressed', isDark ? 'true' : 'false');
  }

  // Initial sync — runs after pre-paint inline script has set data-theme.
  syncPressed();

  if (btn) {
    btn.addEventListener('click', function () {
      const next = root.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      root.setAttribute('data-theme', next);
      try { localStorage.setItem('theme', next); } catch (e) {}
      syncPressed();
    });
  }

  // Follow system preference changes — only when the user hasn't
  // explicitly set a theme. Mirrors the dark-default init logic:
  // explicit "prefers light" → light; everything else → dark.
  if (window.matchMedia) {
    const lightMQ = window.matchMedia('(prefers-color-scheme: light)');
    function followSystem() {
      try {
        if (localStorage.getItem('theme')) return;
      } catch (e) { /* localStorage blocked — fall through */ }
      root.setAttribute('data-theme', lightMQ.matches ? 'light' : 'dark');
      syncPressed();
    }
    if (lightMQ.addEventListener) {
      lightMQ.addEventListener('change', followSystem);
    } else if (lightMQ.addListener) {
      lightMQ.addListener(followSystem); // Safari < 14
    }
  }
})();
