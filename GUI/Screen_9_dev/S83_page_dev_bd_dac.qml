import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../Enums"

ColumnLayout
    {
    spacing: 0
    property int bd_id: -1
    property int pc_lr_margin: 4
    property int bit_slow: 0
    property int bit_super_slow: 0
    property int bit_short_delay: 0

    S83_board_ids {id: bd_ids }

    onBd_idChanged:
        {
        if (bd_id !== bd_ids.bd_NO)
            {

            bd_warning.visible  = false

            pc_port.visible         = true
            pc_port_status.visible  = true
            rb_sharp.visible        = true
            rb_slow.visible         = true
            rb_sslow.visible        = true
            chb_short_delay.visible = true

            if (bd_id === bd_ids.bd_AK4399 || bd_id === bd_ids.bd_AK4399)
                {
                rb_sharp.visible        = false
                rb_slow.visible         = false
                rb_sslow.visible        = false
                }
            }
        else
            {
            bd_warning.visible  = true

            pc_port.visible         = false
            pc_port_status.visible  = false

            rb_sharp.visible    = false
            rb_slow.visible     = false
            rb_sslow.visible   = false
            chb_short_delay.visible = false
            }
        }

    S83_parametr_classic
        {
        id:                 pc_bddac
        Layout.fillWidth:   true
        text_label:         "Модуль ЦАП:"
        text_value:         "-"
        change_padding:     5
        Layout.rightMargin: pc_lr_margin
        Layout.leftMargin:  pc_lr_margin
        }

    S83_parametr_classic
        {
        id:                 pc_port
        Layout.fillWidth:   true
        text_label:         "Порт:"
        text_value:         "-"
        change_padding:     5
        Layout.rightMargin: pc_lr_margin
        Layout.leftMargin:  pc_lr_margin
        }

    S83_parametr_classic
        {
        id:                 pc_port_status
        Layout.fillWidth:   true
        text_label:         "Порт статус:"
        text_value:         "-"
        change_padding:     5
        Layout.rightMargin: pc_lr_margin
        Layout.leftMargin:  pc_lr_margin
        }

    S83_warning
        {
        id:                 bd_warning
        Layout.fillWidth:   true
        text:               "Это устройство не имеет настроек."
        }


    S83_RadioButton
        {
        id:                 rb_sharp
        text:               "Фильтр: Sharp Roll-Off"
        font.pixelSize:     18
        Layout.leftMargin:  6
        Layout.fillWidth:   true
        visible:            false
        MouseArea
                {
                anchors.fill: parent
                onClicked:
                        {
                        my_app.slot_board_dac(bd_id, 0, 0, bit_short_delay )
                        }
                }
        }

    S83_RadioButton
        {
        id:                 rb_slow
        text:               "Фильтр: Slow Roll-Off"
        font.pixelSize:     18
        Layout.leftMargin:  6
        Layout.fillWidth:   true
        visible:            false
        MouseArea
                {
                anchors.fill: parent
                onClicked:
                        {
                        my_app.slot_board_dac(bd_id, 1, 0, bit_short_delay )
                        }
                }
        }


    S83_RadioButton
        {
        id:                 rb_sslow
        text:               "Фильтр: Super Slow Roll-Off"
        font.pixelSize:     18
        Layout.leftMargin:  6
        Layout.fillWidth:   true
        visible:            false
        MouseArea
                {
                anchors.fill: parent
                onClicked:
                        {
                        my_app.slot_board_dac(bd_id, 1, 1, bit_short_delay )
                        }
                }
        }


    S83_CheckBox
        {
        id:                 chb_short_delay
        text_color:         "white"

        Layout.alignment:   Qt.AlignBottom
        Layout.fillWidth:   true
        Layout.leftMargin:  10

        visible:            false
        checked:            false
        text:               "Опция фильтра: Short Delay"
        padding:            5
        font.pixelSize:     18
        onClicked:
            {
            my_app.slot_board_dac(bd_id, bit_slow, bit_super_slow, !bit_short_delay )
            }
        }

    Connections
        {
        target: my_app
        function onSig_bd_id(arg_id, arg_name, arg_port, arg_port_status)
            {
            bd_id = arg_id
            pc_bddac.text_value = arg_name
            pc_port.text_value  = arg_port



            if (arg_port_status )
                pc_port_status.text_value = "ok"
            else
                pc_port_status.text_value = "ошибка"

            if (arg_id === bd_ids.bd_NO)
                {
                pc_port_status.text_value = "-"
                pc_bddac.text_value = "-"
                pc_port.text_value  = "-"
                }
            }

        function onSig_bd_data(arg_id,arg_2,arg_3,arg_4,arg_5)
            {


            if (arg_id)
            {
                //slow
                if (arg_3 === 1)
                    {
                    bit_slow = 1
                    rb_slow.checked = true
                    rb_sharp.checked = false
                    }
                else
                    {
                    bit_slow = 0
                    rb_slow.checked = false
                    rb_sharp.checked = true
                    }

                //super slow
                if (arg_4 === 1)
                    {
                    bit_super_slow = 1
                    rb_sslow.checked = true
                    }
                else
                    {
                    bit_super_slow = 0
                    rb_sslow.checked = false
                    }



                //short delay
                if (arg_5 === 1)
                    {
                    bit_short_delay = 1
                    chb_short_delay.checked = true
                    }
                else
                    {
                    bit_short_delay = 0
                    chb_short_delay.checked = false
                    }
            }
        }
    }
}
