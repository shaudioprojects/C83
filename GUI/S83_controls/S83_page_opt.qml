import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls

//Шаблон страницы для каких либо настроек приложения
Page
    {
    id:             page_opt
    property alias  content_sourse:     work_area.source
    property alias  content_component:  work_area.sourceComponent
    property bool   block_mode:  true   //Блокировать когда соединение не установлено

    //фон
    Rectangle
        {
        id:             bk_rect
        anchors.fill:   parent
        color:          current_theme.color_background
        z:-1
        }

    //Затемнялка 1
    S83_block_screen
        {
        visible:        !state_conected && block_mode
        image_src:      "qrc:/Icon/for_page/disconnect.svg"
        message_src:    "Соединение не установлено."
        height:         button_ok.y-5
       // block_mode:     page_opt.block_mode
        }

    //Затемнялка 2
    S83_block_screen
        {
        visible:        state_conected && state_no_responce && block_mode
        image_src:      "qrc:/Icon/for_page/no_server_data.svg"
        message_src:    "Сервер не отвечает."
        height:         button_ok.y-5
       // block_mode:     page_opt.block_mode
        }

    Flickable
            {
           id:      flk
           width:   parent.width
           height:  button_ok.y-5
           clip:    true

           contentWidth:    work_area.width
           contentHeight:   work_area.item.height

           boundsBehavior:  Flickable.OvershootBounds
           boundsMovement:  Flickable.StopAtBounds

           ScrollBar.vertical: S83_VerticalScrollBar  { }

           Loader
                {
                   id:      work_area
                   width:   bk_rect.width
                }



            }
    //Кнопка закрытия внизу
    Rectangle
        {
        id:             button_ok
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        height: 		60
        color:          current_theme.color_ctrl_background

        //Кнопка выхода
        S83_Button
            {
            btn_color:          current_theme.color_ctrl_main_color
            anchors.centerIn:   parent
            width:              200
            height:             50
            x:                  parent.width/2 - width/2
            text:               "OK"
            onClicked:          stack_view.pop(page_main)
            }
        }
    }


