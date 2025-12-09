import React from 'react';
import ReactDOM from 'react-dom/client';
import { VisibilityProvider } from './providers/VisibilityProvider.tsx';
import { applyRageMenuConfig } from './utils/configManager.ts';
import './css/variables.scss';
import './css/index.scss';

// Écouter les configs envoyées depuis Lua
window.addEventListener('message', (event) => {
  if (event.data.action === 'setConfig') {
    applyRageMenuConfig(event.data.data);
  }
});

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <VisibilityProvider />
  </React.StrictMode>
);
