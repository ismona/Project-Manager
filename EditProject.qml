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

    id: editProject

    signal refreshList

    property int idProjectGL: 0

    function receiveId(projectId) {
        idProjectGL = projectId
        JS.selectEditProject(idProjectGL)
    }

    function refreshCheckListSlot() {
        comboPersonListModel.clear()
        JS.loadComboPerson()

        comboListModelRealization.clear()
        JS.loadComboRealization()
    }

    ScrollView
    {
        anchors.fill: parent
        contentHeight: layoutId.height
        //ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        RowLayout {
            id: layoutId
            anchors.right: parent.right
            anchors.left: parent.left
            spacing: 6
            ColumnLayout {
                Layout.bottomMargin: 25
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: 50
                Layout.rightMargin: 50
                Layout.topMargin: 25
                Label {
                    id: edit
                    text: "Uprav projekt"
                    font.pointSize: 20
                }
                TextField {
                    id: projectNameId
                    Layout.fillHeight: false
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                    placeholderText: "Názov projektu"
                    font.capitalization: Font.AllUppercase
                    Layout.fillWidth: true
                    font.pointSize: 12
                }
                RowLayout {
                    TextField {
                        id: clientId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 25
                        placeholderText: "Meno zákazníka"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                    TextField {
                        id: contactId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignRight | Qt.AlignTop
                        Layout.leftMargin: 25
                        placeholderText: "Kontakt"
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
                        placeholderText: "Fakturačná adresa"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                    TextField {
                        id: realizationId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignRight | Qt.AlignTop
                        Layout.leftMargin: 25
                        placeholderText: "Adresa realizácie"
                        Layout.fillWidth: true
                        font.pointSize: 12
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    ComboBox {
                        id: comboRealization
                        Layout.minimumWidth: 170
                        Layout.fillWidth: false
                        Layout.fillHeight: false
                        editable: true
                        textRole: "realizationType"
                        model: ListModel {
                            id: comboListModelRealization
                            Component.onCompleted: JS.loadComboRealization()
                        }
                        delegate: ItemDelegate {
                            width: comboRealization.width
                            height: comboRealization.height
                            font.pixelSize: 15

                            contentItem: Label {
                                width: comboRealization.width
                                height: comboRealization.height
                                text: realizationType
                                font.pixelSize: 15
                                topPadding: 12
                            }
                        }
                    }
                }

                RowLayout {
                    Label {
                        id: todayDateId
                        text: "Dnešný dátum"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.rightMargin: 10
                        font.pointSize: 12
                    }
                    Button {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 20
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
                        text: "Dátum testovania"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.rightMargin: 10
                        font.pointSize: 12
                    }
                    Button {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rightMargin: 20
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
                        text: "Dátum spustenia"
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.topMargin: 10
                        Layout.rightMargin: 10
                        font.pointSize: 12
                    }
                    Button {
                        Layout.topMargin: 5
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
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
                        placeholderText: "Špeciálne požiadavky"
                        Layout.fillWidth: true
                        font.pointSize: 12
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        onTextChanged:  if (length > 600) remove(600, length)
                        selectByMouse: true
                    }
                    TextArea {
                        id: notesId
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        placeholderText: "Poznámky"
                        Layout.fillWidth: true
                        font.pointSize: 12
                        width: parent.width
                        wrapMode: Text.WrapAnywhere
                        onTextChanged:  if (length > 600) remove(600, length)
                        selectByMouse: true
                    }
                }

                RowLayout {
                    ComboBox {
                        id: colors
                        Layout.fillHeight: false
                        Layout.minimumWidth: 170
                        editable: true
                        textRole: "text"
                        model: ListModel
                        {
                            id: listModelColors
                            ListElement {value: "#FFF59D"; text: "bledožltá"}
                            ListElement {value: "#EF9A9A"; text: "bledočervená"}
                            ListElement {value: "#C5E1A5"; text: "bledozelená"}
                            ListElement {value: "#B39DDB"; text: "bledofialová"}
                            ListElement {value: "#81D4FA"; text: "bledomodrá"}
                        }
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    ComboBox {
                        id: comboPerson
                        Layout.minimumWidth: 170
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

                RowLayout {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    clip: false
                    Layout.fillWidth: false

                    Button {
                        id: backButton2
                        text: qsTr("<<")
                        Layout.fillWidth: false
                        onClicked: {
                            tabBarId.currentIndex = 1
                        }
                    }

                    Button {
                        id: editProjectButton

                        text: qsTr("UPRAVIŤ PROJEKT")
                        Layout.fillWidth: false
                        Layout.topMargin: 40
                        Layout.rightMargin: 0
                        Layout.bottomMargin: 40
                        implicitWidth: 300
                        onClicked: {
                            var projectId = idProjectGL;
                            var projectName = projectNameId.text;
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

                                var realizationTypeId = (comboListModelRealization.get(comboRealization.currentIndex).realizationTypeId);
                                console.log("raltypid: " + realizationTypeId);
                                var personId = (comboPerson.model.get(comboPerson.currentIndex).personId);
                                var colorRectangle = colors.model.get(colors.currentIndex).value;
                                JS.updateProject(projectId, projectName, clientName, contact, address, realizationAdd, realizationTypeId, personId, todayDate, testDate, launchDate, special, notes, colorRectangle)

                                refreshList()

                                popEditPro.open()
                                timerEdit.start()

                                tabBarId.currentIndex = 1
                            } else {
                                popErr.open()
                                timerErr.start()
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Popup {
                id:popEditPro
                padding: 15
                x: editProject.width/2 - (popEditPro.width/2)
                contentItem: Label {
                    text: "Projekt bol upravený"
                    font.pointSize: 12
                    Layout.topMargin: editProjectButton.height + 50
                    Layout.rightMargin: 50
                    Layout.leftMargin: 300
                    Layout.bottomMargin: 40
                }
            }
            Timer {
                id: timerEdit
                interval: 2000
                onTriggered: popEditPro.visible = false
            }

            Popup {
                id:popErr
                padding: 15
                x: editProject.width/2 - (popErr.width/2)
                contentItem: Label {
                    text: "Vyplň všetky povinné polia"
                    font.pointSize: 12
                    Layout.topMargin: editProjectButton.height + 50
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
