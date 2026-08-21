import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"


ListView
    {
    id:         list_acard
    width:      398
    height:     245
    clip:       true
    spacing:    1

    property string  selected_name: "-1"

    ScrollBar.vertical:     S83_VerticalScrollBar { }

    boundsBehavior:         Flickable.OvershootBounds
    boundsMovement:         Flickable.StopAtBounds

    anchors.bottomMargin:   5
    anchors.rightMargin:    5
    anchors.leftMargin:     5
    anchors.topMargin:      5

    delegate:               S83_list_acard_item  {   }
    model:                  my_app_aout_model //из слоя С++

    onCurrentIndexChanged:
        {
       // console.log("event: onCurrentIndexChanged. Индекс - " + currentIndex)
        positionViewAtIndex(currentIndex, ListView.Center)
        }

    Connections
        {
        target: my_app
        function onSig_select_aout(arg_name)
            {
            selected_name = arg_name
            //console.log("in: Выбрать аудиовыход: " + arg_name)
            }

        }

}
