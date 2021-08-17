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
    id: home

    RowLayout {
        anchors.fill: parent
        spacing: 6
        z: 1

        Item {
            id: rect2
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width*40/100
            Layout.minimumHeight: parent.height - 100
            Layout.topMargin: 75
            Layout.rightMargin: 25
            Layout.bottomMargin: 25
            Layout.leftMargin: rect1.width + 25



            RowLayout {
                anchors.fill: parent
                TabBar {
                    id: tabBarId
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    visible: false

                    TabButton {
                        text: qsTr("Zoznam")
                    }
                    TabButton {
                        text: qsTr("Info")
                    }
                    TabButton {
                        text: qsTr("Uprav")
                    }
                }
            }

            StackLayout {
                width: parent.width
                height: parent.height
                currentIndex: tabBarId.currentIndex
                visible: true

                ListofProjects {
                    Component.onCompleted: {
                        sendId.connect(infoProject.receiveId)
                        sendId.connect(projectsNotes.receiveId)
                        sendId.connect(addNote.receiveId)
                        sendId.connect(edit.receiveId)
                        //sendId.connect(infoNote.receiveId)
                        sendId.connect(editProject.receiveId)
                    }
                }
                InfoProject { id: infoProject }
                EditProject { id: editProject }
            }
        }


        Item {
            id: rect3
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width*40/100
            Layout.minimumHeight: parent.height
            Rectangle {
                anchors.fill: parent
                color: "#424242"

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: -1
                    verticalOffset: -1
                    color: "#aa000000"
                }
            }

            RowLayout {
                anchors.fill: parent
                TabBar {
                    id: tabId
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    Layout.topMargin: 50
                    visible: false

                    TabButton {
                        text: qsTr("Zoznam")
                    }
                    TabButton {
                        text: qsTr("Zobraz")
                    }
                    TabButton {
                        text: qsTr("Pridaj")
                    }
                    TabButton {
                        text: qsTr("Uprav")
                    }
                    TabButton {
                        text: qsTr("Zoznam pre projekt")
                    }
                }
            }

            StackLayout {
                width: parent.width
                height: parent.height
                currentIndex: tabId.currentIndex
                visible: true

                ListofNotes {
                    Component.onCompleted: {
                        sendIdNote.connect(infoNote.receiveIdNote)
                        sendIdNote.connect(edit.receiveIdNote)
                    }
                }
                InfoNote { id: infoNote
                    Component.onCompleted: {
                        forEdit.connect(edit.receiveEditSignal)
                    }
                }
                AddNote { id: addNote}
                Edit {id: edit}
                ProjectsNotes { id: projectsNotes
                    Component.onCompleted: {
                        sendId.connect(infoNote.receiveIdNote)
                        sendId.connect(edit.receiveIdNote)
                        forAdditionalButtons.connect(infoNote.receiveAdditional)
                    }
                }
            }
        }
    }
}
