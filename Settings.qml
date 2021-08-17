import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS
import Qt.labs.settings 1.0

/* NASTAVENIA */

Item {
    id: settings
    width: 1920
    height: 1080

    signal deleteAll

    ColumnLayout {
        Label {
            id:settingsId
            text: "Nastavenia"
            Layout.fillWidth: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.topMargin: 80
            Layout.leftMargin: rect1.width + 25
            font.pointSize: 20
        }
    }


    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id: rect6
            height: 100
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width*65/100
            Layout.minimumHeight: parent.height - 170
            Layout.topMargin: 140
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.rightMargin: 25
            Layout.bottomMargin: 25
            Layout.leftMargin: rect1.width + 25
            color: changeColor
            radius: 10

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
            }

            RowLayout {
                anchors.fill: parent
                Label {
                    id: modTextId
                    Layout.preferredHeight: 30
                    Layout.topMargin: 50
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    text: "Zmena módu užívateľského rozhrania: svetlý alebo tmavý mód"
                    font.pointSize: 12
                }
                Switch {
                    id: switchModeId
                    Layout.topMargin: 40
                    Layout.rightMargin: 50
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    text: qsTr("Prepni mód")
                    font.pointSize: 12
                    implicitWidth: 200
                    onClicked: {
                        if (switchModeId.checked == true) {
                            root.Material.theme = Material.Light
                            changeColor = "#eeeeee"
                            detailColor = "#424242"
                        } else {
                            root.Material.theme = Material.Dark
                            changeColor = "#424242"
                            detailColor = "#eeeeee"
                        }
                    }
                }
            }

            RowLayout {
                anchors.fill: parent
                Label {
                    id: dbSettingsId
                    Layout.preferredHeight: 30
                    Layout.topMargin: 150
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    text: "Vymazanie všetkých dát z databázy"
                    font.pointSize: 12
                }
                Button {
                    text: "Reset DB"
                    padding: 6
                    Layout.topMargin: 150
                    Layout.rightMargin: 50
                    implicitWidth: 200
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    onClicked: {
                        messageDelete.open()
                    }
                }
            }

            Popup {
                id: messageDelete
                x: (parent.width - width) / 2
                y: (parent.height - height) / 2
                padding: 20
                width: 300
                height: 150
                contentItem: Item {
                    ColumnLayout {

                        Label {
                            Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
                            text: "Chcete naozaj zresetovať databázu?"
                            font.pointSize: 12
                        }
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Button {
                                text: "Áno"
                                Layout.topMargin: 20
                                Layout.rightMargin: 20
                                onClicked: {
                                    JS.deleteTables()
                                    deleteAll()
                                    JS.init()
                                    JS.insertTriggerData()
                                    messageDelete.close()
                                }
                            }
                            Button {
                                text: "Nie"
                                Layout.topMargin: 20
                                onClicked: {
                                    messageDelete.close()
                                }
                            }
                        }
                    }
                }
            }


            RowLayout {
                anchors.fill: parent


                Settings {
                    id: settings1
                    property string path: "cesta k súboru"
                }

                Label {
                    id: folderPathSettingsId
                    Layout.preferredHeight: 30
                    Layout.topMargin: 250
                    Layout.leftMargin: 50
                    Layout.rightMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    text: "Nastavenie priečinku na generovanie PDF súboru"
                    font.pointSize: 12
                }
                TextField {
                    id: folderPathId
                    width: 450
                    text: settings1.path
                    Layout.fillWidth: true
                    //Layout.fillWidth: true
                    Layout.rightMargin: 25
                    Layout.topMargin: 250
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    onTextChanged: {
                        exporter.folderPath = folderPathId.text
                    }
                }
                Button {
                    id: folderPathButton
                    text: "Vybrať priečinok"
                    Layout.topMargin: 250
                    Layout.rightMargin: 50
                    implicitWidth: 200
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    onClicked: {
                        exporter.changePath();
                        folderPathId.text = exporter.folderPath
                        settings1.path = exporter.folderPath
                    }
                }
            }
        }
    }
}

