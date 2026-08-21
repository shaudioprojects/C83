import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../Enums"



ColumnLayout
    {
    id:         cl_dev_disp
    spacing:    0

    S83_disp_ids        {id: dp_ids         }
    S83_disp_colors_ids {id: dp_colors_ids  }

    Connections
        {
        target: my_app

        function onSig_disp_id(arg_id,arg_name,arg_gui)
            {
            pc_disp.text_value  = arg_name

            if (arg_gui)    pc_gui.text_value  = arg_gui
            else            pc_gui.text_value  = "-"

            rb_color_par_name.visible       = false
            rb_color_par_value.visible      = false
            rb_color_par_value_w.visible    = false
            rb_color_pr_bar.visible         = false
            btns_colors.visible             = false

            disp_warning.visible            = false
            sl_lcd_brig.visible             = true

            switch (arg_id)
                {
                case dp_ids.dp_NO:
                    sl_lcd_brig.visible             = false
                    disp_warning.visible            = true
                    break

                case  dp_ids.dp_SPI:
                    break

                case dp_ids.dp_USB:
                    rb_color_par_name.visible       = true
                    rb_color_par_value.visible      = true
                    rb_color_par_value_w.visible    = true
                    rb_color_pr_bar.visible         = true
                    btns_colors.visible             = true
                    break

                case dp_ids.dp_DRM:
                    break
                }


            }

        //Цвета некоторые на дисплее
        function onSig_color_disp_parametr(arg_id_parametr, arg_red, arg_green, arg_blue)
            {
            switch (arg_id_parametr)
                {
            case dp_colors_ids.id_COLOR_DP_PAR_NAME:        rb_color_par_name.color     = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                break
            case dp_colors_ids.id_COLOR_DP_PAR_VALUE:       rb_color_par_value.color    = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                break
            case dp_colors_ids.id_COLOR_DP_PAR_VALUE_WRG:   rb_color_par_value_w.color  = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                break
            case dp_colors_ids.id_COLOR_DP_PROGRESS_BAR:    rb_color_pr_bar.color       = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                break
                }
            }

        //Яркость
        function onSig_brig_lcd(arg_value,arg_status)
            {
            sl_lcd_brig.set_value_top ( arg_value )
            if (!sl_lcd_brig.pressed) //Не нажато
                 sl_lcd_brig.value = arg_value

            //Поддержка изменения яркости
            if(arg_status)
                {
                sl_lcd_brig.enabled = true
                }
            else
                {sl_lcd_brig.enabled = false
                }
            }
        //язык
        function onSig_set_lng(arg_lng, arg_status)
            {
            if (arg_status) pc_lang.enabled = true
            else            pc_lang.enabled = false

            if (arg_lng === 0)
                {
                rb_ru.checked = true
                }
            if (arg_lng === 1)
                {
                rb_en.checked = true
                }
            }
        function onSig_disconnected()
            {
            pc_lang.enabled = false
            }
        }

    S83_parametr_classic
        {
        id:                 pc_disp
        Layout.fillWidth:   true
        text_label:         "Текущий дисплей:"
        text_value:         "-"
        }

    S83_parametr_classic
        {
        id:                 pc_gui
        Layout.fillWidth:   true
        text_label:         "Текущий GUI:"
        text_value:         "-"
        }

    S83_parametr_classic
        {
        id:                 pc_lang
        Layout.fillWidth:   true
        text_label:         "Язык GUI:"
        text_value:         ""
        enabled:            false

        RowLayout
            {
                anchors.right:      parent.right
                anchors.rightMargin: 3

                S83_RadioButton
                    {
                        id:             rb_ru
                        text:           "RU"
                        font.pixelSize: 18
                        MouseArea
                            {
                            anchors.fill: parent
                            onClicked: { my_app.slot_set_gui_lang(0) }
                            }
                    }

                S83_RadioButton
                    {
                        id:             rb_en
                        text:           "EN"
                        font.pixelSize: 18
                        MouseArea
                            {
                            anchors.fill: parent
                            onClicked: { my_app.slot_set_gui_lang(1) }
                            }
                    }
            }//lay
    }

    S83_slider_and_parametrs
        {
        id:                     sl_lcd_brig

        disable_bottom_warning: true
        parametr_name:          "Яркость"
        parametr_value_suffix:  " %"

        Layout.topMargin:       4
        Layout.rightMargin:     5
        Layout.leftMargin:      5
        Layout.bottomMargin:    5

        Layout.fillWidth:       true
        parametr_name_2:        "0 %"
        parametr_value_2:       "100 %"

        parametr_name_2_color:  "gray"
        parametr_value_2_color: "gray"

        from:                   0
        to:                     100


        function event_moved()
            {
            sl_lcd_brig.set_value_top( Math.floor(value) )
            }

        function event_moved_5()
            {
            my_app.slot_brig_lcd(tools.round(value,1))
            }

        function event_moved_end()
            {
            my_app.slot_brig_lcd(tools.round(value,1))
            }
        }


    S83_warning
        {
        id:                 disp_warning

        Layout.fillWidth:   true
        text:               "Это устройство не имеет настроек."

        }


    S83_RadioButton
        {
        id:                 rb_color_par_name
        text:               "Цвет имени параметра"
        font.pixelSize:     18
        Layout.leftMargin:  5


        //Layout.alignment:   Qt.AlignLeft | Qt.AlignTop
        Layout.fillWidth:       true

        MouseArea
                {
                anchors.fill: parent
                onClicked:
                        {
                        dlg_colors_par_disp.set_start_cond(dp_colors_ids.id_COLOR_DP_PAR_NAME, parent.color )
                        reset_radiobutton()
                        parent.checked = true

                        }
                }
        }

    S83_RadioButton
            {
                id:                 rb_color_par_value
                text:               "Цвет значения параметра"
                font.pixelSize:     18
                Layout.leftMargin:  5

                Layout.alignment:   Qt.AlignLeft | Qt.AlignTop

                MouseArea
                    {
                    anchors.fill: parent
                    onClicked:
                        {
                        dlg_colors_par_disp.set_start_cond(dp_colors_ids.id_COLOR_DP_PAR_VALUE, parent.color )
                        reset_radiobutton()
                        parent.checked = true
                        }
                    }
            }

    S83_RadioButton
            {
                id:                 rb_color_par_value_w
                text:               "Цвет выделенного зн. параметра"
                font.pixelSize:     18
                Layout.leftMargin:  5

                Layout.alignment:   Qt.AlignLeft | Qt.AlignTop
                MouseArea
                    {
                    anchors.fill: parent
                    onClicked:
                        {
                        dlg_colors_par_disp.set_start_cond(dp_colors_ids.id_COLOR_DP_PAR_VALUE_WRG, parent.color )
                        reset_radiobutton()
                        parent.checked = true
                        }
                    }
            }

    S83_RadioButton
            {
                id:                 rb_color_pr_bar
                text:               "Цвет прогрессбаров"
                font.pixelSize:     18
                Layout.leftMargin:  5

                Layout.alignment:   Qt.AlignLeft | Qt.AlignTop

                MouseArea
                    {
                    anchors.fill: parent
                    onClicked:
                        {
                        dlg_colors_par_disp.set_start_cond(dp_colors_ids.id_COLOR_DP_PROGRESS_BAR, parent.color )
                        reset_radiobutton()
                        parent.checked = true
                        }
                    }
            }

    function reset_radiobutton ()
            {
            rb_color_par_name.checked       = false
            rb_color_par_value.checked      = false
            rb_color_par_value_w.checked    = false
            rb_color_pr_bar.checked         = false
            }

    //Кнопки
    RowLayout
           {
           id:               btns_colors
           spacing:          10

           Layout.alignment: Qt.AlignHCenter | Qt.AlignTop


           S83_Button
                    {
                    text:       "    Изменить    "
                    btn_color:  current_theme.color_ctrl_main_color
                    enabled:    rb_color_par_name.checked || rb_color_par_value.checked ||rb_color_par_value_w.checked || rb_color_pr_bar.checked
                    onClicked:  dlg_colors_par_disp.visible = true

                    }

           S83_Button
                    {
                    text:       "    Сбросить    "
                    btn_color:  current_theme.color_ctrl_main_color
                    onClicked:  dialog_reset_colors_par_disp.visible = true
                    }
           }



}

