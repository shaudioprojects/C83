import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

S83_Slider_01
    {
    id: control

    property alias  parametr_name:              pcl_top.text_label
    property alias  parametr_name_color:        pcl_top.color_label
    property alias  parametr_value:             pcl_top.text_value
    property alias  parametr_value_color:       pcl_top.color_value

    property alias  parametr_name_2:            pcl_bottom.text_label
    property alias  parametr_name_2_color:      pcl_bottom.color_label
    property alias  parametr_value_2:           pcl_bottom.text_value
    property alias  parametr_value_2_color:     pcl_bottom.color_value

    property string parametr_value_suffix:      "."
    property string parametr_value_suffix_2:    "."
    property bool   disable_bottom_warning:     false

    from:   0
    to:     100

    color_slider: current_theme.color_ctrl_main_color

    S83_parametr_classic
        {
        id:                 pcl_top
        width:              parent.width
        anchors.top:        parent.top
        anchors.topMargin:  -10
        lr_margins:         0
        change_padding:     6
        warning_metod:          1
        text_value:         "-"
        }


    S83_parametr_classic
        {
        id:                     pcl_bottom
        width:                  parent.width
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   -6
        lr_margins:             0
        change_padding:         6
        warning_metod:          1
        }



    function event_moved()      { }
    function event_moved_5()    { }
    function event_moved_end()  { }

    function set_value_top(arg_value)
        {
        pcl_top.text_value  = tools.round(arg_value,1)
        pcl_top.text_value += parametr_value_suffix
        }

    function set_value_bottom(arg_value)
        {
        pcl_bottom.text_value  = tools.round(arg_value,1)
        pcl_bottom.text_value += parametr_value_suffix_2
        }

    property  int   ostatok:                0
    property  int   pre_ostatok:            0

    onMoved:
        {
        ostatok = control.position * 100
        ostatok %= 5
        if(ostatok === 0 && pre_ostatok != ostatok)
          {
          event_moved_5()
          //slider_moved() //сигнал
          pre_ostatok = ostatok;
          return
          }
        pre_ostatok = ostatok;
        event_moved();
        }

    //Перемещение закончено
    onPressedChanged:
        {
        if (pressed === false)
            {
            //slider_moved_finish() //сигнал
            event_moved_end()
            pcl_top.value_warning       = false
            pcl_bottom.value_warning    = false
            }
        else
            {
            pcl_top.value_warning       = true
            if (!disable_bottom_warning) pcl_bottom.value_warning    = true
            }
        }
}
