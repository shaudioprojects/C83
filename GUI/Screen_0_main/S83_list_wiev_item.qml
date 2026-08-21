import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12


Rectangle
{
    width:          listViewFile.width - 6
    height:         35



    color:          listViewFile.current_index === index ? current_theme.color_ctrl_cursor          : "transparent"
    border.color:   listViewFile.current_index === index ? current_theme.color_ctrl_cursor_border   : "transparent"
    radius:         5

    property int text_list_item_string_size:    18
    property int def_margin:                    5
    property int text_y_correction:             -2



    function get_icon(icon,flags)
        {
        timer_r.running = false
//        if (flags & 0x20) return "qrc:/Icon/for_file/check.svg";
        switch(icon)
            {
            case 0:     return "qrc:/Icon/for_file/file_back.svg";
            case 1:     return "qrc:/Icon/for_file/folder.ico";
            case 2:     return "qrc:/Icon/for_file/spk.ico";
            case 3:     timer_r.running = true
                        return current_theme.icon_play;
            case 4:     return current_theme.icon_pause;
            case 5:     return "qrc:/Icon/for_file/poff.svg";
            default:    return "qrc:/Icon/for_file/def.ico";
            }
        }


    //Иконка оснавная
    Image
            {
            id:                     icon_file
            width:                  28
            height:                 28
            visible:                true
            anchors.verticalCenter: parent.verticalCenter
            anchors.left:           parent.left
            anchors.leftMargin:     def_margin
            source:                 get_icon(nIc,nFl)
            RotationAnimation
                {
                id:         rotat_play
                 target:     icon_file
                property:   "rotation"
                from: 0
                to:   120
                duration:   1000
                running:    false
                }
            Timer
                {
                id:       timer_r
                interval: 7000
                repeat:   true
                running:  false
                property int state_r: 0
                onTriggered:
                    {
                    if (state_r === 0)
                        {
                        rotat_play.from = 0
                        rotat_play.to   = 120
                        state_r         = 1
                        rotat_play.running = true
                        }

                    if (state_r === 1)
                        {
                        rotat_play.from = 120
                        rotat_play.to   = 240
                        state_r         = 2
                        rotat_play.running = true
                        }
                    if (state_r === 2)
                        {
                        rotat_play.from = 240
                        rotat_play.to = 360
                        state_r = 0
                        rotat_play.running = true
                        }
                    }
                  }
            }


    //Иконка check
    Image
            {
            id:                     icon_check
            width:                  28
            height:                 28

            visible:                nFl & 0x20

            anchors.verticalCenter: parent.verticalCenter
            anchors.left:           parent.left
            anchors.leftMargin:     def_margin
            source:                 "qrc:/Icon/for_file/check.svg"



            }

    Connections
        {
        target: my_app
        function onSig_mark(arg_index,arg_value)
             {
             if (arg_index === model.index)
                {
                //console.log("onSig_mark - " + arg_index +" - "+ arg_value)

                if (arg_value)
                   {
                   icon_check.visible = true
                   //icon_file.source = get_icon(model.nIc,32)
                   }
                else
                   {
                   icon_check.visible = false
                   //icon_file.source = get_icon(model.nIc,0)
                   }
                }
            }
        }

    Rectangle
        {
        id:     rect_bk_text
        width:  parent.width
        height: 50
        color:  "transparent" //"#202020"
        clip:   true  // Обрезаем текст, который выходит за пределы

        anchors.right:                  nE ? text_ext.left : text_ext.right //Если расширение пустое то выравниваем по правому краю расширения
        anchors.left:                   icon_file.right
        anchors.leftMargin:             def_margin
        anchors.rightMargin:            5
        anchors.verticalCenter:         parent.verticalCenter
       // anchors.verticalCenterOffset:   text_y_correction


        //Имя файла сокращенное точками
        Text
            {
            id:     fname_elide
            text:   nF
            color:  nCl
            elide:  Text.ElideRight  //Сокращение точками

            anchors.right:                  parent.right
            anchors.left:                   parent.left
            anchors.verticalCenter:         parent.verticalCenter
            anchors.verticalCenterOffset:   text_y_correction

            font.pixelSize:                 text_list_item_string_size
            visible: !timer_stop.ani_running

            //Анимация Появления

            NumberAnimation
                {
                id:         na_fname_elide
                target:     fname_elide
                property:   "opacity"
                from:       0
                to:         1
                duration:   300 // длительность анимации в миллисекундах
                }
            }

        Timer
            {
            property bool ani_running: false

            id:       timer_stop
            interval: 1000
            repeat:   false
            running:  false

            onTriggered:
                {
                movingText.x = 0
                ani_running  = false
                na_fname_elide.start()
                //console.log("Таймер сработал")
                }
            }

        //Имя файла - двиг. текст
        Text
            {
            id:     movingText
            text:   nF
            color:  nCl
            anchors.verticalCenter:         parent.verticalCenter
            anchors.verticalCenterOffset:   text_y_correction
            clip:   true
            Layout.fillWidth:               true
            //font.bold: true
            font.pixelSize:                 text_list_item_string_size
            visible:                        timer_stop.ani_running

            // Анимация перемещения текста
            NumberAnimation on x
                {
                id:             na_move_text
                from:           0 // Начальная позиция 0
                to:             -1 * Math.abs(movingText.width - rect_bk_text.width) - 10   // Конечная позиция (за пределами слева)
                duration:       calc_duration(movingText.width - rect_bk_text.width)        // Длительность анимации
                //loops:          Animation.Infinite  // Бесконечный цикл
                //easing.type:    Easing.InOutQuad
                running:   listViewFile.current_index === index && movingText.width > rect_bk_text.width

                function calc_duration(arg_value)
                    {
                    var arg_mod = arg_value * 40
                    if ( arg_mod < 500 ) arg_mod = 500
                    //console.log("Длительность анимации: "+ arg_mod +" index: "+index)
                    return arg_mod
                    }


                onStarted:
                    {
                    timer_stop.stop()
                    timer_stop.ani_running = true
                    //console.log("Старт анимация")
                    }

                onStopped:
                    {
                    if (listViewFile.current_index === index)
                        timer_stop.start()
                    else
                        {
                        timer_stop.ani_running  = false
                        movingText.x = 0
                        }
                    //var metrics = TextMetrics.measure(movingText.text, movingText.font);
                    //console.log("Стоп анимация :" + movingText.x)
                    }
                }



            }
        }
        //Расширение
        Text
            {
            id:                             text_ext
            width:                          45
            text:                           nE
            anchors.verticalCenter:         parent.verticalCenter
            anchors.verticalCenterOffset:   text_y_correction

            anchors.right:                  parent.right
            anchors.leftMargin:             def_margin
            anchors.rightMargin:            def_margin
            //font.bold: true
            elide:                          Text.ElideRight
            color:                          nCl
            font.pixelSize:                 text_list_item_string_size
            }

        MouseArea
            {
            anchors.right:  parent.right
            anchors.top:    parent.top
            anchors.bottom: parent.bottom
            anchors.left:   icon_file.right

            onClicked:
                {
                //console.log("out: Курсор. (index): "+ index)
                my_app.slot_click_on_item(index)
                }

            onDoubleClicked:
                {
                //console.log("out: Двойной клик по итему. (index): "+ index)
                my_app.slot_open() //открыть
                }

            onPressAndHold:
                {
                //console.log("out: Запрашиваем контекстное меню. (index): "+ index)
                my_app.slot_click_on_item(index)    //Установим сюда курсор
                my_app.slot_context_menu();         //Запрашиваем контекстное меню
                }
            }
        MouseArea
            {
            anchors.fill:   icon_file

            onClicked:
                {
                console.log("out: Выделить (index): "+ index)
                my_app.slot_mark(index)
                }


            onDoubleClicked:
                {
                //console.log("out: Двойной клик по итему. (index): "+ index)
                my_app.slot_open() //открыть
                }

            onPressAndHold:
                {
                //console.log("out: Запрашиваем контекстное меню. (index): "+ index)
                my_app.slot_click_on_item(index)    //Установим сюда курсор
                my_app.slot_context_menu();         //Запрашиваем контекстное меню
                }
            }


}
