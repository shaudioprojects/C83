import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"


ListView {

    id:     list_alsa_ch
    width:  398
    height: count * height_item + 5
    clip:   true

    property string selected_name: "-1"
    property int    height_item:   32           //Высота итемов

    ScrollBar.vertical:     S83_VerticalScrollBar { }

    spacing:                1


    boundsBehavior:         Flickable.OvershootBounds
    boundsMovement:         Flickable.StopAtBounds

    anchors.bottomMargin:   5
    anchors.rightMargin:    5
    anchors.leftMargin:     5
    anchors.topMargin:      5

    delegate:   S83_list_alsa_ch_item {   }
    model:      my_app_alsa_vregch   //имя заданное из слоя С++



    Connections
        {
        target: my_app
        function onSig_select_alsa_ch(arg_num)
            {
            list_alsa_ch.currentIndex = arg_num
           // selected_name = arg_name
            console.log("in: Выбрать канал ALSA: №" + arg_num)
            list_alsa_ch.positionViewAtIndex(arg_num, ListView.Center)
            }

        }

}
