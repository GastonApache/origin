export function Header({
  banner,
  children,
}: {
  banner?: string;
  children: React.ReactNode;
}) {
  const headerBgColor = getComputedStyle(document.documentElement).getPropertyValue('--headerBgColor').trim();
  const headerTextColor = getComputedStyle(document.documentElement).getPropertyValue('--headerTextColor').trim();
  
  return (
    <div
      className="menu-header flex items-center justify-center text-center h-headerHeight"
      style={{
        background: banner 
          ? `url('assets/banners/${banner}.png')`
          : headerBgColor || 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
        backgroundSize: 'cover',
        backgroundPosition: 'center',
        backgroundRepeat: 'no-repeat',
        color: headerTextColor || '#FFFFFF',
      }}>
      <div className="menu-header-text text-center text-header max-w-max truncate p-3">
        {!banner && children}
      </div>
    </div>
  );
}
