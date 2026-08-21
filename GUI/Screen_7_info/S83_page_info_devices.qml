import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../Enums"

S83_parametr_group
{
    Layout.alignment:   Qt.AlignBottom
    Layout.fillWidth:   true

    content_component:
    ColumnLayout
        {
       // anchors.left:   parent.left
       // anchors.right:  parent.right
       // anchors.top:    parent.top
        spacing:        0
        S83_vreg_ids {id: vreg_ids}


        S83_parametr_classic
            {
            id:             par_vreg

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Регулятор громкости:"


            text_value:     "-"

            }

        S83_parametr_classic
            {
            id:             par_vind

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Индикатор громкости:"


            text_value:     "-"

            }

        S83_parametr_classic
            {
            id:             par_kb

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Клавиатура:"


            text_value:     "-"

            }

        S83_parametr_classic
            {
            id:             par_display

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Дисплей:"


            text_value:     "-"


            }

        S83_parametr_classic
            {
            id:             par_bdac

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Модуль ЦАП:"


            text_value:     "-"

            }

        S83_parametr_classic
            {
            id:             par_switch

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Коммутатор:"


            text_value:     "-"

            }

        Connections
        {
            target: my_app

            function onSig_disconnected()
                {
                var defice = "-"
                par_vreg.text_value     = defice
                par_vind.text_value     = defice
                par_kb.text_value       = defice
                par_display.text_value  = defice
                par_switch.text_value   = defice
                }



            //Регулятор громкости
            function onSig_vreg_id(arg_vreg_id,arg_vreg_name)
                {
                par_vreg.text_value = arg_vreg_name
                if (arg_vreg_id === vreg_ids.vr_SOFTWARE)
                    par_vreg.value_warning = true
                else
                    par_vreg.value_warning = false
                }

            //Индикатор громкости
            function onSig_vind_id(arg_id,arg_name)
                {
                par_vind.text_value  = arg_name
                }

            //Клавиацтура
            function onSig_kb_id(arg_id,arg_name)
                {
                par_kb.text_value    = arg_name
                }
            //Дисплей
            function onSig_disp_id(arg_id,arg_name)
                {
                par_display.text_value  = arg_name
                }
            //Модуль DAC
            function onSig_bd_id(arg_id, arg_name, arg_port, arg_port_status)
                {
                par_bdac.text_value = arg_name
                }
            //Коммутатор
            function onSig_sw(arg_id, arg_swname, arg_sItem, arg_sItemName)
                {
                if (arg_id < 1) par_switch.text_value = "-"
                else            par_switch.text_value = "включен"
                }
        }

    }


}
