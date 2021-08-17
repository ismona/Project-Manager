import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS

/* stranka na pridanie noveho projektu */


Item {
    id: newProject


    signal refreshList

    function refreshCheckListSlot() {
        comboPersonListModel.clear()
        JS.loadComboPerson()

        comboListModelRealization.clear()
        JS.loadComboRealization()
    }

    function deleteAllSlot(){
        comboPersonListModel.clear()
        comboListModelRealization.clear()
    }

    function getDate() {
        return (Qt.formatDateTime(new Date(), "yyyy-MM-dd"));
    }

    ColumnLayout {
        Label {
            id:newPro
            text: "Nový projekt"
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
            id: rect5
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


            /* ScrollView {
                id: scrollView
                anchors.fill: parent
                contentHeight: layoutId.height

                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AlwaysOn
                }*/

            ColumnLayout {
                id: layoutId
                anchors.fill: parent
                Layout.topMargin: 50
                TextField {
                    id: projectId
                    Layout.topMargin: 40
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    Layout.rightMargin: 50
                    Layout.leftMargin: 50
                    placeholderText: "Názov projektu*"
                    Layout.fillWidth: true
                    font.pointSize: 12
                }


                RowLayout {
                    TextField {
                        id: clientId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 25
                        Layout.leftMargin: 50
                        placeholderText: "Meno zákazníka*"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                    TextField {
                        id: contactId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 50
                        Layout.leftMargin: 25
                        placeholderText: "Kontakt*"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                }

                RowLayout {
                    TextField {
                        id: addressId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 25
                        Layout.leftMargin: 50
                        placeholderText: "Fakturačná adresa*"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                    TextField {
                        id: realizationId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 50
                        Layout.leftMargin: 25
                        placeholderText: "Adresa realizácie*"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                }
                RowLayout {
                    ComboBox {
                        id: comboRealization
                        Layout.minimumWidth: 170
                        displayText: "Typ realizácie*"
                        Layout.fillHeight: false
                        Layout.rightMargin: 50
                        Layout.leftMargin: 50
                        editable: true
                        textRole: "text"

                        Layout.fillWidth: false
                        model: ListModel {
                            id: comboListModelRealization
                            Component.onCompleted: JS.loadComboRealization()
                        }
                        onCurrentIndexChanged: {
                            comboRealization.displayText = comboListModelRealization.get(comboRealization.currentIndex).realizationType;
                        }

                        delegate: ItemDelegate {
                            width: comboRealization.width
                            height: comboRealization.height
                            contentItem: Label {
                                text: realizationType
                                font.pixelSize: 15
                                topPadding: 7
                                wrapMode: Text.NoWrap
                            }
                        }
                        contentItem: Label {
                            width: 100
                            height: comboRealization.height
                            text: comboRealization.displayText
                            wrapMode: Text.NoWrap
                            font.pixelSize: 15
                            topPadding: 12
                        }
                    }
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
                    Label {
                        id: testDateId
                        text: "Dátum testovania*"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.leftMargin: 50
                        Layout.rightMargin: 25
                        width: 150
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
                        onClicked: testCal.open()
                        PopupCalendar { id: testCal }

                        Connections {
                            target: testCal
                            onFinished: {
                                testDateId.text = Qt.formatDateTime(chosen_date, "yyyy-MM-dd");
                            }
                        }
                    }
                    Label {
                        id: launchDateId
                        text: "Dátum spustenia*"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.leftMargin: 50
                        Layout.rightMargin: 25
                        width: 150
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
                        onClicked: launchCal.open()
                        PopupCalendar { id: launchCal }

                        Connections {
                            target: launchCal
                            onFinished: {
                                launchDateId.text = Qt.formatDateTime(chosen_date, "yyyy-MM-dd");
                            }
                        }
                    }
                }

                ColumnLayout {
                    TextArea {
                        id: specialId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 50
                        Layout.leftMargin: 50
                        placeholderText: "Špeciálne požiadavky (600 znakov)"
                        Layout.fillWidth: true
                        font.pointSize: 12
                        width: parent.width
                        height: maximumHeight
                        wrapMode: Text.WrapAnywhere
                        onTextChanged: if (length > 600) remove(600, length)
                        selectByMouse: true

                    }
                    TextArea {
                        id: notesId
                        Layout.topMargin: 25
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 50
                        Layout.leftMargin: 50
                        placeholderText: "Poznámky (600 znakov)"
                        Layout.fillWidth: true
                        font.pointSize: 12
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        onTextChanged:  if (length > 600) remove(600, length)
                        selectByMouse: true
                    }
                }

                RowLayout {
                    Layout.leftMargin: 50
                    //Layout.fillWidth: true


                    ComboBox {
                        id: colors
                        Layout.fillHeight: false
                        Layout.rightMargin: 50
                        editable: true
                        Layout.minimumWidth: 170
                        textRole: "text"
                        displayText: "farba"
                        model: ListModel
                        {
                            id: colorModel
                            ListElement {value: "#FFF59D"; text: "bledožltá"}
                            ListElement {value: "#EF9A9A"; text: "bledočervená"}
                            ListElement {value: "#C5E1A5"; text: "bledozelená"}
                            ListElement {value: "#B39DDB"; text: "bledofialová"}
                            ListElement {value: "#81D4FA"; text: "bledomodrá"}

                        }
                        onCurrentIndexChanged: {
                            colors.displayText = colorModel.get(colors.currentIndex).text;
                        }
                    }
                }


                RowLayout {
                    Layout.leftMargin: 50
                    //width: 550
                    //Layout.fillWidth: false

                    ComboBox {
                        id: comboPerson
                        displayText: "Zodpovedná osoba*"
                        //Layout.topMargin: 25
                        Layout.fillHeight: false
                        Layout.rightMargin: 50
                        editable: true
                        textRole: "text"
                        Layout.minimumWidth: 170
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
                RowLayout {
                    Label {
                        text: "Povinné polia sú označené *"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.leftMargin: 50
                        Layout.rightMargin: 25
                        font.pointSize: 12
                    }
                }
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Button {
                        id: newProjectButton
                        text: qsTr("PRIDAŤ PROJEKT")
                        Layout.fillWidth: false
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Layout.topMargin: 40
                        Layout.bottomMargin: 40

                        implicitWidth: 500
                        onClicked: {
                            var projectName = projectId.text;
                            var clientName = clientId.text;
                            var contact = contactId.text;
                            var address = addressId.text;
                            var realizationAdd = realizationId.text;
                            var special = specialId.text;
                            var todayDate = todayDateId.text;
                            var testDate = testDateId.text;
                            var launchDate = launchDateId.text;
                            var notes = notesId.text;


                            if(projectName.trim()!=='' && clientName.trim()!=='' && contact.trim()!==''
                                    && address.trim()!=='' && realizationAdd.trim()!==''
                                    && comboPerson.currentIndex >=0 && comboRealization.currentIndex >=0) {

                                var realizationTypeId = comboRealization.model.get(comboRealization.currentIndex).realizationTypeId;
                                var personId = comboPerson.model.get(comboPerson.currentIndex).personId;
                                var colorRectangle = colors.model.get(colors.currentIndex).value;

                                JS.insert(projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle)

                                refreshList()
                                popAddPro.open()
                                timerPro.start()

                                projectId.text = ""
                                clientId.text = ""
                                contactId.text = ""
                                addressId.text = ""
                                realizationId.text = ""
                                comboRealization.displayText = "Typ realizácie"
                                comboPerson.displayText = "Zodpovedná osoba"
                                specialId.text = ""
                                notesId.text = ""
                                todayDateId.text = "Dnešný dátum"
                                testDateId.text = "Dátum testovania"
                                launchDateId.text = "Dátum spustenia"
                                //colors.displayText  dorobit

                                bar.currentIndex = 0
                                tabBarId.currentIndex = 0
                            } else {
                                popErr.open()
                                timerErr.start()
                            }
                        }
                    }
                }

            }

            RowLayout {

                Popup {
                    id:popAddPro
                    padding: 15
                    x: (rect5.width/2 - (popAddPro.width/2))/2
                    y: -80
                    contentItem: Label {
                        text: "Nový projekt bol pridaný"
                        font.pointSize: 12
                        Layout.topMargin: 50
                        Layout.rightMargin: 50
                        Layout.leftMargin: 300
                        Layout.bottomMargin: 40
                    }
                }
                Timer {
                    id: timerPro
                    interval: 2000
                    onTriggered: popAddPro.visible = false
                }
            }

            RowLayout {
                Popup {
                    id:popErr
                    padding: 15
                    x: rect5.width/2 - (popErr.width/2)
                    contentItem: Label {
                        text: "Vyplň všetky povinné polia"
                        font.pointSize: 12
                        Layout.topMargin: newProjectButton.height + 50
                        Layout.rightMargin: 50
                        Layout.leftMargin: 300
                        Layout.bottomMargin: 40
                    }
                }
                Timer {
                    id: timerErr
                    interval: 2000
                    onTriggered: popErr.visible = false
                }
            }
        }
    }
    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        Label {
            id: labelDate
            width: 31
            height: 20
            text: getDate()
            Layout.leftMargin: rect5.width + 300
            Layout.alignment: Qt.AlignRight | Qt.AlignTop
            Layout.topMargin: 150
            font.pixelSize: 15
            font.bold: true
        }
    }
}


