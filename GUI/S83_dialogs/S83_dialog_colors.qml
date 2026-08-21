import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
//import "./GUI/S83_dialogs"

S83_dialog_ok_cancel
{
    id:             dlg_colors
    text_content:   "  "
    height:         500

    property color  current_color: "white"

    function get_new_color()
        {
        return current_color
        }

    onCurrent_colorChanged:
        {
        //console.log("out: Изменился цвет curent_color: " + current_color)
        sl_red.value    = 100 * current_color.r
        sl_green.value  = 100 * current_color.g
        sl_blue.value   = 100 * current_color.b
        }

    ColumnLayout
    {
        id:                 cl_colors
        spacing:            0
        Layout.alignment:   Qt.AlignHCenter|Qt.AlignTop
        width:              parent.width

        Text
            {
            id:                 ex_text
            text:               "Пример текста"
            color:              Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1) //Qt.hsla(sl_red.value/100, 1, sl_blue.value/100,1)
            font.pixelSize:     22
            Layout.alignment:   Qt.AlignHCenter|Qt.AlignTop
            Layout.margins:     20
            }



        S83_slider_and_parametrs
            {
            id:                     sl_red
            parametr_name:          "Красный"
            parametr_name_2:        " "
            color_slider:           "red"
            parametr_name_2_color:  "gray"
            parametr_value_2_color: "transparent"
            parametr_value_suffix:  " %"
            parametr_value_suffix_2:" %"

            to:                     100
            Layout.topMargin:       5
            Layout.rightMargin:     5
            Layout.leftMargin:      5
            Layout.bottomMargin:    5

            Layout.fillWidth:       true

            function event_moved()
                {
                set_value_top(value)
                }
            function event_moved_5()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }
            function event_moved_end()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }
            }

        S83_slider_and_parametrs
            {
            id:                     sl_green
            parametr_name:          "Зеленый"
            parametr_name_2:        " "
            color_slider:           "green"
            parametr_name_2_color:  "gray"
            parametr_value_2_color: "transparent"
            parametr_value_suffix:  " %"
            parametr_value_suffix_2:" %"
            to:                     100
            Layout.topMargin:       5
            Layout.rightMargin:     5
            Layout.leftMargin:      5
            Layout.bottomMargin:    5

            Layout.fillWidth:       true

            function event_moved()
                {
                set_value_top(value)
                }
            function event_moved_5()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }
            function event_moved_end()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }
            }

        S83_slider_and_parametrs
            {
            id:                     sl_blue
            parametr_name:          "Синий"
            parametr_name_2:        " "
            color_slider:           "blue"
            parametr_name_2_color:  "gray"
            parametr_value_2_color: "transparent"
            parametr_value_suffix:  " %"
            parametr_value_suffix_2:" %"
            to: 100
            Layout.topMargin:       5
            Layout.rightMargin:     5
            Layout.leftMargin:      5
            Layout.bottomMargin:    5

            Layout.fillWidth:       true

            function event_moved()
                {
                set_value_top(value)
                }

            function event_moved_5()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }

            function event_moved_end()
                {
                current_color = Qt.rgba(sl_red.value/100, sl_green.value/100, sl_blue.value/100, 1)
                }
            }
    }




    onVisibleChanged:
        {
        dlg_colors.height   = 300

        sl_red.value        = current_color.r * 100
        sl_red.onMoved()     //Что бы пересчитать значения
        sl_green.value      = current_color.g * 100
        sl_green.onMoved()
        sl_blue.value       = current_color.b * 100
        sl_blue.onMoved()
        }
}
