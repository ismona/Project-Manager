import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

/* PRIDANIE NOVEHO ZAZNAMU */

Item {

    id: addNote
    signal refreshNoteList

    function refreshCheckListSlot() {
        comboPersonListModel.clear()
        JS.loadComboPerson()

        comboListModelNote.clear()
        JS.loadComboNote()
    }

    property int idProject: 0

    function receiveId(projectId) {

        idProject = projectId
    }

    function getDate() {
        return (Qt.formatDateTime(new Date(), "yyyy-MM-dd"));
    }

    RowLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        spacing: 6
        z: 1

        ColumnLayout {
            width: 400

            Label {
                id:notesList
                text: " ▼ " + " " + " Pridaj záznam"
                Layout.topMargin: 100
                Layout.leftMargin: 25
                font.pointSize: 15
                font.capitalization: Font.AllUppercase
            }

            TextField {
                id: noteNameId
                Layout.topMargin: 20
                Layout.bottomMargin: 20
                Layout.fillHeight: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.rightMargin: 50
                Layout.leftMargin: 50
                placeholderText: "Nadpis záznamu"
                font.capitalization: Font.AllUppercase
                Layout.fillWidth: true
                font.pointSize: 12
            }


            RowLayout {
                Label {
                    id: todayDateId
                    text: getDate()
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 10
                    Layout.leftMargin: 50
                    Layout.rightMargin: 25
                    width: 150
                    font.pointSize: 12
                }
                Button {
                    Layout.topMargin: 5
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.rightMargin: 50

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


            ComboBox {
                id: comboNote
                displayText: "Typ záznamu"
                Layout.minimumWidth: 170
                Layout.fillHeight: false
                Layout.rightMargin: 50
                Layout.leftMargin: 50
                editable: true
                textRole: "text"

                width: 230
                model: ListModel {
                    id: comboListModelNote
                    Component.onCompleted: JS.loadComboNote()
                }
                onCurrentIndexChanged: {
                    comboNote.displayText = comboListModelNote.get(comboNote.currentIndex).noteType;
                }

                delegate: ItemDelegate {
                    width: comboNote.width
                    height: comboNote.height
                    contentItem: Label {
                        text: noteType
                        font.pixelSize: 15
                        topPadding: 7
                        wrapMode: Text.NoWrap
                    }
                }
                contentItem: Label {
                    width: comboNote.width
                    height: comboNote.height
                    text: comboNote.displayText
                    wrapMode: Text.NoWrap
                    font.pixelSize: 15
                    topPadding: 12
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
                    placeholderText: "Poznámky (600 znakov)"
                    Layout.fillWidth: true
                    font.pointSize: 12
                    wrapMode: Text.WrapAnywhere
                    onTextChanged:  if (length > 600) remove(600, length)
                    selectByMouse: true
                }
            }


            ComboBox {
                id: comboPerson
                displayText: "Zodpovedná osoba"
                Layout.minimumWidth: 170
                Layout.topMargin: 20
                Layout.fillHeight: false
                Layout.rightMargin: 50
                Layout.leftMargin: 50
                editable: true
                textRole: "text"
                width: 230
                model: ListModel {
                    id: comboPersonListModel
                    Component.onCompleted: JS.loadComboPerson()
                }
                onCurrentIndexChanged: {
                    comboPerson.displayText =  comboPersonListModel.get(comboPerson.currentIndex).personName;
                }

                delegate: ItemDelegate {
                    width: comboPerson.width
                    height: comboPerson.height
                    contentItem: Label {
                        text: personName
                        font.pixelSize: 15
                        topPadding: 7
                        wrapMode: Text.NoWrap
                    }
                }
                contentItem: Label {
                    width: comboPerson.width
                    height: comboPerson.height
                    text: comboPerson.displayText
                    wrapMode: Text.NoWrap
                    font.pixelSize: 15
                    topPadding: 12
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
                tabId.currentIndex = 4
            }
        }

        Button {
            id: newNoteButton
            text: qsTr("PRIDAŤ ZÁZNAM")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: 40
            Layout.bottomMargin: 40
            implicitWidth: 300
            onClicked: {
                var noteName = noteNameId.text;
                var messageNote = noteMsgId.text;
                var projectId = idProject;
                var todayDate = todayDateId.text;

                if(noteName.trim()!=='' && messageNote.trim()!=='' && comboPerson.currentIndex >=0 && comboNote.currentIndex >=0) {

                    var noteTypeId = comboNote.model.get(comboNote.currentIndex).noteTypeId;
                    var personId = comboPerson.model.get(comboPerson.currentIndex).personId;

                    JS.insertNote(noteName, noteTypeId, messageNote, personId, projectId, todayDate)

                    refreshNoteList()

                    msgAdd.open()
                    timerAdd.start()

                    noteNameId.text = ""
                    comboNote.displayText = "Typ záznamu"
                    noteMsgId.text = ""
                    comboPerson.displayText = "Zodpovedná osoba"
                    todayDateId.text = "Dnešný dátum"

                    tabId.currentIndex = 4

                }
                else {
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
            id: msgAdd
            x: (parent.width - width) / 2
            y: (parent.height - height) - 150

            padding: 20
            contentItem: Label {
                text: "Záznam bol pridaný"
                font.pointSize: 12
            }
        }
        Timer {
            id: timerAdd
            interval: 2000
            onTriggered: msgAdd.visible = false
        }
    }
}
