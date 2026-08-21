import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../Screen_1_main_option"
import "../Drawer"

ColumnLayout
    {
    spacing: 0

        S83_Button
            {
            id: button_vol_up
            x: 0
            y: 0

            Layout.fillWidth:       true
            Layout.fillHeight:      true

            Layout.rightMargin: 4
            Layout.leftMargin:  4
            topInset:           4
            bottomInset:        2

            btn_color: current_theme.color_ctrl_main_color

            onClicked:
                {
                console.log("out: Нажата кнопка VOL_UP")
                my_app.slot_send_vol_up()
                }

            onPressAndHold:
                {
                console.log("out: Удержание кнопки VOL_UP")
                my_app.slot_send_vol_up()
                }
            icon.color:     "transparent"
            icon.source:    "qrc:/Icon/for_buttons/bt_spk_vol_up.svg";


            }

        S83_Button
            {
            id: button_vol_down
            x: 0
            y: 0

            Layout.fillWidth:   true
            Layout.fillHeight:  true

            Layout.rightMargin: 4
            Layout.leftMargin:  4
            topInset:           2
            bottomInset:        2

            btn_color: current_theme.color_ctrl_main_color

            onClicked:
                {
                console.log("out: Нажата кнопка VOL_DOWN")
                my_app.slot_send_vol_down()
                }

            onPressAndHold:
                {
                console.log("out: Удержание кнопки VOL_DOWN")
                my_app.slot_send_vol_down()
                }

            icon.color: "transparent"
            icon.source: "qrc:/Icon/for_buttons/bt_spk_vol_down.svg";
            }


        S83_Button
        {
            id: button_stop
            x: 0
            y: 0

            Layout.fillWidth:   true
            Layout.fillHeight:  true

            Layout.rightMargin: 4
            Layout.leftMargin:  4
            topInset:           2
            bottomInset:        2

            btn_color: current_theme.color_ctrl_main_color
            onClicked:  {
                console.log("out: Нажата кнопка STOP")
                my_app.slot_stop()
            }

            icon.color: "transparent"
            icon.source: "qrc:/Icon/for_buttons/stop.svg"
        }

//        S83_Button
//        {
//            id: button_pause
//            x: 0
//            y: 0

//            Layout.fillWidth:   true
//            Layout.fillHeight:  true

//            Layout.leftMargin:  2.5
//            topInset:           2.5
//            bottomInset:        2.5

//            btn_color: current_theme.color_ctrl_main_color
//            onClicked:  {
//                console.log("out: Нажата кнопка PAUSE")
//                my_app.slot_pause_resume()
//            }

//            icon.width: icon_size
//            icon.height: icon_size
//            icon.color: "transparent"
//            icon.source: "qrc:/Icon/for_buttons/pause.svg"
//        }

    S83_Button
    {
        id: button_play
        x: 0
        y: 0
        height: 50



        Layout.fillWidth:       true
        Layout.fillHeight:      true

        Layout.rightMargin: 4
        Layout.leftMargin:  4

        topInset:           2
        bottomInset:        2

        btn_color: current_theme.color_ctrl_main_color
        onClicked:  {
            console.log("out: Нажата кнопка PLAY")
            my_app.slot_open()
        }

        icon.color: "transparent"
        icon.source: "qrc:/Icon/for_buttons/play.svg"
    }


        S83_Button
        {
            id: button_pre
            x:                      0
            y:                      0

            btn_color:              current_theme.color_ctrl_main_color

            Layout.fillWidth:       true
            Layout.fillHeight:      true

            Layout.rightMargin: 4
            Layout.leftMargin:  4
            topInset:           2
            bottomInset:        2


            onClicked:
            {
                console.log("out: Нажата кнопка PRE")
                my_app.slot_pre()
            }

            icon.color:     "transparent"
            icon.source:    "qrc:/Icon/for_buttons/pre.svg"
        }

        S83_Button
        {
            id:         button_next
            btn_color:  current_theme.color_ctrl_main_color

            Layout.fillWidth:   true
            Layout.fillHeight:  true

            Layout.rightMargin: 4
            Layout.leftMargin:  4
            topInset:           2
            bottomInset:        4

            onClicked:
                {
                console.log("out: Нажата кнопка NEXT")
                my_app.slot_next()
                }

            icon.color: "transparent"
            icon.source: "qrc:/Icon/for_buttons/next.svg"
        }


}
