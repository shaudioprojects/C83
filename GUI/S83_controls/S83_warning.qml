import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"


Rectangle
{
    id:                         control
    height:                     55
    width:                      200

    color:                      "transparent"
    border.color:               "#404040"
    radius:                     5

    Layout.leftMargin:          10
    Layout.rightMargin:         10
    Layout.bottomMargin:        10


    clip:                       true

    property string text:       "-"



    Image
        {
        id:                     icon_warning
        width:                  32
        height:                 32

        anchors.verticalCenter: parent.verticalCenter
        anchors.left:           parent.left
        anchors.leftMargin:     5
        source:                 "qrc:/Icon/for_app/warning.svg";
        }

    Text
        {
        id:                     text_warning

        anchors.left:           icon_warning.right
        anchors.leftMargin:     5
        anchors.rightMargin:    5
        anchors.right:          control.right

        text:                   control.text

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter

        wrapMode:               "WordWrap"
        color:                  Qt.lighter("white", 0.75)
        font.pixelSize:         18
        }
}
