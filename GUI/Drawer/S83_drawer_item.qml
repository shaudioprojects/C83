import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12


Rectangle
{
    id:         rect_darwer_item

    width:      80
    height:     40

    color:      ma_drawer_item.pressed ? current_theme.color_ctrl_selected : "transparent"
    radius:     5

    property string item_text: "-"
    property string item_icon: "-"


    Layout.alignment:   Qt.AlignTop
    Layout.fillWidth:   true

    //anchors.left:           parent.left
    //anchors.right:          parent.right

    //anchors.leftMargin:     5
    //anchors.topMargin:      5
    //anchors.rightMargin:    5


    signal itemClicked();

    Image
        {
        id:         image_item
        width:      24
        height:     24
        visible:    true

        anchors.verticalCenter: parent.verticalCenter
        anchors.left:           parent.left
        anchors.leftMargin:     5

        source: item_icon
        }

    Text
        {
        id: text_item

        anchors.left:           image_item.right
        anchors.leftMargin:     8
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -2
        //anchors.centerIn: parent // По центру
        //y: parent.height / 2

        color: "white"
        text: item_text
        font.pixelSize: 18


        }

    MouseArea
        {
        id:             ma_drawer_item
        anchors.fill:   parent



        onClicked:
            {
            rect_darwer_item.itemClicked()
            drawer.close()
            }
        }

}
