import useKeyPress from '../../hooks/useKeyPress';
import type { ItemProps } from '../../types';
import { replaceColors } from '../../utilts';

export function List({ item, selected, selectedItem, menuContext }: ItemProps) {
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
      <div className="flex items-center gap-2">
        <div>{item.other.items[item.other.current]}</div>
      </div>
    </div>
  );
}
