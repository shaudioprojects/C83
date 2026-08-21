import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
  
Rectangle
{
    id: sender_pop_ip
    width:  50
    height: 30
    color: "Transparent"
    //anchors.left: parent.left
    //anchors.leftMargin: 11
    Layout.leftMargin:  11
    Layout.fillWidth:   true

    property string text_ip:        "-"
    property string text_nname:     " "
    property alias  image_icon:     ip_image.source
    signal select_pop_ip(string arg_pop_ip)

    Image
        {
        id: ip_image

        height: 25
        width:  25
        source: "qrc:/Icon/for_page/ip_gray.svg"

        anchors.left: parent.left
        }
    Text
        {
        id:     ip_text
        text:   text_nname.length > 1 ? (text_ip + " - " + text_nname) : text_ip
        color:  "white"
        font.pixelSize:     18

        anchors.left:       ip_image.right
        anchors.leftMargin: 8
        }

    MouseArea
        {
        anchors.fill: parent
        onClicked:
              {
              if (text_ip.length > 3)
                {
                my_app.slot_ip_address_change(text_ip)
                my_toast.show("Подключение к " + text_ip, 3000)
                }
              event_select_pop_ip(ip_text.text)
              }
        }
}
