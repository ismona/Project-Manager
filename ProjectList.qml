import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import QtQuick.Dialogs 1.3
import QtQuick.LocalStorage 2.12
import "Database.js" as JS
import "dynamicMonths.js" as MonthViews

/* zoznam projektov */

Item
{
    id: projectList

    property int projectId

    signal sendId(int projectId)

    function refreshSlot()
    {
        MonthViews.destroyMonthViews()
        allProjectsListModel.clear()
        JS.selectDates()
        MonthViews.createMonthViews()
    }


    function deleteAllSlot(){
        MonthViews.destroyMonthViews()
        allProjectsListModel.clear()
    }


    ScrollView
    {
        id: scrollViewId
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        RowLayout
        {
            Label
            {
                id: nameOfProject
                text: "Zoznam projektov"
                Layout.topMargin: 80
                Layout.leftMargin: rect1.width + 25
                font.pointSize: 20
            }
        }

         RowLayout
        {
            anchors.fill: parent
            Rectangle
            {
                id: borderId
                height: 2
                color: detailColor
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.leftMargin: rect1.width + 25
                Layout.topMargin: nameOfProject.height + 85
                Layout.rightMargin: 50
            }
        }

        Item {
            id: projectsArea
            anchors.fill: parent
            Layout.leftMargin: rect1.width + 25

            ListModel
            {
                id: allProjectsListModel
                Component.onCompleted:
                {
                    JS.selectDates();
                    MonthViews.createMonthViews();
                }
            }
        }

    }
}

