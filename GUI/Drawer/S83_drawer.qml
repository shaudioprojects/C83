import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

S83_Drawer
    {
    id: drawer


    Flickable
           {
           id:                  flk
           //якоря чего то не фурычат

           y:   5
           width:               parent.width
           height:              parent.height - y*2
           clip:                true

           contentWidth:        cl_drawer_items.width
           contentHeight:       cl_drawer_items.height

           boundsBehavior:      Flickable.OvershootBounds
           boundsMovement:      Flickable.StopAtBounds

           ScrollBar.vertical:  S83_VerticalScrollBar  { }









        ColumnLayout
            {
            id:                     cl_drawer_items

            anchors.leftMargin:     5
            anchors.bottomMargin:   5

            anchors.left:           parent.left
            anchors.right:          parent.right
            anchors.top:            parent.top

            spacing:                0

            //Вызвать страницу основные опции
            S83_drawer_item
                {
                id:         item_osn_opt
                width:      parent.width
                item_text:  "Основные опции"
                item_icon:  "qrc:/Icon/for_drawer/dr_main_options.svg";
                onItemClicked:
                    {
                    stack_view.push(page_option_main)
                    }
                }

            //Громкости
            S83_drawer_item
                {
                id:         item_volumes
                visible:    true
                item_text:  "Громкости"
                item_icon:  "qrc:/Icon/for_drawer/dr_speaker.svg";
                onItemClicked:
                    {
                    stack_view.push(page_volumes)
                    }
                }

            //Эквалайзер
            S83_drawer_item
                {
                id:             item_eq
                visible:        true
                item_text:      "Эквалайзер"
                item_icon:      "qrc:/Icon/for_drawer/dr_eq.svg";
                onItemClicked:
                    {
                    stack_view.push(page_eq)
                    }
                }

            //Аудиокарта
            S83_drawer_item
                {
                id:         item_acard
                visible:    true
                item_text:  "Аудиокарта"
                item_icon:   "qrc:/Icon/for_drawer/dr_chip.svg"
                onItemClicked:
                    {
                    stack_view.push(page_acard)
                    }
                }

            //Другие устройства
            S83_drawer_item
                {
                id:        item_devs
                visible:   true
                item_text: "Другие устройства"

                item_icon: "qrc:/Icon/for_drawer/dr_devices.svg";
                onItemClicked:
                    {
                    stack_view.push(page_dev)
                    }
                }

            //Сеть
            S83_drawer_item
                {
                id:        item_lan
                item_text: "Сеть"
                item_icon: "qrc:/Icon/for_drawer/dr_lan.svg";
                onItemClicked:
                    {
                    stack_view.push(page_lan)
                    }
                }

            S83_drawer_item
                {
                id:        item_colors
                visible:   true
                item_text: "Цвета"
                item_icon: "qrc:/Icon/for_drawer/dr_colors.svg";
                onItemClicked:
                    {
                    stack_view.push(page_colors)
                    }
                }

            S83_drawer_item
                {
                id:        item_info
                visible:   true
                item_text: "Информация"
                item_icon: "qrc:/Icon/for_drawer/dr_info.svg";
                onItemClicked:
                    {
                    stack_view.push(page_info)
                    }
                }

            S83_drawer_item
                {
                id:         item_s83
                item_text:  "Дополнительно"
                item_icon:  "qrc:/Icon/for_drawer/dr_batanik.svg";
                onItemClicked:
                    {
                    stack_view.push(page_s83)
                    }
                }

            S83_drawer_item
                {
                id:         item_poff
                item_text:  "Завершение работы"
                item_icon:  "qrc:/Icon/for_drawer/dr_poweroff.svg";
                onItemClicked:
                    {
                    dialog_off.visible = true
                    }
                }
            }
    }
}
