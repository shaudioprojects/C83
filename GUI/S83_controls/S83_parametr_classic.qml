import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

Item
{
    id: control
    property alias  text_label:     label.text
    property string  text_value:    "-"

    property string color_label:    Qt.lighter("white", 0.75)
    property string color_value:    value_warning && (warning_metod ===0)  ? Qt.lighter(current_theme.color_ctrl_main_color, 1.35) : "white"

    property alias  text_value_1:   label.text
    property alias  text_value_2:   value.text

    property alias  color_value_1:  control.color_label
    property alias  color_value_2:  control.color_value

    property int    lr_margins:        2
    property int    change_padding:    10
    property bool   value_warning:    false   //Выделить значение каким то образом
    property int    warning_metod:    0

    height: label.height
    implicitWidth: 150
    //width: 150
    Text
        {
        id:                 label
        padding:            change_padding

        anchors.left:       parent.left
        anchors.top:        parent.top
        anchors.leftMargin: lr_margins

        text:               "100"
        color:              control.enabled ? color_label : "dimgray"
        font.pixelSize:     18

        }

    Text
        {
        id:                     value
        padding:                change_padding

        anchors.left:           label.right
        anchors.right:          parent.right
        anchors.top:            parent.top
        anchors.rightMargin:    lr_margins


        horizontalAlignment:    Text.AlignRight
        elide:                  Text.ElideLeft  //Сокращение точками

        text:                   text_value //value_warning ? ("[ " + text_value + " ]") : text_value
        font.weight:            value_warning && (warning_metod===1) ? Font.Bold : Font.Normal // Устанавливаем жирный шрифт
        color:                  control.enabled ? color_value : "dimgray"
        font.pixelSize:         18
        }


}
