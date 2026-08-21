import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12


import "../S83_controls"

S83_dialog_ok
{
    id: dialog_ok_no
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
            btn_color:          current_theme.color_ctrl_main_color
            text:               "Нет"
            Layout.fillWidth:   true //Чтоб размер растягивался
            onClicked:          dialog_ok_no.reject();
            }

        S83_Button
            {
            btn_color:          current_theme.color_ctrl_main_color
            text:               "Да"
            Layout.fillWidth:   true //Чтоб размер растягивался
            onClicked:          dialog_ok_no.accept();
            }

        Item
            {
            width: 50
            Layout.fillWidth: true //Чтоб размер растягивался
            }
    }

    onAccepted: console.log("Нажата ктопка диалога Да")
    onRejected: console.log("Нажата ктопка диалога Нет")
}
