import QtQuick 2.12
import QtQml.Models 2.12

DelegateModel {
    id: delegateModel

    property var filterAcceptsItem: function(item) { return true; }

    function update() {
        if (items.count > 0) {
            items.setGroups(0, items.count, "items");
        }

        // filtrovanie projektov
        var visible = [];
        for (var i = 0; i < items.count; ++i) {
            var item = items.get(i);
            if (filterAcceptsItem(item.model)) {
                visible.push(item);
            }
        }

        // zobrazenie vsetkych projektov vo visible skupine
       for (i = 0; i < visible.length; ++i) {
            item = visible[i];
            item.inVisible = true;
            if (item.visibleIndex !== i) {
                visibleItems.move(item.visibleIndex, i, 1);
            }
        }
    }

    items.onChanged: update()
    onFilterAcceptsItemChanged: update()

    groups: DelegateModelGroup {
        id: visibleItems

        name: "visible"
        includeByDefault: false
    }

    filterOnGroup: "visible"
}
