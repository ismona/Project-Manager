import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

/* ZAZNAMY PROJEKTU */

Item {

    id: projectsNotes

    property int rowid

    signal sendId (int noteId)

    property int idProject: 0

    function receiveId(projectId) {

        idProject = projectId
        projectNotesListModel.clear()
        JS.selectProjectNotes(idProject)
    }

    function refreshNoteListSlot() {

        projectNotesListModel.clear()
        JS.selectProjectNotes(idProject)
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
            id: projectNotesListView
            clip: true
            Layout.fillWidth: true
            Layout.fillHeight: true
            //height: 500
            Layout.topMargin: 150
            Layout.leftMargin: 70
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            model: ListModel {
                id: projectNotesListModel
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
                            cursorShape: Qt.OpenHandCursor
                            onClicked: {

                                tabId.currentIndex = 1
                                sendId(noteId)
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

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*45/100
        Button {
            id: addButton
            text: qsTr("PRIDAŤ ZÁZNAM")
            onClicked: {
                tabId.currentIndex = 2
                addNoteTab.enabled = false;
            }

        }
    }


}
