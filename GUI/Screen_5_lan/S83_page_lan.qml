import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_lan

    content_component:
    ColumnLayout
        {
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top

            //height:         275 //Проверить прокруткой страницы
            //height:         365 //Проверить прокруткой страницы
        clip:           true
        spacing:        0

        S83_parametr_group
            {
            name_group:    "Настройки подключения"

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            content_component:   S83_page_lan_content_ip  {  }
            }

        S83_parametr_group
            {
            name_group:    "Популярные IP"

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            content_component: S83_page_lan_popip {  }
            }

        S83_parametr_group
            {
            name_group:    "Информация"

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            content_component:  S83_page_lan_content_trafik { }
            }


/*

        S83_parametr_group
            {
            name_group:    "Сокет"

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            content_component:  S83_page_lan_content_fordev { }
            }
*/
        }

    }


