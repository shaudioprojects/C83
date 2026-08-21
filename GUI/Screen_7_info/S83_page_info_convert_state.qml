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
        spacing:        0

        S83_parametr_classic
            {
            id:                 par_bp
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Преобразование потока:"
            text_value:         "-"
            }

        S83_parametr_classic
            {
            id:                 par_swr1_state
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding: 5
            text_label:         "Фильтр \"SwR 1\":"
            text_value:         "-"
            }

        S83_parametr_classic
            {
            id:                 par_eq_state
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Фильтр \"SwEQ\":"
            text_value:         "-"
            }

        S83_parametr_classic
            {
            id:                 par_svol_state
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Фильтр \"SwVOL\":"
            text_value:         "-"
            }

        S83_parametr_classic
            {
            id:                 par_swr2_state
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Фильтр \"SwR 2\":"
            text_value:         "-"
            }



        S83_vreg_ids {id: vreg_ids}

        Connections
        {
            target: my_app

            function onSig_disconnected()
                {
                var defice = "-"
                par_bp.text_value           = defice
                par_eq_state.text_value     = defice
                par_swr1_state.text_value   = defice
                par_swr2_state.text_value   = defice
                par_svol_state.text_value   = defice

                par_bp.value_warning            = false
                par_eq_state.value_warning      = false
                par_swr1_state.value_warning    = false
                par_swr2_state.value_warning    = false
                par_svol_state.value_warning    = false
                }

            property string str_off: "off"
            property string str_on: "on"
            //Преобразование потока
            function onSig_convert_state(arg_bp, swr1_state, swr2_state, swvol )
                {
                if (arg_bp)
                    {
                    par_bp.text_value       = str_off
                    par_bp.value_warning    = false
                    }
                else
                    {
                    par_bp.text_value       = str_on
                    par_bp.value_warning    = true
                    }

                if (!swr1_state)
                    {
                    par_swr1_state.text_value       = str_off
                    par_swr1_state.value_warning    = false
                    }
                else
                    {
                    par_swr1_state.text_value       = str_on
                    par_swr1_state.value_warning    = true
                    }

                if (!swr2_state)
                    {
                    par_swr2_state.text_value       = str_off
                    par_swr2_state.value_warning    = false
                    }
                else
                    {
                    par_swr2_state.text_value       = str_on
                    par_swr2_state.value_warning    = true
                    }

                if (!swvol)
                    {
                    par_svol_state.text_value       = str_off
                    par_svol_state.value_warning    = false
                    }
                else
                    {
                    par_svol_state.text_value       = str_on
                    par_svol_state.value_warning    = true
                    }

                }

            //Состояние эквалайзера
            function onSig_eq_flag_player(arg_value)
                {
                if (arg_value)
                    {
                    par_eq_state.text_value     = str_on
                    par_eq_state.value_warning  = true
                    }
                else
                    {
                    par_eq_state.text_value     = str_off
                    par_eq_state.value_warning  = false
                    }
                }


        }

    }


}
