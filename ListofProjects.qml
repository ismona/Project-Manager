import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS
Item {
    id: listOfProjects

    property int projectId

    signal sendId (int projectId)

    function refreshSlot() {
        generalListModel.clear()
        JS.selectProjectGeneral()
    }

    function deleteAllSlot(){
        generalListModel.clear()
    }

    RowLayout {

        Label {
            id: projectView
            text: "Zoznam projektov"
            Layout.topMargin: 50
            font.pointSize: 20
            Layout.leftMargin: 70

        }
    }
    RowLayout {
        anchors.fill: parent

        ListModel {
            id: generalListModel
            Component.onCompleted: JS.selectProjectGeneral()
        }


            ListView {
                id: generalListView
                clip: true
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin: 90
                Layout.leftMargin: 70
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                model: generalListModel
                delegate:
                    RowLayout {
                    Rectangle {
                        id: colorRect
                        width: 30
                        height: 30
                        radius: 2
                        Layout.rightMargin: 10
                        Layout.topMargin: 30
                        color: colorRectangle
                    }
                    ColumnLayout {
                        Label {
                            id: labelPro
                            text: projectName
                            font.capitalization: Font.AllUppercase
                            font.pointSize: 12
                            topPadding: 30
                            MouseArea {
                                id: mAreaProject
                                hoverEnabled: true
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    tabBarId.currentIndex = 1
                                    tabId.currentIndex = 4                                  
                                    sendId(projectId)
                                }
                            }
                        }
                        Label {
                            text: clientName + " ● " + todayDate + " ● " + realizationType
                            font.pointSize: 10
                        }
                    }
                }
                ScrollBar.vertical: ScrollBar {
                }

        }
    }
}
