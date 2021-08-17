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
    id: listofNotes

    property int rowid

    signal sendIdNote (int noteId)

    function refreshNoteListSlot() {

        generalListModelNote.clear()
        JS.selectNoteGeneral()
    }

    function deleteAllSlot(){
        generalListModelNote.clear()
    }

    ColumnLayout {
        Label {
            id:notesList
            text: " ▼ " + " " + " Zoznam záznamov"
            Layout.topMargin: 100
            Layout.leftMargin: 50
            //Layout.bottomMargin: 50
            font.pointSize: 15
            font.capitalization: Font.AllUppercase
        }
    }
    RowLayout {
        anchors.fill: parent
        Rectangle {
            width: 210
            height: 2
            color: detailColor
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillHeight: false
            Layout.topMargin: 150
            Layout.fillWidth: true
            Layout.leftMargin: 50
            Layout.rightMargin: 50
        }
    }

    RowLayout {
        anchors.fill: parent

        ListView {
            id: generalListViewNote
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.topMargin: 150
            Layout.leftMargin: 70
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            model: ListModel {
                id: generalListModelNote
                Component.onCompleted: JS.selectNoteGeneral()
            }
            delegate:
                RowLayout {
                Rectangle {
                    width: 25
                    height: 25
                    radius: 2
                    Layout.rightMargin: 10
                    Layout.topMargin: 30
                    color: colorRectangle
                }
                ColumnLayout {

                    Label {
                        id: labelPro
                        text: noteName
                        font.capitalization: Font.AllUppercase
                        font.pointSize: 12
                        topPadding: 30
                        MouseArea {
                            id: mAreaProject
                            hoverEnabled: true
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                tabId.currentIndex = 1
                                sendIdNote(noteId)
                            }
                        }
                    }
                    Label {
                        text: todayDate + " ● " + noteType
                        font.pointSize: 10
                    }
                }
            }
            ScrollBar.vertical: ScrollBar {
            }
        }
    }


}
