import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

//Перемотка
Rectangle
{
    width:          100 // parent.width
    height:         50
    color:          "transparent"
    radius: 5

    property alias  slider_value: slider_time.value
    property int    time_current: 0
    property int    time_duration: 0

    function convert_time(arg_time_sec)
        {
        var tmp_time = "";

               let tmps,h,m,s;

                if (arg_time_sec < 0) arg_time_sec = 0;

                tmps = arg_time_sec % 3600;
                h = Math.floor(arg_time_sec / 3600);
                m = Math.floor(tmps/60);
                s= tmps % 60;

                if (h)
                        {
                        if(h > 99) h=99;
                        tmp_time = h;
                        tmp_time += ':';
                        }

                if (m || (h!=0) )
                        {
                        if (h)
                            {
                            if (m<10) tmp_time += "0";
                            tmp_time += m;
                            }
                        else tmp_time = m;

                        tmp_time += ':';
                        }

                if (!h && !m)
                        {
                        tmp_time = s;
                        }
                else
                        {
                        if (s<10) tmp_time += "0";
                        tmp_time += s;
                        }

                return tmp_time;
        }



    S83_slider_and_parametrs
        {
        id:                     slider_time
        from:                   0
        to:                     100

        property bool   flag_propusk:   false
        property int    tmp_sec:        0

        parametr_name:          "Позиция:"
        parametr_name_2:        "Длительность:"
        parametr_value:         "-"
        parametr_value_2:       "-"
        parametr_value_suffix:  ""
        parametr_value_suffix_2:" %"


        anchors.left:           parent.left
        anchors.right:          parent.right


        function event_moved()
            {
            tmp_sec = value * time_duration / 100;
            parametr_value = convert_time(Math.floor(tmp_sec));
            }

        function event_moved_end()
            {
            my_app.slot_seek_sec(Math.floor(tmp_sec))
            console.log("Позиционирование: " + Math.floor(tmp_sec) + " sec, [" + Math.floor(value) + " %]")//moved_end()
            flag_propusk = true
            }
        }




    Connections
        {
            target: my_app

            function onSig_disconnected()
                {
                var defice = "-"
                slider_time.parametr_value    = defice
                slider_time.parametr_value_2  = defice
                slider_time.value = 0
                }

            //Пришло время
            function onSig_time_current(arg_time)
                {
                timer_no_rcv_command.restart_timer();
                time_current = arg_time

                if (slider_time.flag_propusk)
                    {
                    slider_time.flag_propusk = false
                    return
                    }

                //Не нажато
                if (!slider_time.pressed)
                    {
                    slider_time.parametr_value  = convert_time(arg_time)
                    //slider_time.parametr_value += " / "
                    //slider_time.parametr_value += convert_time(time_duration)

                    if (time_duration < 1 )
                        {
                        slider_time.parametr_value_2 = 0
                        slider_time.value = 0
                        }
                    else
                        {
                        var percent = arg_time * 100 /  time_duration
                        slider_time.value = percent


                        slider_time.parametr_value_2 = convert_time(time_duration)
                        }
                    }
                }

            //Пришла длительность
            function onSig_time_duration(arg_time)
                {
                time_duration = arg_time
                }
        }

}
