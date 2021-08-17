import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS
import "html.js" as HTML


Item {
    id: infoProject

    signal refreshList


    property int idProjectGL

    function receiveId(projectId) {
        idProjectGL = projectId

        currentProListModel.clear()
        JS.selectCurrentProject(idProjectGL)
    }

    function refreshSlot() {
        currentProListModel.clear()
        JS.selectCurrentProject(idProjectGL)
    }

    signal sendId (int idProjectGL)

    ColumnLayout {
        anchors.fill: parent

        Rectangle {
            id:rect
            width: parent.width
            height: parent.height
            color: changeColor
            radius: 10
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
                color: "#aa000000"
            }
        }


        ListView {
            id: projectInfoView
            flickableDirection: Flickable.VerticalFlick
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 50
            Layout.rightMargin: 50
            Layout.leftMargin: 50
            Layout.bottomMargin: 80
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            model: ListModel {
                id: currentProListModel
            }

            delegate:
                ColumnLayout {
                width: parent.width
                Layout.topMargin: 25
                Label {
                    text: projectName
                    font.capitalization: Font.AllUppercase
                    font.pointSize: 16
                }
                Label {
                    text: clientName + " ● " + todayDate + " ● " + realizationType
                    font.pointSize: 12
                    //topPadding: 10
                    color: "#81D4FA"
                }

                ColumnLayout {
                    Layout.topMargin: 20
                    Layout.rightMargin: 30
                    Layout.maximumWidth: parent.width
                    RowLayout {
                        Layout.maximumWidth: parent.width
                        Label {
                            text: "Dátum vytvorenia: "
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignLeft
                        }
                        Label {
                            text: todayDate
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    RowLayout {
                        Layout.maximumWidth: parent.width
                        Label {
                            text: "Testovanie: "
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignLeft
                        }
                        Label {
                            text: testDate
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                    RowLayout {
                        Layout.maximumWidth: parent.width
                        Label {
                            text: "Spustenie: "
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignLeft
                        }
                        Label {
                            text: launchDate
                            font.pointSize: 12
                            topPadding: 10
                            Layout.alignment: Qt.AlignRight
                        }
                    }
                }

                Rectangle {
                    width: 210
                    height: 1
                    color: detailColor
                    Layout.fillHeight: false
                    Layout.topMargin: 10
                    Layout.rightMargin: 30
                    Layout.fillWidth: true
                }

                RowLayout {
                    Layout.maximumWidth: parent.width
                    Layout.topMargin: 10
                    Layout.rightMargin: 30
                    Label {
                        text: "Meno zákazníka: "
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignLeft
                    }
                    Label {
                        text: clientName
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignRight
                    }
                }
                RowLayout {
                    Layout.maximumWidth: parent.width
                    Layout.rightMargin: 30
                    Label {
                        text: "Kontakt: "
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignLeft
                    }
                    Label {
                        text: contact
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignRight
                    }
                }
                RowLayout {
                    Layout.maximumWidth: parent.width
                    Layout.rightMargin: 30
                    Label {
                        text: "Adresa: "
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignLeft
                    }
                    Label {
                        text: address
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignRight
                    }

                }


                RowLayout {
                    Layout.maximumWidth: parent.width
                    Layout.rightMargin: 30
                    Label {
                        text: "Typ realizácie: "
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignLeft
                    }
                    Label {
                        text: realizationType
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignRight
                    }
                }
                RowLayout {
                    Layout.maximumWidth: parent.width
                    Layout.rightMargin: 30
                    Label {
                        text: "Adresa realizácie: "
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignLeft
                    }
                    Label {
                        text: realizationAdd
                        font.pointSize: 12
                        topPadding: 10
                        Layout.alignment: Qt.AlignRight
                    }
                }

                Rectangle {
                    width: 210
                    height: 1
                    color: detailColor
                    Layout.fillHeight: false
                    Layout.topMargin: 10
                    Layout.rightMargin: 30
                    Layout.fillWidth: true
                }

                ColumnLayout {
                    Layout.maximumWidth: parent.width
                    Layout.topMargin: 10
                    Layout.rightMargin: 30
                    Label {
                        text: "Špeciálne požiadavky: "
                        font.pointSize: 12
                        topPadding: 10

                    }
                    TextArea {
                        text: special
                        font.pointSize: 12
                        topPadding: 10
                        readOnly: true
                        width: parent.width
                        wrapMode: Text.WordWrap
                        background: null
                        selectByMouse: true

                    }
                    Label {
                        text: "Poznámky: "
                        font.pointSize: 12
                        topPadding: 20

                    }
                    TextArea {
                        text: notes
                        font.pointSize: 12
                        topPadding: 10
                        readOnly: true
                        width: parent.width
                        wrapMode: Text.WordWrap
                        background: null
                        selectByMouse: true
                    }
                }
                RowLayout {
                    Layout.topMargin: 40
                    Layout.bottomMargin: 20
                    Label {
                        text: "Zodpovedná osoba: "
                        font.pointSize: 12
                        topPadding: 10
                    }
                    Label {
                        text: personName
                        font.pointSize: 12
                        topPadding: 10
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
                Layout.alignment: Qt.AlignRight
                height: parent.height
                policy: ScrollBar.AlwaysOn

            }

        }
    }


    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*45/100

        Button {
            id: backButton
            text: qsTr("<<")
            onClicked: {
                tabBarId.currentIndex = 0
                tabId.currentIndex = 0
                listViewSearch.currentIndex = - 1;
            }

        }

        Button {
            id: editButton
            text: qsTr("UPRAVIŤ")
            onClicked: {
                tabBarId.currentIndex = 2
                sendId(idProjectGL)
            }

        }
        Button {
            id: delButton
            text: qsTr("VYMAZAŤ")
            onClicked: {
                messageDelete.open()

            }
        }


        Button {
            id: exportButton
            text: qsTr("EXPORTOVAŤ")
            onClicked: {
                exporter.html = HTML.buildHTML_project();
                exporter.start_export(currentProListModel.get(0).projectName);
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
        //modal: true
        //focus: true
        contentItem: Item {
            ColumnLayout {

                Label {
                    Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
                    text: "Chcete naozaj vymazať projekt?"
                    font.pointSize: 12
                }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Button {
                        text: "Áno"
                        Layout.topMargin: 20
                        Layout.rightMargin: 20
                        onClicked: {
                            JS.deleteProject(idProjectGL)
                            JS.deleteMultipleNotes(idProjectGL)
                            refreshList()
                            messageDelete.close()
                            tabBarId.currentIndex = 0
                            tabId.currentIndex = 0
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
}
