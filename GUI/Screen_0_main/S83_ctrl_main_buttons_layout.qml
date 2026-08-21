import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"


RowLayout
{
    property int icon_size: 20

    Item
        {
        width: button_pre.width/4
        }

    S83_Button
        {
        id: button_pre

        btn_color: current_theme.color_ctrl_main_color
        Layout.fillWidth: true //Чтоб размер растягивался
        onClicked:
            {
            //console.log("out: Нажата кнопка PRE")
            my_app.slot_pre()
            }
        icon.width:     icon_size
        icon.height:    icon_size
        icon.color:     "transparent"
        icon.source:    "qrc:/Icon/for_buttons/pre.svg"
        }

    S83_Button
        {
        id: button_stop
        Layout.fillWidth: true
        btn_color: current_theme.color_ctrl_main_color
        onClicked:  {
                    //console.log("out: Нажата кнопка STOP")
                    my_app.slot_stop()
                    }
        icon.width: icon_size
        icon.height: icon_size
        icon.color: "transparent"
        icon.source: "qrc:/Icon/for_buttons/stop.svg"
        }

    S83_Button
        {
        id: button_pause
        Layout.fillWidth: true
        btn_color: current_theme.color_ctrl_main_color
        onClicked:  {
                    //console.log("out: Нажата кнопка PAUSE")
                    my_app.slot_pause_resume()
                    }
        icon.width: icon_size
        icon.height: icon_size
        icon.color: "transparent"
        icon.source: "qrc:/Icon/for_buttons/pause.svg"
        }

    S83_Button
        {
        id: button_play
        height: 50
        Layout.fillWidth: true
        btn_color: current_theme.color_ctrl_main_color
        onClicked:  {
                    //console.log("out: Нажата кнопка PLAY")
                    my_app.slot_open()
                    }
        icon.width: icon_size
        icon.height: icon_size
        icon.color: "transparent"
        icon.source: "qrc:/Icon/for_buttons/play.svg"
    }

    S83_Button
        {
        id: button_next
        btn_color:          current_theme.color_ctrl_main_color
        Layout.fillWidth:   true
        onClicked:  {
                    //console.log("out: Нажата кнопка NEXT")
                    my_app.slot_next()
                    }
        icon.width: icon_size
        icon.height: icon_size
        icon.color: "transparent"
        icon.source: "qrc:/Icon/for_buttons/next.svg"
        }
    Item
        {
        width: button_pre.width/3
        }
}

