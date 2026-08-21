import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

import "./GUI/Screen_0_main"
import "./GUI/Screen_1_main_option"
import "./GUI/Screen_2_volumes"
import "./GUI/Screen_3_eq"
import "./GUI/Screen_4_acard"
import "./GUI/Screen_5_lan"
import "./GUI/Screen_6_colors"
import "./GUI/Screen_7_info"
import "./GUI/Screen_8_poff"
import "./GUI/Screen_9_dev"
import "./GUI/Screen_10_for_s83"
import "./GUI/Drawer"
import "./GUI/Context_menu"
import "./GUI/S83_controls"
import "./GUI/S83_dialogs"


Window {
    id: rootWindow



    width:          400
    height:         800

   // minimumHeight:  140
   // minimumWidth:   140//480
    minimumWidth:   300
    minimumHeight:  300


    color:      "black"
    visible:    true
    title:      qsTr("C83")

    property bool   state_conected:     false       //Соединение установлено
    property bool   state_no_responce:  false       //Нет ответа от сервера
    property int    disconect_count:    0           //Умышленно разорвано раз
    property int    client_count:       0           //Клиентов подключено
    property alias  current_theme:      curr_thm
    property string version_name:       "2.37"      //Выставить такую же в манифесте
    property bool   orientation:        false

    onWidthChanged:     orientation = width > height
    onHeightChanged:    orientation = width > height


    //Текущей цветовое оформление (не закончено)
    S83_theme
        {
        id: curr_thm
        }

    //Для управления страницами
    StackView
        {
        id:             stack_view
        anchors.fill:   parent
        initialItem:    page_main
        }

    S83_tools
        {
        id:tools
        }

    //Страницы
    //0
    S83_page_main
        {
        id: page_main
        visible: true
        }
    //1
    S83_page_options_main
        {
        id: page_option_main
        visible: false
        }
    //2
    S83_page_volumes
        {
        id: page_volumes
        visible: false
        }
    //3
    S83_page_eq
        {
        id: page_eq
        visible: false
        }
    //4
    S83_page_acard
        {
        id: page_acard
        visible: false
        }
    //5
    S83_page_lan
        {
        id:         page_lan
        block_mode: false           //Не блокировать
        visible:    false
        }
    //6
    S83_page_colors
        {
        id:         page_colors
        visible:    false
        }
    //7
    S83_page_info
        {
        id:         page_info
        block_mode: false          //Не блокировать
        visible:    false
        }
    //8
    S83_page_poff
        {
        id:         page_poff
        visible:    false
        }
    //9
    S83_page_dev
        {
        id:         page_dev
        visible:    false
        }

    //10 для разработчика
    S83_page_for_s83
        {
        id:         page_s83
        visible:    false
        block_mode: false          //Не блокировать
        }
//Уход или приход фокуса приложения
//onActiveFocusItemChanged:
//{
//console.log("Событие onActiveFocusItemChanged")
//}

//Сообщение пользователю
S83_dialog_ok
    {
    id: mbox_dialog
    }

//Контекстное меню
S83_ctx_menu
    {
    id: ctx_menu


    }

//Диалог Завершить работу системы
S83_dialog_ok_cancel
    {
    id:                 dialog_off
    anchors.centerIn:   parent
    text_content:       "Завершить работу системы?"
    onAccepted:
        {
        my_app.slot_poff()              //Серверу команда завершится
        my_app.slot_prepare_for_exit()  //Сохраняемся
        Qt.quit()                       //Завершение QML
        }
    }

//Диалог Завершить работу AC
S83_dialog_ok_cancel
    {
    id:                 dialog_acoff
    anchors.centerIn:   parent
    text_content:       "Завершить работу AC?"
    onAccepted:         my_app.slot_poff_ac()
    }

//Диалог задать стартовый путь
S83_dialog_ok_cancel
    {
    id:                 dialog_start_path
    anchors.centerIn:   parent
    text_content:       "Задать текущий каталог как путь к каталогу с аудио?"
    onAccepted:         my_app.slot_set_start_path()
    }

//Диалог создания нового плейлиста
S83_dialog_text_edit
    {
    id: dialog_new_playlist
    anchors.centerIn: null

    x: (parent.width - width) / 2
    y: (parent.height - height) /2

    onAccepted:
        {
        console.log("out: Новый список: " + text_edit)
        my_app.slot_new_pls(text_edit)
        text_edit = name_default_playlist
        }
    }

//Диалог переименования
S83_dialog_text_edit
    {
    id: dialog_rename
    anchors.centerIn: null

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    onAccepted:
        {
        console.log("out: Переименовать. Новое имя: " + text_edit)
        my_app.slot_rename(text_edit)
        text_edit = "Новое имя"
        }
    }

//Долог выбора цвета файлов
S83_dialog_colors
    {
    id: dlg_colors
    property int id_target_color: -1

    function set_start_cond( arg_id, arg_color)
        {
        id_target_color = arg_id
        current_color   = arg_color
        }

    onAccepted:
        {
        console.log("out: Изменить цвет файла. id: " + id_target_color + " color: "+ get_new_color())
        my_app.slot_set_color_file(id_target_color,get_new_color())
        }
    }
//Диалог сброса цветов файлов
S83_dialog_ok_cancel
    {
    id:                 dialog_reset_colors
    anchors.centerIn:   parent
    text_content:       "Сбросить значения цветов файлов?"
    onAccepted:         my_app.slot_reset_colors_file()
    }

S83_toast
    {
    id: my_toast
    anchors.centerIn: parent
    }
//Долог выбора цвета параметров на дисплее
S83_dialog_colors
    {
    id: dlg_colors_par_disp
    property int id_target_color: -1

    function set_start_cond( arg_id, arg_color)
        {
        id_target_color = arg_id
        current_color   = arg_color
        }

    onAccepted:
        {
        console.log("out: Изменить цвет параметра дисплея. id: " + id_target_color + " color: "+ get_new_color())
        my_app.slot_set_color_parametr_disp(id_target_color,get_new_color())
        }
    }

//Диалог сброса цветов параметров на дисплее
S83_dialog_ok_cancel
    {
    id:                 dialog_reset_colors_par_disp
    anchors.centerIn:   parent
    text_content:       "Сбросить значения цветов параметров на дисплее?"
    onAccepted:         my_app.slot_reset_colors_parametr_disp()
    }

Connections
  {
    target: Qt.application


    function onStateChanged()
        {
       // console.log("Событие Qt.application.onStateChanged => " + Qt.application.state)
        if (Qt.application.state === 2)
            my_app.slot_set_mode_pause()
        if (Qt.application.state === 4)
            my_app.slot_set_mode_play()
        }
  }

//Таймер Проверяет приходят ли данные от сервера
Timer
     {
     id:        timer_no_rcv_command
     property int timer_count: 0
     interval:  500
     repeat:    true

     function stop_timer()
        {
        //console.log("event: Таймер останавливаем.")
        stop()
        timer_count = 0
        }

     function restart_timer()
        {
         state_no_responce = false //Разблокировать UI
         timer_count = 0
         restart()
        }

     function start_timer()
        {
        //console.log("event: Таймер запускаем.")
        start()
        }

     onTriggered: 
        {
        timer_count++
        if  (timer_count === 5) //2.5 сек
            {
            state_no_responce = true //Заблокировать UI
            console.log("event: Что-то не приходят данные.")
            }

         if  (timer_count === 13)
            {
            console.log("event: Перезапуск соединения.")
            my_toast.show("Разрываем соединение",3000)
            disconect_count++
            stop_timer()
            my_app.slot_disconnect()
            }

        }

     }

Connections
        {
        target: my_app

        function onSig_connected()
            {
            state_conected      = true
            state_no_responce   = false         //Разблокировать UI
            timer_no_rcv_command.start_timer()
            }

        function onSig_message_box(arg_text_1,arg_text_2,arg_flags)
            {
            if (arg_flags === 0)
                {
                mbox_dialog.visible = true;
                mbox_dialog.text_content = arg_text_1 + arg_text_2
                }
            else my_toast.show(arg_text_1,2500)
            }

        function onSig_client_count(arg_count)
            {
            client_count = arg_count
            }

        function onSig_disconnected()
            {
            client_count = 0
            state_conected  = false
            timer_no_rcv_command.stop_timer()

            }
       }

Component.onCompleted:
    {
        my_app.slot_start()
    }

}


