import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

import "../S83_controls"

S83_Dialog
{
    id:     mbox_dialog
    title:  "Title"
    modal:  true

    width:  parent.width * 0.8
    height: 200

    anchors.centerIn: parent

    property alias text_content:        text_content.text
    property alias text_btn_content:    btn_ok.text



    //Содержимое
    Rectangle
        {
        anchors.fill:   parent
        height:         100
        color:          current_theme.color_background
        radius:         5

        Text
            {
            id:                 text_content

            anchors.left:           parent.left
            anchors.right:          parent.right
            anchors.leftMargin:     10
            anchors.rightMargin:    10

            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize:         18

            horizontalAlignment:    Text.AlignHCenter
            verticalAlignment:      Text.AlignVCenter

            wrapMode:               "WordWrap"
            color:                  "white"
            text:                   "text_content:"
            onHeightChanged:
                {
                //console.log("Изменилась высота текста")
                mbox_dialog.height = height +100
                }
            }
        }

    //низ
    footer:
    RowLayout
        {

        Item
            {
            width: 50
            Layout.fillWidth: true //Чтоб размер растягивался
            }

        S83_Button
            {
            id:                 btn_ok
            btn_color:          current_theme.color_ctrl_main_color
            //anchors.centerIn:   parent
            text:               "Ок"
            Layout.fillWidth:   true //Чтоб размер растягивался
            //Layout.alignment:   parent
            onClicked:          mbox_dialog.accept();
            }

        Item
            {
            width: 50
            Layout.fillWidth: true //Чтоб размер растягивался
            }
        }

    onAccepted: console.log("Нажата ктопка диалога Да")

}
