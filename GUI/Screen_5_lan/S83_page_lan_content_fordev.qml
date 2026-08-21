import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



ColumnLayout
{
    clip:       true
    spacing:    0



    S83_Button
        {
        id:                 btn_dfh
        text:               "disconnect"
        enabled:            state_conected
        width:              200
        height:             50
        y:                  10

        Layout.alignment:   Qt.AlignBottom
        Layout.fillWidth:   true

        Layout.leftMargin:      10
        Layout.rightMargin:     10
        Layout.topMargin:       5
        Layout.bottomMargin:    5

        btn_color:          current_theme.color_ctrl_main_color
        onClicked:          my_app.slot_disconnect()
        }
/*
    S83_Button
        {
        id:                 btn_abort
        text:               "socket::abort"
        width:              200
        height:             50
        y:                  10
        enabled:            state_conected
        Layout.alignment:   Qt.AlignBottom
        Layout.fillWidth:   true

        Layout.leftMargin:  10
        Layout.rightMargin: 10

        btn_color:          current_theme.color_ctrl_main_color
        onClicked:          my_app.slot_test_tcp_abort()
        }*/


}
