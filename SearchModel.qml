import QtQml.Models 2.12
import QtQuick.Window 2.12
import QtQuick 2.12

import QtQuick.Controls 2.13
import QtQuick.Controls 1.4

import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12

import "Database.js" as JS

//import org.qtproject.example 1.0

/* id: window
    visible: false
    title: "Table View Example"

    toolBar: ToolBar {
        TextField {
            id: searchBox

            placeholderText: "Search..."
            inputMethodHints: Qt.ImhNoPredictiveText

            width: window.width / 5 * 2
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    TableView {
        id: tableView

        frameVisible: false
        sortIndicatorVisible: true

        anchors.fill: parent

        Layout.minimumWidth: 400
        Layout.minimumHeight: 240
        Layout.preferredWidth: 600
        Layout.preferredHeight: 400

        TableViewColumn {
            id: projectColumn
            title: "Projekt"
            role: "project"
            movable: false
            resizable: false
            width: tableView.viewport.width - idColumn.width
        }

        TableViewColumn {
            id: idColumn
            title: "Id"
            role: "idofproject"
            movable: false
            resizable: false
            width: tableView.viewport.width / 3
        }

        model: SortFilterProxyModel {
            id: proxyModel
            source: sourceModel.count > 0 ? sourceModel : null

            sortOrder: tableView.sortIndicatorOrder
            sortCaseSensitivity: Qt.CaseInsensitive
            sortRole: sourceModel.count > 0 ? tableView.getColumn(tableView.sortIndicatorColumn).role : ""

            filterString: "*" + searchBox.text + "*"
            filterSyntax: SortFilterProxyModel.Wildcard
            filterCaseSensitivity: Qt.CaseInsensitive
        }

        ListModel {
            id: sourceModel
            //Component.onCompleted: { JS.selectProject() }
            ListElement {
                project: "projectName"
                idofproject: "rowid"
            }

        }
    }*/

Item {

    RowLayout {
        anchors.fill: parent
        Label {
            id:searchProTitle
            text: "Vyhľadaj projekt"
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.topMargin: 75
            Layout.leftMargin: rect1.width + 25
            font.pointSize: 20
            color: "white"
        }
    }
    RowLayout {
        anchors.fill: parent
        Rectangle {
            width: 210
            height: 2
            color: "#ffffff"
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: false
            Layout.fillWidth: true
            Layout.leftMargin: rect1.width + 25
            Layout.topMargin: searchProTitle.height + 85
            Layout.rightMargin: 50
        }
    }

    Item {
        id: element
        anchors.fill: parent
        visible: true

        ColumnLayout {
            anchors.fill: parent

            Item {
                id: rect5
                height: 100
                Layout.fillWidth: true
                Layout.maximumWidth: parent.width*65/100
                Layout.minimumHeight: parent.height - 180
                Layout.topMargin: 140
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.rightMargin: 25
                Layout.bottomMargin: 25
                Layout.leftMargin: rect1.width + 25

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                }
                Rectangle { color: "#424242"
                    anchors.fill: parent
                    radius: 10

                }
                ListModel {
                    id: nameModel
                    Component.onCompleted: {JS.selectProject()}
                   /* ListElement { name: "Alice"}
                    ListElement { name: "Bob"}
                    ListElement { name: "Jane"}
                    ListElement { name: "Victor"}
                    ListElement { name: "Wendy"}*/
                }

                RowLayout {
                    id: controls

                    anchors {
                        left: parent.left
                        top: parent.top
                        right: parent.right
                    }

                    TextField {
                        id: nameFilter
                        placeholderText: qsTr("Search by name...")
                        Layout.fillWidth: true
                        onTextChanged: sortFilterModel.update()
                    }
/*
                    RadioButton {
                        id: sortByName
                        checked: true
                        text: qsTr("Sort by name")
                        onCheckedChanged: sortFilterModel.update()
                    }

                    RadioButton {
                        text: qsTr("Sort by team")
                    }*/
                }

                SortFilterModel {
                    id: sortFilterModel
                    model: nameModel
                    filterAcceptsItem: function(item) {
                        return item.projectName.includes(nameFilter.text)
                    }
                   /* lessThan: function(left, right) {
                        if (sortByName.checked) {
                            var leftVal = left.name;
                            var rightVal = right.name;
                        } else {
                            leftVal = left.team;
                            rightVal = right.team;
                        }
                        return leftVal < rightVal ? -1 : 1;
                    }*/
                    delegate: Text {
                        text: projectName
                    }
                }

                ListView {
                    anchors {
                        left: parent.left
                        top: controls.bottom
                        right: parent.right
                        bottom: parent.bottom
                    }
                    model: sortFilterModel
                }
            }
        }
    }

}
