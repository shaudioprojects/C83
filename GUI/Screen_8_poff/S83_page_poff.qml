import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_poff

    content_component:
    Rectangle
        {
        id:             rect_content
        color:          "transparent"
        clip:           true

        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top

        height:         200

        property int btn_lr_margin : 10


        ColumnLayout
                {
                anchors.left:       parent.left
                anchors.right:      parent.right
                anchors.top:        parent.top
                spacing:            0

            S83_Button
                {
                id:                 btn_poff
                text:               "Завершение работы"
                width:              200
                height:             50
                y:                  10

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.topMargin:   5
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          dialog_off.visible = true

                }

            S83_Button
                {
                id:                 btn_poffac
                text:               "Завершение работы AC"
                width:              200
                height:             50

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          dialog_acoff.visible = true
                }

            S83_Button
                {
                text:               "Выход"
                width:              200
                height:             50

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          { my_app.slot_prepare_for_exit(); Qt.quit() }
                }
            }




        }


    }


