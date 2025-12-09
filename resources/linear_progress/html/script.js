// script.js : listen for NUI messages and draw a linear progress with label.
// Supports dynamic config and loading a custom font file.

(function() {
  const canvas = document.getElementById('progressBarCanvas');
  const ctx = canvas.getContext('2d');
  const container = document.getElementById('container');
  const percentLabel = document.getElementById('percentLabel');

  function resizeCanvas() {
    const ratio = window.devicePixelRatio || 1;
    const style = getComputedStyle(canvas);
    const w = parseFloat(style.width) || canvas.width || 300;
    const h = parseFloat(style.height) || canvas.height || 18;
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
  let cfg = {
    barColor: getComputedStyle(document.documentElement).getPropertyValue('--bar-color') || '#1976d2',
    bgColor: getComputedStyle(document.documentElement).getPropertyValue('--bg-color') || 'rgba(200,200,200,0.4)',
    textColor: getComputedStyle(document.documentElement).getPropertyValue('--text-color') || '#222',
    borderRadius: getComputedStyle(document.documentElement).getPropertyValue('--border-radius') || '10px',
    fontFamily: getComputedStyle(document.documentElement).getPropertyValue('--font-family') || 'sans-serif',
    fontWeight: getComputedStyle(document.documentElement).getPropertyValue('--font-weight') || '500',
    fontSizeScale: 0.9
  };

  // Font injection for custom font file
  let injectedFontRule = null;
  function injectFont(fontFile, familyName) {
    if (injectedFontRule) {
      if (injectedFontRule.parentNode) injectedFontRule.parentNode.removeChild(injectedFontRule);
      injectedFontRule = null;
    }
    if (!fontFile) return;
    const styleEl = document.createElement('style');
    styleEl.type = 'text/css';
    const fam = familyName || 'CustomNuiFont';
    styleEl.innerHTML = "@font-face { font-family: '" + fam + "'; src: url('" + fontFile + "'); font-weight: normal; font-style: normal; }";
    document.head.appendChild(styleEl);
    injectedFontRule = styleEl;
  }

  function draw(value) {
    const w = canvas.width / (window.devicePixelRatio || 1);
    const h = canvas.height / (window.devicePixelRatio || 1);
    const radius = parseFloat(getComputedStyle(document.documentElement).getPropertyValue('--border-radius')) || Math.min(h/2, 10);
    const barW = w;
    const barH = h;

    ctx.clearRect(0, 0, w, h);

    // background rounded rect
    ctx.fillStyle = cfg.bgColor || 'rgba(200,200,200,0.4)';
    roundRect(ctx, 0, 0, barW, barH, radius);
    ctx.fill();

    // filled part
    ctx.fillStyle = cfg.barColor || '#1976d2';
    const filledW = Math.max(0, (value/100) * barW);
    if (filledW > 0) {
      roundRect(ctx, 0, 0, filledW, barH, radius);
      ctx.fill();
    }

    // percentage label updated separately (DOM)
    if (percentLabel && cfg.showPercent) {
      percentLabel.textContent = Math.round(value) + '%';
      percentLabel.style.color = cfg.textColor || '#222';
      percentLabel.style.fontFamily = cfg.fontFamily || 'sans-serif';
      percentLabel.style.fontWeight = cfg.fontWeight || '500';
      const fontSize = Math.max(10, Math.round(barH * (cfg.fontSizeScale || 0.9)));
      percentLabel.style.fontSize = fontSize + 'px';
    }
  }

  // rounded rectangle helper
  function roundRect(ctx, x, y, width, height, radius) {
    const r = Math.min(radius, height/2, width/2);
    ctx.beginPath();
    ctx.moveTo(x + r, y);
    ctx.arcTo(x + width, y, x + width, y + height, r);
    ctx.arcTo(x + width, y + height, x, y + height, r);
    ctx.arcTo(x, y + height, x, y, r);
    ctx.arcTo(x, y, x + width, y, r);
    ctx.closePath();
  }

  function applyConfig(c) {
    if (!c) return;
    const root = document.documentElement;
    if (c.barColor) root.style.setProperty('--bar-color', c.barColor);
    if (c.bgColor) root.style.setProperty('--bg-color', c.bgColor);
    if (c.textColor) root.style.setProperty('--text-color', c.textColor);
    if (c.right) root.style.setProperty('--container-right', (typeof c.right === 'number') ? c.right + 'px' : c.right);
    if (c.left) {
      root.style.setProperty('--container-left', (typeof c.left === 'number') ? c.left + 'px' : c.left);
      root.style.setProperty('--container-right', 'auto');
    }
    if (c.top) root.style.setProperty('--container-top', (typeof c.top === 'number') ? c.top + 'px' : c.top);
    if (c.bottom) {
      root.style.setProperty('--container-bottom', (typeof c.bottom === 'number') ? c.bottom + 'px' : c.bottom);
      root.style.setProperty('--container-top', 'auto');
    }
    if (c.width) root.style.setProperty('--container-width', (typeof c.width === 'number') ? c.width + 'px' : c.width);
    if (c.height) root.style.setProperty('--container-height', (typeof c.height === 'number') ? c.height + 'px' : c.height);
    if (c.borderRadius) root.style.setProperty('--border-radius', c.borderRadius);
    if (c.percentSpacing) root.style.setProperty('--percent-spacing', (typeof c.percentSpacing === 'number') ? c.percentSpacing + 'px' : c.percentSpacing);
    if (c.zIndex) root.style.setProperty('--z-index', c.zIndex);

    // runtime cfg
    if (c.fontFamily) cfg.fontFamily = c.fontFamily;
    if (c.fontWeight) {
      cfg.fontWeight = c.fontWeight;
      root.style.setProperty('--font-weight', c.fontWeight);
    }
    if (c.fontSizeScale !== undefined) cfg.fontSizeScale = c.fontSizeScale;
    if (c.barColor) cfg.barColor = c.barColor;
    if (c.bgColor) cfg.bgColor = c.bgColor;
    if (c.textColor) cfg.textColor = c.textColor;
    if (typeof c.showPercent === 'boolean') cfg.showPercent = c.showPercent;

    // custom font
    if (c.fontFile) {
      const familyName = c.fontFamily || 'CustomNuiFont';
      injectFont(c.fontFile, familyName);
      cfg.fontFamily = familyName;
      root.style.setProperty('--font-family', familyName);
    }

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
        if (percentLabel) percentLabel.textContent = '';
      } else {
        draw(currentValue);
      }
    } else if (data.type === 'config') {
      applyConfig(data.config);
    }
  });

  // initial draw
  draw(currentValue);
})();