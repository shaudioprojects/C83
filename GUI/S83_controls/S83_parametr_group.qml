import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
Rectangle
    {
        id:     rect_pg
        clip:   true
        color:  "transparent"
        height: rect_content.height + text_name_group.height

        property alias name_group:          text_name_group.text
        property alias content_component:   loader_background.sourceComponent
        property alias content_source:      loader_background.source

        Text
            {
            id:         text_name_group
            padding:    10
            anchors.horizontalCenter: parent.horizontalCenter

            text:       "Имя группы параметров"
            color:          Qt.lighter(current_theme.color_ctrl_main_color, 1.35)
            font.weight:    Font.Bold
            font.pixelSize: 18
            }

        Rectangle
                {
                id:             rect_content
                anchors.top:    text_name_group.bottom
                anchors.left:   parent.left
                anchors.right:  parent.right

                anchors.rightMargin:    5
                anchors.leftMargin:     5


                width:  parent.width
                height: loader_background.item ? loader_background.item.height : 0 // Используем тернарный оператор для обработки случая, когда item еще не загружен

                color:  current_theme.color_ctrl_background
                radius: 5

                Loader
                    {
                    id:     loader_background
                    width:  rect_content.width
                    }
                }
    }
