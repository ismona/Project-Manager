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
    id: infoNote

    signal refreshNoteList

    signal forEdit

    property int idNoteGL

    function receiveIdNote(noteId) {

        idNoteGL = noteId
        currentNoteListModel.clear()
        JS.selectCurrentNote(idNoteGL)
    }

    function refreshNoteSlot() {
        currentNoteListModel.clear()
        JS.selectCurrentNote(idNoteGL)
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: noteInfoView
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 100
            Layout.leftMargin: 50
            Layout.rightMargin: 50
            Layout.bottomMargin: 70
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            model: ListModel {
                id: currentNoteListModel
            }
            delegate:
                ColumnLayout {
                width: parent.width
                Label {
                    text: noteName
                    font.capitalization: Font.AllUppercase
                    font.pointSize: 16
                    topPadding: 20
                    color: "#81D4FA"
                }

                RowLayout {
                    Label {
                        text: "Zaredený k projektu: "
                        font.pointSize: 12
                        topPadding: 20
                        //bottomPadding: 80
                    }
                    Label {
                        text: projectName
                        font.pointSize: 12
                        topPadding: 20
                        //bottomPadding: 80
                    }
                }

                RowLayout {
                    Label {
                        text: "Dátum pridania: "
                        font.pointSize: 12
                        topPadding: 20
                    }
                    Label {
                        text: todayDate
                        font.pointSize: 12
                        topPadding: 20
                    }
                }
                RowLayout {
                    Label {
                        text: "Pridal/a: "
                        font.pointSize: 12
                        topPadding: 20
                    }
                    Label {
                        text: personName
                        font.pointSize: 12
                        topPadding: 20
                    }
                }
                RowLayout {
                    Label {
                        text: "Typ záznamu: "
                        font.pointSize: 12
                        topPadding: 20
                    }
                    Label {
                        text: noteType
                        font.pointSize: 12
                        topPadding: 20
                    }
                }

                ColumnLayout {
                    Layout.maximumWidth: parent.width
                    Layout.rightMargin: 30
                    Label {
                        text: "Správa: "
                        font.pointSize: 12
                        topPadding: 20
                    }
                    TextArea {
                        text: messageNote
                        readOnly: true
                        font.pointSize: 12
                        width: parent.width
                        wrapMode: Text.WordWrap
                        background: null
                        selectByMouse: true
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
                height: parent.height
                Layout.alignment: Qt.AlignRight
                //policy: ScrollBar.AlwaysOn
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

            contentItem: Text {
                text: backButton.text
                font.bold: true
                color: "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                implicitWidth: 40
                implicitHeight: 35
                color: "#81D4FA"
                radius: 2
            }

            onClicked: {
                if (tabBarId.currentIndex === 1) {
                    tabId.currentIndex = 4
                } else {
                    tabBarId.currentIndex = 0
                    tabId.currentIndex = 0
                }
            }
        }

        RowLayout {
            id: additionalButtons
            visible: true

            Button {
                id: editButton
                text: qsTr("UPRAVIŤ")
                onClicked: {
                    tabId.currentIndex = 3
                    forEdit()
                }
            }
            Button {
                id: deleteButton
                text: qsTr("VYMAZAŤ")
                onClicked: {
                    messageDeleteNote.open();
                }
            }
            Button {
                id: exportButton
                text: qsTr("EXPORTOVAŤ")
                onClicked: {
                    exporter.html = HTML.buildHTML_note();
                    exporter.start_export(currentNoteListModel.get(0).noteName);
                }
            }
        }
    }

    Popup {
        id: messageDeleteNote
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        padding: 20
        width: 300
        height: 150
        contentItem: Item {
            ColumnLayout {
                Label {
                    Layout.alignment: Qt.AlignTop | Qt.AlignVCenter
                    text: "Chcete naozaj vymazať záznam?"
                    font.pointSize: 12
                }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Button {
                        text: "Áno"
                        Layout.topMargin: 20
                        Layout.rightMargin: 20
                        onClicked: {
                            JS.deleteNote(idNoteGL)
                            refreshNoteList()
                            messageDeleteNote.close()


                            if (tabBarId.currentIndex === 1) {
                                tabId.currentIndex = 4
                            } else {
                                tabBarId.currentIndex = 0
                                tabId.currentIndex = 0
                            }
                        }
                    }
                    Button {
                        text: "Nie"
                        Layout.topMargin: 20
                        onClicked: {
                            messageDeleteNote.close()
                        }
                    }
                }
            }
        }
    }
}
