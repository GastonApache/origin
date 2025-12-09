// Configuration dynamique RageMenu
interface RageMenuConfig {
  HeaderBackgroundColor: string;
  HeaderTextColor: string;
  HeaderGlowEffect: boolean;
  NavigationBackgroundColor: string;
  NavigationTextColor: string;
  NavigationUseGradient: boolean;
  ItemBackgroundColor: string;
  ItemTextColor: string;
  ItemHoverOpacity: number;
  DescriptionBackgroundColor: string;
  DescriptionTextColor: string;
  DescriptionBorderColor: string;
  SliderBackgroundColor: string;
  SliderProgressColor: string;
  SliderHeight: string;
  CheckboxCheckedColor: string;
  CheckboxUncheckedColor: string;
  CheckIconColor: string;
  CheckIconSize: string;
  CheckIconGlow: boolean;
  CheckIconAnimation: boolean;
  SidePanelBackgroundColor: string;
  SidePanelTextColor: string;
  SidePanelAlternateRowColor: string;
  MenuWidth: string;
  ItemHeight: string;
  HeaderHeight: string;
  FontSize: string;
  EnableAnimations: boolean;
  AnimationSpeed: string;
  EnableShadows: boolean;
  EnableBlur: boolean;
  BorderRadius: string;
  BackgroundGradient: string;
  UseGradientImage: boolean;
  HeaderFont: string;
  MenuFont: string;
  FontWeight: string;
  HeaderFontSize: string;
  ItemFontSize: string;
  EnableMaterialIcons: boolean;
  IconStyle: string;
  ActiveTheme?: string;
}

// Polices locales disponibles (déjà chargées dans index.scss)
const LOCAL_FONTS = ['RageUI', 'SignPainter'];

// Charger les polices Google Fonts dynamiquement
function loadGoogleFont(fontName: string) {
  // Ne pas charger les polices locales depuis Google Fonts
  if (LOCAL_FONTS.includes(fontName)) {
    return;
  }
  
  const fontLink = document.createElement('link');
  fontLink.href = `https://fonts.googleapis.com/css2?family=${fontName.replace(/ /g, '+')}:wght@300;400;500;700&display=swap`;
  fontLink.rel = 'stylesheet';
  
  // Vérifier si la police n'est pas déjà chargée
  const existingLink = document.querySelector(`link[href*="${fontName.replace(/ /g, '+')}"]`);
  if (!existingLink) {
    document.head.appendChild(fontLink);
  }
}

export function applyRageMenuConfig(config: RageMenuConfig) {
  const root = document.documentElement;

  // Charger les polices Google Fonts (les polices locales sont déjà chargées)
  if (config.HeaderFont) {
    loadGoogleFont(config.HeaderFont);
  }
  if (config.MenuFont && config.MenuFont !== config.HeaderFont) {
    loadGoogleFont(config.MenuFont);
  }

  // Appliquer les couleurs via CSS Variables
  root.style.setProperty('--headerBgColor', config.HeaderBackgroundColor);
  root.style.setProperty('--headerTextColor', config.HeaderTextColor);
  root.style.setProperty('--navBgColor', config.NavigationBackgroundColor);
  root.style.setProperty('--navTextColor', config.NavigationTextColor);
  root.style.setProperty('--itemBgColor', config.ItemBackgroundColor);
  root.style.setProperty('--itemTextColor', config.ItemTextColor);
  root.style.setProperty('--descBgColor', config.DescriptionBackgroundColor);
  root.style.setProperty('--descTextColor', config.DescriptionTextColor);
  root.style.setProperty('--descBorderColor', config.DescriptionBorderColor);
  root.style.setProperty('--sliderBgColor', config.SliderBackgroundColor);
  root.style.setProperty('--sliderProgressColor', config.SliderProgressColor);
  root.style.setProperty('--sliderHeight', config.SliderHeight);
  root.style.setProperty('--checkIconColor', config.CheckIconColor);
  root.style.setProperty('--checkIconSize', config.CheckIconSize);
  root.style.setProperty('--sidepanelBgColor', config.SidePanelBackgroundColor);
  root.style.setProperty('--sidepanelTextColor', config.SidePanelTextColor);
  root.style.setProperty('--sidepanelAltColor', config.SidePanelAlternateRowColor);
  root.style.setProperty('--menuWidth', config.MenuWidth);
  root.style.setProperty('--itemHeight', config.ItemHeight);
  root.style.setProperty('--headerHeight', config.HeaderHeight);
  root.style.setProperty('--fontSize', config.ItemFontSize || config.FontSize);
  root.style.setProperty('--animationSpeed', config.AnimationSpeed);
  root.style.setProperty('--borderRadius', config.BorderRadius);
  
  // Background gradient
  root.style.setProperty('--backgroundGradient', config.BackgroundGradient);
  
  // Polices
  root.style.setProperty('--headerFont', config.HeaderFont || 'Bebas Neue');
  root.style.setProperty('--menuFont', config.MenuFont || 'Roboto');
  root.style.setProperty('--fontWeight', config.FontWeight || '400');
  root.style.setProperty('--headerFontSize', config.HeaderFontSize || '5vh');

  // Gestion des effets
  root.style.setProperty('--checkGlow', config.CheckIconGlow 
    ? `drop-shadow(0 0 0.5vh ${config.CheckIconColor}80)` 
    : 'none'
  );
  
  root.style.setProperty('--checkAnimation', config.CheckIconAnimation 
    ? 'checkPop 0.3s ease-in-out' 
    : 'none'
  );

  root.style.setProperty('--itemHoverOpacity', config.ItemHoverOpacity.toString());

  // Configuration appliquée silencieusement
  // Décommentez ci-dessous pour voir les logs:
  /*
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('  RageMenu - Configuration Appliquée  ');
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  console.log('Thème: ' + (config.ActiveTheme || 'Personnalisé'));
  console.log('Police Header: ' + config.HeaderFont);
  console.log('Police Menu: ' + config.MenuFont);
  console.log('Navigation: ' + config.NavigationBackgroundColor);
  console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  */
}
