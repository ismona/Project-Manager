import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS


/* SPRAVA TABULIEK */

Item {
    id: tables
    width: 1440
    height: 900

    signal refreshCheckList

    function deleteAllSlot(){
        checkListPersonModel.clear()
        checkListNoteModel.clear()
        checkListRealModel.clear()
    }


    GridLayout {
        id: gridId
        anchors.right: parent.right
        anchors.left: parent.left
        columns: 2

        Item {
            id: tablePersonId
            Layout.fillWidth: true
            Layout.preferredWidth: tables.width*50/100
            Layout.preferredHeight: tables.height/2 - 65
            Layout.topMargin: bar.height + 25
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 25
            Layout.bottomMargin: 25
            Layout.leftMargin: rect1.width + 25

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
            }
            Rectangle {
                color: changeColor
                anchors.fill: parent
                radius: 10
            }
            Label {
                id: personTitle
                text: "Zodpovedné osoby"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 60
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.capitalization: Font.AllUppercase
                Layout.topMargin: 50
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                //Layout.rightMargin: 50
                //Layout.leftMargin: 50
                font.pointSize: 12
            }
            RowLayout {
                anchors.right: parent.right
                anchors.rightMargin: 0

                Button {
                    id: newPersonButton
                    text: qsTr("PRIDAŤ")
                    Layout.leftMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 50
                    //Layout.leftMargin: 50
                    Layout.rightMargin: 20
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var personName = personTab.text;

                        if(personName.trim()!==''){
                            JS.insertPerson(personName)

                            popAdd.open()
                            timer.start()
                            personTab.text = ""

                            checkListPersonModel.clear()
                            JS.loadPerson()
                            refreshCheckList()
                        }
                        else {
                            popErr.open()
                            timerErr.start()
                        }
                    }
                }


                Button {
                    id: delPersonButton
                    text: qsTr("VYMAZAŤ")
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.topMargin: 50
                    Layout.rightMargin: 50
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var length = personCheckListView.count
                        for(var i=0; i<length; i++) {

                            var deleted = 0

                            if(personCheckListView.itemAtIndex(i).boxChecked)
                            {
                                var deleteId = (checkListPersonModel.get(i).personId)

                                deleted++

                                JS.deletePerson(deleteId)
                                checkListPersonModel.remove(i)
                                refreshCheckList()
                            }
                        }
                        if (!deleted) {
                            popCheck.open() // zaskrtni
                            timerCheck.start()
                        }
                        else {
                            popDel.open()   // vymazane
                            timerDel.start()
                        }
                    }
                }
            }
            RowLayout {
                //height: 350
                anchors.fill: parent

                Label {
                    id: personNameId
                    text: "Zadaj meno osoby:"
                    Layout.topMargin: 120
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    //Layout.rightMargin: 50
                    Layout.leftMargin: 50
                    font.pointSize: 12
                }
                TextField {
                    id: personTab
                    Layout.topMargin: personTitle.height + 90
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    //Layout.leftMargin: 50
                    placeholderText: "Meno a priezvisko"
                    font.pointSize: 12
                    implicitWidth: 250
                    onAccepted: {
                        var personName = personTab.text;

                        if(personName.trim()!==''){
                            JS.insertPerson(personName)

                            popAdd.open()
                            timer.start()
                            personTab.text = ""

                            checkListPersonModel.clear()
                            JS.loadPerson()
                            refreshCheckList()
                        }
                        else {
                            popErr.open()
                            timerErr.start()
                        }
                    }
                }
            }


            ColumnLayout {
                anchors.fill: parent
                ListView {
                    id: personCheckListView
                    clip: true
                    width: 250
                    height: 150
                    Layout.topMargin: personTab.height + 120
                    //Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    Layout.leftMargin: 50

                    model: ListModel {
                        id: checkListPersonModel
                        Component.onCompleted:
                            JS.loadPerson();

                    }
                    delegate:
                        CheckBox {
                        id: checkboxPerson
                        text: personName
                        checked: false
                        property bool boxChecked : checkboxPerson.checked
                    }

                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
                }

                Popup {
                    id:popAdd
                    padding: 15
                    x: (parent.width - width) - 25
                    y: (parent.height - height) - 25
                    contentItem: Text {
                        text: "Osoba bola pridaná"
                        font.pointSize: 12
                    }
                }
                Timer {
                    id: timer
                    interval: 2000
                    onTriggered: popAdd.visible = false
                }

                Popup {
                    id:popDel
                    padding: 15
                    x: (parent.width - width) - 25
                    y: (parent.height - height) - 25
                    contentItem: Text {
                        text: "Osoba bola vymazaná"
                        font.pointSize: 12
                    }
                }
                Timer {
                    id: timerDel
                    interval: 2000
                    onTriggered: popDel.visible = false
                }
            }
        }

        Item {
            id: tableNoteId
            Layout.fillWidth: true
            Layout.preferredWidth: tables.width*50/100
            Layout.preferredHeight: tables.height/2 - 65
            Layout.topMargin: bar.height + 25
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.rightMargin: 25

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
            }
            Rectangle {
                color: changeColor
                anchors.fill: parent
                radius: 10
            }

            Label {
                id: noteTitle
                text: "Typ záznamu"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 60
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.capitalization: Font.AllUppercase
                Layout.topMargin: 50
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                font.pointSize: 12
            }

            RowLayout {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.top: parent.top
                Button {
                    id: newNoteTypeButton
                    text: qsTr("PRIDAŤ")
                    Layout.leftMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 50
                    //Layout.leftMargin: 50
                    Layout.rightMargin: 20
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var noteType = noteTypeTab.text;

                        if(noteType.trim()!==''){
                            JS.insertNoteType(noteType)

                            popAddNote.open()
                            timerNote.start()
                            noteTypeTab.text = ""

                            checkListNoteModel.clear()
                            JS.loadNote()
                            refreshCheckList()
                        } else {
                            popErr.open()
                            timerErr.start()
                        }
                    }
                }

                Button {
                    id: delNoteTypeButton
                    text: qsTr("VYMAZAŤ")
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.topMargin: 50
                    Layout.rightMargin: 50
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var length = noteCheckListView.count
                        for(var i=0; i<length; i++) {

                            var deleted = 0

                            if(noteCheckListView.itemAtIndex(i).boxChecked)
                            {
                                var deleteId = (checkListNoteModel.get(i).noteTypeId)

                                deleted++

                                JS.deleteNoteType(deleteId)
                                checkListNoteModel.remove(i)
                                refreshCheckList()
                            }
                        }
                        if (!deleted) {
                            popCheck.open() // zaskrtni
                            timerCheck.start()
                        }
                        else {
                            popNoteDel.open()  // vymazane
                            timerNoteDel.start()
                        }
                    }
                }
            }



            RowLayout {
                anchors.fill: parent
                Label {
                    id: noteName
                    text: "Zadaj typ záznamu:"
                    Layout.topMargin: 120
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    //Layout.rightMargin: 50
                    Layout.leftMargin: 50
                    font.pointSize: 12

                }
                TextField {
                    id: noteTypeTab
                    Layout.topMargin: personTitle.height + 90
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    //Layout.leftMargin: 50
                    placeholderText: "Typ záznamu"
                    font.pointSize: 12
                    implicitWidth: 250
                    onAccepted: {
                        var noteType = noteTypeTab.text;

                        if(noteType.trim()!==''){
                            JS.insertNoteType(noteType)

                            popAddNote.open()
                            timerNote.start()
                            noteTypeTab.text = ""

                            checkListNoteModel.clear()
                            JS.loadNote()
                            refreshCheckList()
                        } else {
                            popErr.open()
                            timerErr.start()
                        }
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent

                ListView {
                    id: noteCheckListView
                    clip: true
                    width: 250
                    height: 150
                    Layout.topMargin: noteTypeTab.height + 120
                    //Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    Layout.leftMargin: 50

                    model: ListModel {
                        id: checkListNoteModel
                        Component.onCompleted: JS.loadNote();
                    }
                    delegate:

                        CheckBox {
                        id: checkboxNote
                        text: noteType
                        checked: false
                        property bool boxChecked : checkboxNote.checked
                    }

                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
                }


                Popup {
                    id:popAddNote
                    padding: 15
                    x: (parent.width - width) - 25
                    y: (parent.height - height) - 25
                    contentItem: Text {
                        text: "Typ záznamu bol pridaný"
                        font.pointSize: 12
                    }
                }
                Timer {
                    id: timerNote
                    interval: 2000
                    onTriggered: popAddNote.visible = false
                }
            }

            Popup {
                id:popNoteDel
                padding: 15
                x: (parent.width - width) - 25
                y: (parent.height - height) - 25
                contentItem: Text {
                    text: "Typ záznamu bol vymazaný"
                    font.pointSize: 12
                }
            }
            Timer {
                id: timerNoteDel
                interval: 2000
                onTriggered: popDel.visible = false
            }
        }

        Item {
            id: tableRealizationId
            Layout.fillWidth: true
            Layout.preferredWidth: tables.width*50/100
            Layout.preferredHeight: tables.height/2 - 65
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.rightMargin: 25
            Layout.leftMargin: rect1.width + 25
            Layout.bottomMargin: 25

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 1
                verticalOffset: 1
            }
            Rectangle {
                color: changeColor
                anchors.fill: parent
                radius: 10
            }

            Label {
                id: realizationTitle
                text: "Typ realizácie"
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.top: parent.top
                anchors.topMargin: 60
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignLeft
                font.capitalization: Font.AllUppercase
                Layout.topMargin: 50
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                //Layout.rightMargin: 50
                //Layout.leftMargin: 50
                font.pointSize: 12
            }

            RowLayout {
                anchors.right: parent.right
                anchors.top: parent.top
                Button {
                    id: newRealizationTypeButton
                    text: qsTr("PRIDAŤ")
                    Layout.leftMargin: 50
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.topMargin: 50
                    //Layout.leftMargin: 50
                    Layout.rightMargin: 20
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var realizationType = realizationTab.text;

                        if (realizationType.trim()!=='') {

                            JS.insertRealizationType(realizationType)

                            popAddReal.open()
                            timerReal.start()
                            realizationTab.text = ""

                            checkListRealModel.clear()
                            JS.loadRealTypes()
                            refreshCheckList()
                        } else {
                            popErr.open()
                            timerErr.start()

                        }
                    }
                }

                Button {
                    id: delRealTypeButton
                    text: qsTr("VYMAZAŤ")
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.topMargin: 50
                    Layout.rightMargin: 50
                    Layout.bottomMargin: 40
                    implicitWidth: 120
                    onClicked: {
                        var length = realCheckListView.count
                        for(var i=0; i<length; i++) {

                            var deleted = 0

                            if(realCheckListView.itemAtIndex(i).boxChecked)
                            {
                                var deleteId = (checkListRealModel.get(i).realizationTypeId)

                                deleted++

                                JS.deleteRealType(deleteId)
                                checkListRealModel.remove(i)
                                refreshCheckList()
                            }
                        }
                        if (!deleted) {
                            popCheck.open() // zaskrtni
                            timerCheck.start()
                        }
                        else {
                            popRealDel.open() //vymazane
                            timerRealDel.start()
                        }
                    }
                }
            }
            RowLayout {
                anchors.fill: parent
                Label {
                    id: realizationName
                    text: "Zadaj typ realizácie:"
                    Layout.topMargin: 120
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    //Layout.rightMargin: 50
                    Layout.leftMargin: 50
                    font.pointSize: 12
                }
                TextField {
                    id: realizationTab
                    Layout.topMargin: realizationName.height + 90
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    //Layout.leftMargin: 50
                    placeholderText: "Typ realizácie"
                    font.pointSize: 12
                    implicitWidth: 250
                    onAccepted: {
                        var realizationType = realizationTab.text;

                        if (realizationType.trim()!=='') {

                            JS.insertRealizationType(realizationType)

                            popAddReal.open()
                            timerReal.start()
                            realizationTab.text = ""

                            checkListRealModel.clear()
                            JS.loadRealTypes()
                            refreshCheckList()
                        } else {
                            popErr.open()
                            timerErr.start()

                        }
                    }
                }
            }


            ColumnLayout {
                anchors.fill: parent
                ListView {
                    id: realCheckListView
                    clip: true
                    width: 250
                    height: 150
                    Layout.fillWidth: false
                    Layout.topMargin: realizationTab.height + 120
                    //Layout.fillHeight: false
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Layout.rightMargin: 50
                    Layout.leftMargin: 50


                    model: ListModel {
                        id: checkListRealModel
                        Component.onCompleted: JS.loadRealTypes();
                    }
                    delegate:

                        CheckBox {
                        property bool boxChecked : checkboxReal.checked

                        id: checkboxReal
                        text: realizationType
                        checked: false
                    }
                    ScrollBar.vertical: ScrollBar {
                        policy: ScrollBar.AlwaysOn
                    }
                }
                Popup {
                    id:popAddReal
                    padding: 15
                    x: (parent.width - width) - 25
                    y: (parent.height - height) - 25
                    contentItem: Text {
                        text: "Typ realizácie bol pridaný"
                        font.pointSize: 12
                    }
                }
                Timer {
                    id: timerReal
                    interval: 2000
                    onTriggered: popAddReal.visible = false
                }
                Popup {
                    id:popRealDel
                    padding: 15
                    x: (parent.width - width) - 25
                    y: (parent.height - height) - 25
                    contentItem: Text {
                        text: "Typ realizácie bol vymazaný"
                        font.pointSize: 12
                    }
                }
                Timer {
                    id: timerRealDel
                    interval: 2000
                    onTriggered: popRealDel.visible = false
                }
            }


        }

        Popup {
            id:popErr
            padding: 35
            x: (parent.width - width) - 25
            y: (parent.height - height) - 25
            contentItem: Text {
                text: "Vyplň pole!"
                font.pointSize: 12
            }
        }
        Timer {
            id: timerErr
            interval: 2000
            onTriggered: popErr.visible = false
        }
        Popup {
            id:popCheck
            padding: 35
            x: (parent.width - width)- 25
            y: (parent.height - height) - 25
            contentItem: Text {
                text: "Zaškrtni checkbox!"
                font.pointSize: 12
            }
        }
        Timer {
            id: timerCheck
            interval: 2000
            onTriggered: popCheck.visible = false
        }
    }
}



