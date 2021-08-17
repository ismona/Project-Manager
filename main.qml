import QtQml.Models 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
//import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import app.exporter 1.0
import "Database.js" as JS


ApplicationWindow {
    id: root
    visible: true
    minimumWidth: 1440
    minimumHeight: 900


    title: qsTr("Qt Project Manager")

    Material.theme: Material.Dark
    Material.accent: Material.Blue

    property color changeColor: "#424242"
    property color detailColor: "#eeeeee"

    property int projectId

    signal sendId (int projectId)

    function refreshSlot() {
        nameModel.clear()
        JS.selectProject()
    }

    function deleteAllSlot() {
        nameModel.clear()
    }

    property int idProjectGL

    function receiveId(projectId){
        idProjectGL = projectId
        //console.log(projectId)
    }


    Exporter {
        id: exporter
    }

    footer: ToolBar {
        z:3
        height: 40
        width: parent.width

        background: Rectangle {
            color: changeColor
            width: root.width

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
            Label {
                text: "Qt Project Manager / 2020"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        z:2


        TabBar {
            id: bar
            width: parent.width

            Layout.alignment: Qt.AlignLeft | Qt.AlignTop

            background: Rectangle {
                color: changeColor
                width: root.width
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                    color: "#aa000000"
                }
            }

            TabButton {
                id: homeTabButton
                width: 150
                text: qsTr("Domov")
                onClicked: {
                    tabBarId.currentIndex = 0
                    tabId.currentIndex = 0
                    listViewSearch.currentIndex = - 1;
                }
            }
            TabButton {
                width: 150
                text: qsTr("Nový projekt")
                onClicked: {
                    listViewSearch.currentIndex = - 1;
                }
            }
            TabButton {
                id:addNoteTab
                width: 150
                text: qsTr("Pridaj záznam")
                enabled: false
                onClicked: {
                    bar.currentIndex = 0
                    tabBarId.currentIndex = 1
                    tabId.currentIndex = 2
                    addNoteTab.enabled = false
                }

            }
            TabButton {
                width: 150
                text: qsTr("Zoznam")
                onClicked: {
                    listViewSearch.currentIndex = - 1;
                }
            }
            TabButton {
                width: 150
                text: qsTr("Tabuľky")
                onClicked: {
                    listViewSearch.currentIndex = - 1;
                }
            }
            TabButton {
                width: 150
                text: qsTr("Nastavenia")
                onClicked: {
                    listViewSearch.currentIndex = - 1;
                }
            }

        }

        Image {
            Layout.topMargin: 10
            Layout.rightMargin: 50
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.maximumHeight: 30
            Layout.maximumWidth: 30
            source: "images/logo.png"
        }

    }

    RowLayout {
        id: rowLay
        anchors.fill: parent
        spacing: 6
        z: 1

        Item {
            id: rect1
            Layout.fillWidth: true
            Layout.maximumWidth: parent.width*20/100
            Layout.minimumHeight: parent.height

            Rectangle {
                color: changeColor
                anchors.fill: parent

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                    color: "#aa000000"
                }
            }

            ListModel {
                id: nameModel
                Component.onCompleted: {JS.selectProject()}
            }

            RowLayout {
                id: controls

                anchors.fill: parent

                TextField {
                    id: nameFilter
                    placeholderText: qsTr("Nájdi projekt...")
                    Layout.fillWidth: true
                    Layout.topMargin: 80
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.rightMargin: 50
                    Layout.leftMargin: 50
                    font.pointSize: 12
                    onTextChanged: sortFilterModel.update()
                }
            }


            SortFilterModel {
                id: sortFilterModel
                model: nameModel
                filterAcceptsItem: function(item) {
                    return item.projectName.toLowerCase().includes(nameFilter.text.toLowerCase())
                }
                delegate: Label {
                    property bool isSelected
                    id: searchProject
                    isSelected: false
                    text: projectName
                    font.pointSize: 12
                    font.capitalization: Font.AllUppercase
                    topPadding: 15
                    bottomPadding: 15
                    leftPadding: 50
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            bar.currentIndex = 0
                            tabBarId.currentIndex = 1
                            tabId.currentIndex = 4

                            isSelected = true
                            if (isSelected == true) {
                                addNoteTab.enabled = true
                                sendId(projectId)
                                listViewSearch.currentIndex = index
                            }
                            else {
                                addNoteTab.enabled = false
                            }
                        }
                    }
                }
            }

            ListView {
                id:listViewSearch
                width: parent.width
                height: parent.height
                clip: true
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 150
                model: sortFilterModel
                highlight:
                    Rectangle {
                    id: rectHighlight
                    width: parent.width
                    height: 50
                    color: "grey"
                    y: listViewSearch.currentItem.y;
                    Behavior on y { SpringAnimation { spring: 0.5; damping: 0.1 } }
                }
                highlightFollowsCurrentItem: false

                ScrollBar.vertical: ScrollBar {
                }
            }
        }
    }


    StackLayout {
        width: parent.width
        height: parent.height
        currentIndex: bar.currentIndex
        visible: true

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
                            id: listOfProjects
                            Component.onCompleted: {
                                sendId.connect(infoProject.receiveId)
                                sendId.connect(projectsNotes.receiveId)
                                sendId.connect(addNote.receiveId)
                                sendId.connect(editNote.receiveId)
                                sendId.connect(editProject.receiveId)
                            }
                        }
                        InfoProject { id: infoProject
                            Component.onCompleted: {
                                refreshList.connect(listOfProjects.refreshSlot)
                                refreshList.connect(listofNotes.refreshNoteListSlot)
                                refreshList.connect(projectList.refreshSlot)
                                refreshList.connect(root.refreshSlot)
                                sendId.connect(editProject.receiveId)
                            }
                        }
                        EditProject { id: editProject
                            Component.onCompleted: {
                                refreshList.connect(infoProject.refreshSlot)
                                refreshList.connect(root.refreshSlot)
                                refreshList.connect(listOfProjects.refreshSlot)
                                refreshList.connect(listofNotes.refreshNoteListSlot)
                                refreshList.connect(projectsNotes.refreshNoteListSlot)
                                refreshList.connect(projectList.refreshSlot)
                            }
                        }
                    }
                }


                Item {
                    id: rect3
                    Layout.fillWidth: true
                    Layout.maximumWidth: parent.width*40/100
                    Layout.minimumHeight: parent.height
                    Rectangle {
                        anchors.fill: parent
                        color: changeColor

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
                            id: listofNotes
                            Component.onCompleted: {
                                sendIdNote.connect(infoNote.receiveIdNote)
                                sendIdNote.connect(editNote.receiveIdNote)
                            }
                        }
                        InfoNote { id: infoNote
                            Component.onCompleted: {
                                forEdit.connect(editNote.receiveEditSignal)
                                refreshNoteList.connect(listofNotes.refreshNoteListSlot)
                                refreshNoteList.connect(projectsNotes.refreshNoteListSlot)
                            }
                        }
                        AddNote { id: addNote
                            Component.onCompleted: {
                                refreshNoteList.connect(projectsNotes.refreshNoteListSlot)
                                refreshNoteList.connect(listofNotes.refreshNoteListSlot)
                                refreshNoteList.connect(projectList.refreshSlot)
                            }

                        }
                        EditNote {id: editNote
                            Component.onCompleted: {
                                refreshNote.connect(infoNote.refreshNoteSlot)
                                refreshNote.connect(listofNotes.refreshNoteListSlot)
                                refreshNote.connect(projectsNotes.refreshNoteListSlot)
                            }
                        }
                        ProjectsNotes { id: projectsNotes
                            Component.onCompleted: {
                                sendId.connect(infoNote.receiveIdNote)
                                sendId.connect(editNote.receiveIdNote)
                            }
                        }
                    }
                }
            }
        }

        NewProject { id: newProject
            Component.onCompleted: {
                refreshList.connect(root.refreshSlot)
                refreshList.connect(listOfProjects.refreshSlot)
                refreshList.connect(projectList.refreshSlot)
            }
        }
        AddNote {}
        ProjectList { id: projectList
            Component.onCompleted: {
                sendId.connect(infoProject.receiveId)
                sendId.connect(projectsNotes.receiveId)
                sendId.connect(addNote.receiveId)
                sendId.connect(root.receiveId)
            }
        }
        Tables {
            id: tables
            Component.onCompleted: {
                refreshCheckList.connect(newProject.refreshCheckListSlot)
                refreshCheckList.connect(addNote.refreshCheckListSlot)
                refreshCheckList.connect(editProject.refreshCheckListSlot)
                refreshCheckList.connect(editNote.refreshCheckListSlot)
                refreshCheckList.connect(listOfProjects.refreshSlot)
                refreshCheckList.connect(listofNotes.refreshNoteListSlot)
            }
        }
        Settings {
            Component.onCompleted: {
                deleteAll.connect(root.deleteAllSlot)
                deleteAll.connect(newProject.deleteAllSlot)
                deleteAll.connect(tables.deleteAllSlot)
                deleteAll.connect(projectList.deleteAllSlot)
                deleteAll.connect(listOfProjects.deleteAllSlot)
                deleteAll.connect(listofNotes.deleteAllSlot)
            }
        }
    }

    Component.onCompleted: {
        JS.init()
        sendId.connect(infoProject.receiveId)
        sendId.connect(projectsNotes.receiveId)
        sendId.connect(addNote.receiveId)
        listViewSearch.currentIndex = - 1;
    }
}
