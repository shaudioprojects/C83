import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

Item
{
    anchors.left:   parent.left
    anchors.right:  parent.right
    anchors.top:    parent.top
    height:         255

    S83_parametr_classic
        {
        id:             par_balance
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        text_label:     "Баланс:"
        text_value:     "-"
        }

    property int    balance_pos_y: 15
    property real   balance_max: 0
    property real   step_volume: 0.1


    S83_Button
        {
        id:     btn_reset_balance
        width:  20
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        text:   "R"
        y:      balance_pos_y + 10
        onClicked:
            {
            sl_bal_left.value = 0
            sl_bal_right.value = 0
            my_app.slot_balance(0)
            }
        btn_color: current_theme.color_ctrl_main_color
        }

    S83_Slider_01
        {
        id:             sl_bal_left
        anchors.left:   parent.left
        anchors.right:  btn_reset_balance.left
        width:          parent.width/2
        y:              balance_pos_y
        rotation:       180

        color_slider: current_theme.color_ctrl_main_color

        from:   0
        value:  1
        to:     100

        onMoved:
            {
            sl_bal_right.value = 0
            upd_balance_label( Math.round(value * balance_max / 10 *-1) / 10 )
            }

        onPressedChanged:
            {
            if (pressed === false)
                {
                my_app.slot_balance(sl_bal_left.value * -1)
                par_balance.color_value = current_theme.color_ctrl_parametr_value
                }
            else
                {
                par_balance.color_value = current_theme.color_ctrl_parametr_value_warning
                }
            }
        }

    S83_Slider_01
        {
        id:             sl_bal_right
        anchors.left:   btn_reset_balance.right
        anchors.right:  parent.right

        color_slider: current_theme.color_ctrl_main_color

        from:   0
        value:  1
        to:     100

        width:  parent.width/2
        y:      balance_pos_y

        onMoved:
            {
            sl_bal_left.value = 0
            upd_balance_label( Math.round(value * balance_max / 10) / 10 )
            }

        onPressedChanged:
            {
            if (pressed === false)
                {
                my_app.slot_balance(sl_bal_right.value)
                par_balance.color_value = current_theme.color_ctrl_parametr_value
                }
            else
                {
                par_balance.color_value = current_theme.color_ctrl_parametr_value_warning
                }
            }
        }

    S83_parametr_classic
        {
        id:             par_balance_2
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    sl_bal_right.bottom
        anchors.topMargin:  -32

        text_value_1:   "-"
        text_value_2:   "-"
        color_value_1:  "gray"
        color_value_2:  "gray"


        }

    function upd_balance_label(arg_value)
        {

        if (arg_value < 0)
            {
            let tmp_num = tools.round(tools.krat(arg_value,step_volume),10)
            par_balance.text_value = tmp_num.toFixed(1)
            par_balance.text_value += " : 0.0  дб"
            }

        if (arg_value > 0)
            {
            let tmp_num = tools.round(tools.krat(arg_value *-1 ,step_volume),10)
            par_balance.text_value = "0.0 : "
            par_balance.text_value += tmp_num.toFixed(1)
            par_balance.text_value += "  дБ"
            }

        if (arg_value === 0)
            {
            par_balance.text_value =  par_balance.text_value = "0.0 : 0.0 дБ"
            }

        }

    function upd_min_max_admin_volume_label(arg_min,arg_max)
        {
        let tmp_num1 = tools.round(tools.krat(arg_min,step_volume),10)
        let tmp_num2 = tools.round(tools.krat(arg_max,step_volume),10)
        par_range_1.text_value = tmp_num1.toFixed(1)
        par_range_1.text_value += " : "
        par_range_1.text_value += tmp_num2.toFixed(1)
        par_range_1.text_value += " дБ"
        }



    Connections
        {
        target: my_app

        function onSig_balance(arg_value, arg_bal_state)
                {
                console.log("Баланс: " + arg_value)
                if (arg_value < 0)
                    {
                    sl_bal_right.value  = 0
                    sl_bal_left.value   = arg_value * -1
                    }

                if (arg_value === 0)
                    {
                    sl_bal_left.value   = 0
                    sl_bal_right.value  = 0
                    }

                if (arg_value > 0)
                    {
                    sl_bal_left.value   = 0
                    sl_bal_right.value  = arg_value
                    }

                if (arg_bal_state)
                    {
                    sl_bal_right.enabled = true
                    sl_bal_left.enabled = true
                    btn_reset_balance.enabled = true
                    par_balance.enabled = true
                    }
                else
                    {
                    sl_bal_right.enabled = false
                    sl_bal_left.enabled = false
                    btn_reset_balance.enabled = false
                    par_balance.enabled = false
                    }
                }

        function onSig_balance_db(arg_value_db)
                {
                upd_balance_label(arg_value_db )
                }

        function onSig_balance_max_db(arg_value_db)
                {
                //console.log("Баланс - максимальное значение: " + arg_value_db)
                balance_max = Math.abs(arg_value_db)
                let tmp_num1 = tools.round(balance_max * -1,10)
                par_balance_2.text_value_1 = tmp_num1.toFixed(1)
                par_balance_2.text_value_1 += " дБ"

                par_balance_2.text_value_2 = par_balance_2.text_value_1
                }

        ///////////////////////////////////////////////////////////////////////////////

        //min,max db
        function onSig_adm_vol_db(arg_min,arg_max)
            {
            console.log("in: Пределы регулировки громкости: [" + arg_min + " : " + arg_max + "] дБ")
            sl_range.setValues(arg_min,arg_max )
            upd_min_max_admin_volume_label(sl_range.first.value,sl_range.second.value)
            }




        //limit
        function onSig_adm_vol_limit_db(arg_min,arg_max)
            {
            console.log("in: Лимиты громкости: [" + arg_min + " : " + arg_max + "] дБ")
            sl_range.from = arg_min
            sl_range.to = arg_max

            let tmp_val_min = tools.round(arg_min,10)
            let tmp_val_max = tools.round(arg_max,10)
            par_range_2.text_value_1 = tmp_val_min.toFixed(1)
            par_range_2.text_value_1 += " дБ"

            par_range_2.text_value_2 = tmp_val_max.toFixed(1)
            par_range_2.text_value_2 += " дБ"

            }

        //Шаг усиления
        function onSig_vol_step_db(arg_value_db)
            {
            if (arg_value_db < 0.1) arg_value_db = 0.1

            step_volume = arg_value_db
            let tmp_step = tools.round(arg_value_db,10);
            par_step.text_value = tmp_step.toFixed(1)
            par_step.text_value += " дБ";
            console.log("in: Шаг усиления: [" +  par_step.text_value +"] дБ")
            }

        //Усиление db
        function onSig_volume_db(arg_value_db)
            {
            let tmp_g = tools.round(arg_value_db,10);
            par_vol_db.text_value = tmp_g.toFixed(1);
            par_vol_db.text_value +=" дБ"
            }

        //Регулятор громкости
        function onSig_vreg_id(arg_vreg_id,arg_vreg_name)
            {
            par_vreg_id.text_value = arg_vreg_name
            console.log("in: Регулятор громкости: [" +  arg_vreg_name +"]")
            }

        }




    /////////////////////////////////////////////////////////////////////////////////////////////

    S83_parametr_classic
        {
        id:             par_range_1
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: sl_range.top
        anchors.bottomMargin: -28
        text_label:     "Пределы усиления:"
        text_value:     "-"
        warning_metod: 1
        }


    S83_RangeSlider
        {
        id:     sl_range

        from:   0
        to:     100

        first.value:    10
        second.value:   90

        color_slider:   current_theme.color_ctrl_main_color
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    sl_bal_right.bottom

        anchors.topMargin: 22

        first.onMoved:
            {
            upd_min_max_admin_volume_label( sl_range.first.value,  sl_range.second.value )
            }

        second.onMoved:
            {
            upd_min_max_admin_volume_label( sl_range.first.value,  sl_range.second.value )
            }

        function send_admin_volume ()
            {
            console.log("out: Пределы регулирования громкости: [" + tools.round(tools.krat(first.value,step_volume),10) + " : " + tools.round(tools.krat(second.value,step_volume),10) + "] дБ")
            my_app.slot_admin_volume(tools.round(tools.krat(first.value,step_volume),10), tools.round(tools.krat(second.value,step_volume),10))
            }

        first.onPressedChanged:
            {
            if (first.pressed === false)
                {
                send_admin_volume()
                par_range_1.value_warning = false
                }
            else
                {
                sl_range.first.onMoved()
                par_range_1.value_warning = true
                }
            }

        second.onPressedChanged:
            {
            if (second.pressed === false)
                {
                send_admin_volume()
                par_range_1.value_warning = false
                }
            else
                {
                sl_range.second.onMoved()
                par_range_1.value_warning = true
                }
            }
        }

    S83_parametr_classic
        {
        id:             par_range_2
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    sl_range.bottom
        anchors.topMargin:  -32

        text_value_1:   "-"
        text_value_2:   "-"
        color_value_1:  "gray"
        color_value_2:  "gray"
        }

    S83_parametr_classic
        {
        id:             par_step
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    par_range_2.bottom
        anchors.topMargin: -8
        text_label:     "Шаг усиления:"
        text_value:     "-"
        }

    S83_parametr_classic
        {
        id:             par_vol_db
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    par_step.bottom
        anchors.topMargin: -8
        text_label:     "Усиление:"
        text_value:     "-"
        }

    S83_parametr_classic
        {
        id:             par_vreg_id
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    par_vol_db.bottom
        anchors.topMargin: -8
        text_label:     "Регулятор громкости:"
        text_value:     "-"
        }
}
