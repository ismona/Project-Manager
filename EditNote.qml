import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

/* uprava zaznamu */

Item {

    id: editNote

    signal refreshNote

    property int idNoteGL: 0

    function receiveIdNote(noteId) {

        idNoteGL = noteId
    }

    property int idProjectGL: 0

    function receiveId(projectId) {
        idProjectGL = projectId //netreba
    }


    function receiveEditSignal() {
        JS.selectEditNote(idNoteGL)
    }

    function refreshCheckListSlot() {
        comboPersonListModel.clear()
        JS.loadComboPerson()

        comboListModelNote.clear()
        JS.loadComboNote()
    }

    RowLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 6
        z: 1

    ColumnLayout {
        width: 640

        Label {
            id:notesList
            text: " ▼ " + " " + " Uprav záznam"
            Layout.topMargin: 100
            Layout.leftMargin: 50
            font.pointSize: 15
            font.capitalization: Font.AllUppercase
        }

        RowLayout {
            Rectangle {
                width: 210
                height: 2
                color: detailColor
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: false
                Layout.topMargin: 25
                Layout.fillWidth: true
                Layout.leftMargin: 50
                Layout.rightMargin: 50
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            TextField {
                id: noteNameId
                width: 640
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.rightMargin: 50
                Layout.leftMargin: 50
                font.capitalization: Font.AllUppercase
                Layout.fillWidth: true
                font.pointSize: 12
            }
            TextField {
                id: project
                visible: false
            }
        }

        RowLayout {
            Label {
                id: todayDateId
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.topMargin: 10
                Layout.leftMargin: 50
                Layout.rightMargin: 25
                width: 150
                Layout.fillWidth: false
                font.pointSize: 12
            }
            Button {
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.rightMargin: 50
                Layout.topMargin: 5
                background: Rectangle {
                    implicitWidth: 20
                    implicitHeight: 20
                    radius: 2
                    color: "#81D4FA"
                }
                onClicked: todayCal.open()
                PopupCalendar { id: todayCal }

                Connections {
                    target: todayCal
                    onFinished: {
                        todayDateId.text = Qt.formatDateTime(chosen_date, "yyyy-MM-dd");
                    }
                }
            }
        }


        RowLayout {
            Layout.fillWidth: true
            ComboBox {
                id: comboNote
                Layout.minimumWidth: 170
                Layout.leftMargin: 50
                editable: true
                textRole: "noteType"
                model: ListModel {
                    id: comboListModelNote
                    Component.onCompleted: JS.loadComboNote()
                }
                delegate: ItemDelegate {
                    width: comboNote.width
                    height: comboNote.height
                    font.pixelSize: 15

                    contentItem: Label {
                        width: comboNote.width
                        height: comboNote.height
                        text: noteType
                        font.pixelSize: 15
                        topPadding: 12
                    }
                }
            }
        }

        RowLayout {
            TextArea {
                id: noteMsgId
                width: 640
                Layout.topMargin: 20
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.rightMargin: 50
                Layout.leftMargin: 50
                Layout.fillWidth: true
                font.pointSize: 12
                wrapMode: Text.WrapAnywhere
                onTextChanged:  if (length > 600) remove(600, length)
                selectByMouse: true
            }
        }


        RowLayout {
            Layout.fillWidth: true
            ComboBox {
                id: comboPerson
                Layout.minimumWidth: 170
                Layout.leftMargin: 50
                editable: true
                textRole: "personName"
                model: ListModel {
                    id: comboPersonListModel
                    Component.onCompleted: JS.loadComboPerson()
                }
                delegate: ItemDelegate {
                    width: comboPerson.width
                    height: comboPerson.height
                    font.pixelSize: 15

                    contentItem: Label {
                        width: comboPerson.width
                        height: comboPerson.height
                        text: personName
                        font.pixelSize: 15
                        topPadding: 12
                    }
                }
            }
        }
    }
}

    RowLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height*45/100

        Button {
            id: backButton2
            text: qsTr("<<")
            onClicked: {
                tabId.currentIndex = 1

            }
        }

        Button {
            id: newNodteButton
            text: qsTr("UPRAVIŤ ZÁZNAM")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: 40
            Layout.bottomMargin: 40
            implicitWidth: 300
            onClicked: {

                var noteId = idNoteGL;
                var noteName = noteNameId.text;
                var messageNote = noteMsgId.text;
                var projectId = project.text;
                var todayDate = todayDateId.text;

                if(noteName.trim()!=='' && messageNote.trim()!=='' && comboPerson.currentIndex >=0 && comboNote.currentIndex >=0) {

                    var personId = comboPerson.model.get(comboPerson.currentIndex).personId;
                    var noteTypeId = comboNote.model.get(comboNote.currentIndex).noteTypeId;

                    JS.updateNote(noteId, noteName, noteTypeId, messageNote, personId, projectId, todayDate)

                    refreshNote()

                    msgEdit.open()
                    timerEdit.start()

                    noteNameId.text = ""
                    comboNote.displayText = "Typ záznamu"
                    noteMsgId.text = ""
                    comboPerson.displayText = "Zodpovedná osoba"
                    todayDateId.text = "Dnešný dátum"

                    tabId.currentIndex = 1
                }else {
                    msgErr.open()
                    timerErr.start()
                }
            }
        }

        Popup {
            id: msgErr
            x: (parent.width - width) / 2
            y: (parent.height - height) - 150

            padding: 20
            contentItem: Label {
                text: "Vyplň všetky povinné polia"
                font.pointSize: 12
            }
        }
        Timer {
            id: timerErr
            interval: 2000
            onTriggered: msgErr.visible = false
        }

        Popup {
            id: msgEdit
            x: (parent.width - width) / 2
            y: (parent.height - height) - 150

            padding: 20
            contentItem: Label {
                text: "Záznam bol zmenený"
                font.pointSize: 12
            }
        }
        Timer {
            id: timerEdit
            interval: 2000
            onTriggered: msgEdit.visible = false
        }
    }
}
