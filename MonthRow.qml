import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12

Item
{
    id: element
    anchors.fill: parent

    property alias model: projectsListModel    // odkaz na vnoreny objekt ktory inak nieje priamo dostupny

    ListModel
    {
        id: projectsListModel
    }

    ListView
    {
        id: dateListView
        clip: true
        width: borderId.width
        height: 300
        anchors.left: parent.left
        anchors.leftMargin: rect1.width + 25
        //anchors.rightMargin: 500
        anchors.top: parent.top
        anchors.topMargin: 150
        orientation: Qt.Horizontal

        ScrollBar.horizontal: ScrollBar
        {
            policy: ScrollBar.AlwaysOn
        }

        model: projectsListModel

        delegate:
            RowLayout
        {
            Rectangle
            {
                id: tableId
                width: 400
                height: 250
                color: changeColor
                radius: 10
                Layout.bottomMargin: 25
                Layout.rightMargin: 25

                layer.enabled: true
                layer.effect: DropShadow
                {
                    transparentBorder: true
                    horizontalOffset: 1
                    verticalOffset: 1
                }

                ColumnLayout
                {
                    anchors.fill: parent
                    RowLayout {
                        Label {
                            text: projectName
                            font.capitalization: Font.AllUppercase
                            font.bold: true
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 20
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Dátum vytvorenia:"
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                        Label {
                            text: todayDate
                            font.bold: true
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Dátum testovania:"
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                        Label {
                            text: testDate
                            font.bold: true
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Dátum spustenia:"
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                        Label {
                            text: launchDate
                            font.bold: true
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                        }
                    }
                    RowLayout {
                        Label {
                            text: "Posledný záznam:"
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                            bottomPadding: 10
                        }
                        Label {
                            text: lastDate
                            font.bold: true
                            font.pointSize: 12
                            Layout.leftMargin: 25
                            Layout.topMargin: 10
                            bottomPadding: 10
                        }
                    }
                    RowLayout {
                        Button {
                            id: newNoteButton
                            text: "Nový záznam"
                            font.capitalization: Font.AllUppercase
                            Layout.leftMargin: 25
                            Layout.bottomMargin: 20
                            onClicked: {
                                bar.currentIndex = 0
                                tabBarId.currentIndex = 1
                                tabId.currentIndex = 2

                                sendId(projectId)
                           }
                        }
                    }
                }
            }
        }
    }
}
