import useKeyPress from '../../hooks/useKeyPress';
import type { ItemProps } from '../../types';
import { replaceColors } from '../../utilts';

interface ColorItem {
  color: string;
  name?: string;
}

export function ListColor({ item, selected, selectedItem, menuContext }: ItemProps) {
  if (!selectedItem) return null;
  const selectedClass = selected && 'selected text-selected';

  const getPrevious = (current: number, max: number) => {
    if (current === 0) return max;
    return current - 1;
  };

  const getNext = (current: number, max: number) => {
    if (current === max) return 0;
    return current + 1;
  };

  const handleLeft = () => {
    if (selectedItem.uuid !== item.uuid) return;
    menuContext.updateItem(selectedItem, {
      ...selectedItem,
      other: {
        ...selectedItem.other,
        current: getPrevious(
          selectedItem.other.current,
          selectedItem.other.items.length - 1
        ),
      },
    });
  };

  const handleRight = () => {
    if (selectedItem.uuid !== item.uuid) return;
    menuContext.updateItem(selectedItem, {
      ...selectedItem,
      other: {
        ...selectedItem.other,
        current: getNext(
          selectedItem.other.current,
          selectedItem.other.items.length - 1
        ),
      },
    });
  };

  useKeyPress('LEFT', handleLeft);
  useKeyPress('RIGHT', handleRight);

  // Afficher 5 cercles colorés maximum
  const maxVisibleItems = 5;
  const currentIndex = item.other.current;
  const items: ColorItem[] = item.other.items;
  
  // Calculer les indices de début et fin pour centrer l'élément sélectionné
  let startIndex = Math.max(0, currentIndex - Math.floor(maxVisibleItems / 2));
  const endIndex = Math.min(items.length, startIndex + maxVisibleItems);
  
  // Ajuster startIndex si on est près de la fin
  if (endIndex - startIndex < maxVisibleItems) {
    startIndex = Math.max(0, endIndex - maxVisibleItems);
  }

  const visibleItems = items.slice(startIndex, endIndex);

  return (
    <div
      className={`menu-content-item h-itemHeight flex justify-between items-center p-menuPadding ${selectedClass}`}
      style={
        {
          background: item.background && item.background,
        } as React.CSSProperties
      }>
      <div
        dangerouslySetInnerHTML={{
          __html: replaceColors(item.name),
        }}
      />
      <div className="flex items-center gap-1">
        {visibleItems.map((colorItem, index) => {
          const actualIndex = startIndex + index;
          const isSelected = actualIndex === currentIndex;
          
          return (
            <div
              key={actualIndex}
              className="color-badge"
              style={{
                width: isSelected ? '28px' : '24px',
                height: isSelected ? '28px' : '24px',
                borderRadius: '50%',
                backgroundColor: colorItem.color,
                border: isSelected ? '3px solid white' : '2px solid rgba(255, 255, 255, 0.3)',
                boxShadow: isSelected 
                  ? '0 0 8px rgba(255, 255, 255, 0.8), inset 0 0 4px rgba(0, 0, 0, 0.3)' 
                  : 'inset 0 0 4px rgba(0, 0, 0, 0.3)',
                transition: 'all 0.2s ease',
                flexShrink: 0,
              }}
              title={colorItem.name}
            />
          );
        })}
      </div>
    </div>
  );
}
