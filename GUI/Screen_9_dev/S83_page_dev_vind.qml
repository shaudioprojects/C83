import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../Enums"

ColumnLayout
    {
    spacing: 0
    property int vind_id: -1
    S83_vind_ids {id: vind_ids }

    onVind_idChanged:
        {
        if (vind_id === vind_ids.vi_74HCT574A_V1 || vind_id === vind_ids.vi_no)
            vind_warning.visible = true
        else
            vind_warning.visible = false


        if (vind_id === vind_ids.vi_74HC595V1 || vind_id === vind_ids.vi_32F030V1)
            sl_vind_brig.visible = true
        else
            sl_vind_brig.visible = false
        }

    S83_parametr_classic
        {
        id:                 pc_vind
        Layout.fillWidth:   true
        text_label:         "Индикатор громкости:"
        text_value:         "-"
        }

    S83_warning
        {
        id:                 vind_warning
        Layout.fillWidth:   true
        text:               "Это устройство не имеет настроек."
        }

    S83_slider_and_parametrs
        {
        id:                     sl_vind_brig

        parametr_name:          "Яркость"
        parametr_value_suffix:  " %"
        parametr_name_2:        "0 %"
        parametr_value_2:       "100 %"
        disable_bottom_warning: true
        parametr_name_2_color:  "gray"
        parametr_value_2_color: "gray"

        Layout.topMargin:       4
        Layout.rightMargin:     5
        Layout.leftMargin:      5
        Layout.bottomMargin:    5

        Layout.fillWidth:       true
        from:                   0
        to:                     100

        function event_moved()
            {
            set_value_top( Math.floor(value) )
            }

        function event_moved_5()
            {
            my_app.slot_brig_ind_vreg(tools.round(value,1))
            }
        function event_moved_end()
            {
            my_app.slot_brig_ind_vreg(tools.round(value,1))
            }
        }

    Connections
        {
        target: my_app

        function onSig_vind_id(arg_id,arg_name)
            {
            vind_id             = arg_id
            pc_vind.text_value  = arg_name
            }

        function onSig_brig_ind_vreg(arg_value)
            {
            sl_vind_brig.set_value_top(arg_value)
             if (!sl_vind_brig.pressed) //Не нажато
                 sl_vind_brig.value = arg_value
            }
        }
}
