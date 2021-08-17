import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Controls 1.4 as CS1
import QtQuick.Layouts 1.1
import Qt.labs.calendar 1.0


Popup {
    id: cal
    visible: false
    modal: true
    focus: true
    width: rcal.implicitWidth+80
    height: rcal.implicitHeight+100
    anchors.centerIn: parent
    property int type: -1

    signal finished(int type, var chosen_date)

    CS1.Calendar {
        id: rcal
        frameVisible: false
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 2
        }
        onDoubleClicked: {
            // console.log("hpdat: ",date)
            var d = date.getTime()/1000
            var od = (d - (d%86400)-3600)
            if(type === 0){
                date = new Date(od*1000)
            } else if( type === 1){
                date = new Date((od+86340)*1000)
            }
            finished(type, date/*.toISOString().substring(0,10)*/)
            cal.visible = false
            //console.log( date.toISOString().substring(0,10))
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        //anchors.horizontalCenter: parent.horizontalCenter
        //width: parent.width


        Button {
            Layout.fillWidth: true
            text: "Zatvoriť"
            onClicked: {
                cal.visible = false
            }
        }


    }

}
