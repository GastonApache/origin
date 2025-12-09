// script.js : écoute les messages depuis client.lua et dessine la progression sur canvas
// Gère aussi le chargement dynamique d'une police custom envoyée via config.fontFile

(function() {
  const canvas = document.getElementById('progressCanvas');
  const ctx = canvas.getContext('2d');
  const container = document.getElementById('container');

  // DPI-aware resize based on computed style
  function resizeCanvas() {
    const ratio = window.devicePixelRatio || 1;
    const style = getComputedStyle(canvas);
    const w = parseFloat(style.width) || canvas.width;
    const h = parseFloat(style.height) || canvas.height;
    canvas.width = Math.max(1, Math.floor(w * ratio));
    canvas.height = Math.max(1, Math.floor(h * ratio));
    canvas.style.width = w + 'px';
    canvas.style.height = h + 'px';
    ctx.setTransform(ratio, 0, 0, ratio, 0, 0);
  }

  window.addEventListener('resize', resizeCanvas);
  resizeCanvas();

  let currentValue = 10;
  let visible = false;
  let showPercent = true;

  // Configurable runtime values (will be set via applyConfig)
  let cfg = {
    color: getComputedStyle(document.documentElement).getPropertyValue('--progress-color') || '#1976d2',
    bgColor: getComputedStyle(document.documentElement).getPropertyValue('--bg-color') || 'rgba(200,200,200,0.6)',
    textColor: getComputedStyle(document.documentElement).getPropertyValue('--text-color') || '#222',
    fontFamily: getComputedStyle(document.documentElement).getPropertyValue('--font-family') || 'sans-serif',
    fontWeight: getComputedStyle(document.documentElement).getPropertyValue('--font-weight') || 'normal',
    fontSizeScale: 0.8,
    lineWidthScale: 0.18
  };

  // Inject @font-face for a custom font file if provided
  let injectedFontRule = null;
  function injectFont(fontFile, familyName) {
    // remove previous rule if present
    if (injectedFontRule) {
      if (injectedFontRule.parentNode) injectedFontRule.parentNode.removeChild(injectedFontRule);
      injectedFontRule = null;
    }
    if (!fontFile) return;
    const styleEl = document.createElement('style');
    styleEl.type = 'text/css';
    // familyName should be a safe CSS identifier; if not provided, use 'CustomNuiFont'
    const fam = familyName || 'CustomNuiFont';
    // Use relative URL - the NUI will serve files listed in fxmanifest
    styleEl.innerHTML = "@font-face { font-family: '" + fam + "'; src: url('" + fontFile + "'); font-weight: normal; font-style: normal; }";
    document.head.appendChild(styleEl);
    injectedFontRule = styleEl;
  }

  function draw(value) {
    const ratio = window.devicePixelRatio || 1;
    const w = canvas.width / ratio;
    const h = canvas.height / ratio;
    const cx = w / 2;
    const cy = h / 2;
    const radius = Math.min(w, h) * 0.4;
    const lineWidth = Math.max(1, radius * (cfg.lineWidthScale || 0.18));

    ctx.clearRect(0, 0, w, h);

    // background ring
    ctx.beginPath();
    ctx.arc(cx, cy, radius, 0, 2 * Math.PI, false);
    ctx.lineWidth = lineWidth;
    ctx.strokeStyle = cfg.bgColor || 'rgba(200,200,200,0.6)';
    ctx.stroke();

    // progress arc
    const start = -Math.PI / 2; // top
    const end = start + (2 * Math.PI) * (value / 100);
    ctx.beginPath();
    ctx.arc(cx, cy, radius, start, end, false);
    ctx.lineWidth = lineWidth;
    ctx.lineCap = 'round';
    ctx.strokeStyle = cfg.color || '#1976d2';
    ctx.stroke();

    // percentage text
    if (showPercent) {
      const fontSize = Math.max(8, Math.round(radius * (cfg.fontSizeScale || 0.8)));
      ctx.font = (cfg.fontWeight ? (cfg.fontWeight + ' ') : '') + fontSize + 'px ' + (cfg.fontFamily || 'sans-serif');
      ctx.fillStyle = cfg.textColor || '#222';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      ctx.fillText(`${Math.round(value)}%`, cx, cy);
    }
  }

  // Apply config object coming from NUI
  function applyConfig(c) {
    if (!c) return;
    // update css variables for layout
    const root = document.documentElement;
    if (c.color) root.style.setProperty('--progress-color', c.color);
    if (c.bgColor) root.style.setProperty('--bg-color', c.bgColor);
    if (c.textColor) root.style.setProperty('--text-color', c.textColor);
    if (c.right) root.style.setProperty('--container-right', (typeof c.right === 'number') ? c.right + 'px' : c.right);
    if (c.left) {
      root.style.setProperty('--container-left', (typeof c.left === 'number') ? c.left + 'px' : c.left);
      // unset right when left set
      root.style.setProperty('--container-right', 'auto');
    }
    if (c.top) root.style.setProperty('--container-top', (typeof c.top === 'number') ? c.top + 'px' : c.top);
    if (c.bottom) {
      root.style.setProperty('--container-bottom', (typeof c.bottom === 'number') ? c.bottom + 'px' : c.bottom);
      root.style.setProperty('--container-top', 'auto');
    }
    if (c.width) root.style.setProperty('--container-width', (typeof c.width === 'number') ? c.width + 'px' : c.width);
    if (c.height) root.style.setProperty('--container-height', (typeof c.height === 'number') ? c.height + 'px' : c.height);
    if (c.zIndex) root.style.setProperty('--z-index', c.zIndex);

    // font and drawing settings stored in runtime cfg
    if (c.fontFamily) cfg.fontFamily = c.fontFamily;
    if (c.fontWeight) {
      cfg.fontWeight = c.fontWeight;
      root.style.setProperty('--font-weight', c.fontWeight);
    }
    if (c.fontSizeScale !== undefined) cfg.fontSizeScale = c.fontSizeScale;
    if (c.lineWidthScale !== undefined) cfg.lineWidthScale = c.lineWidthScale;
    if (c.color) cfg.color = c.color;
    if (c.bgColor) cfg.bgColor = c.bgColor;
    if (c.textColor) cfg.textColor = c.textColor;
    if (typeof c.showPercent === 'boolean') showPercent = c.showPercent;

    // If a font file is provided, inject @font-face and use provided family name (or CustomNuiFont)
    if (c.fontFile) {
      // fontFile should be relative to the html/ folder (e.g. 'fonts/MyFont.ttf')
      const familyName = c.fontFamily || 'CustomNuiFont';
      injectFont(c.fontFile, familyName);
      cfg.fontFamily = familyName;
      root.style.setProperty('--font-family', familyName);
    }

    // After changes, recompute size and redraw if visible
    resizeCanvas();
    if (visible) draw(currentValue);
  }

  // Listen messages from client.lua
  window.addEventListener('message', (event) => {
    const data = event.data;
    if (!data) return;
    if (data.type === 'progress') {
      currentValue = data.value;
      if (visible) draw(currentValue);
    } else if (data.type === 'ui') {
      visible = !!data.display;
      if (!visible) {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
      } else {
        draw(currentValue);
      }
    } else if (data.type === 'config') {
      applyConfig(data.config);
    }
  });

  // initial draw (not visible by default)
  draw(currentValue);
})();