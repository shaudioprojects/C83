import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls

//Блокировочный экран
Rectangle
    {
    //property bool   block_mode:     false
    property alias  image_src:      image_no_server_data.source
    property alias  message_src:    text_no_response.text
    property int    content_y_offset: 0

    anchors.top:    parent.top
    anchors.left:   parent.left
    anchors.right:  parent.right

    height:         100
    color:          "#cc000000"


    Image
        {
        id:       image_no_server_data
        width:    48
        height:   48
        anchors.centerIn:               parent
        anchors.horizontalCenter:       parent.horizontalCenter
        anchors.verticalCenter:         parent.verticalCenter
        anchors.verticalCenterOffset:   content_y_offset
        }

    Text
        {
        id:                         text_no_response
        anchors.top:                image_no_server_data.bottom
        anchors.horizontalCenter:   parent.horizontalCenter
        color:                      "white"
        font.pixelSize:             18
        }

    z:+1
    MouseArea{anchors.fill: parent}
}
