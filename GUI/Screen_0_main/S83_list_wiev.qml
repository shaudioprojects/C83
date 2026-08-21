import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"


ListView {

    id:     listViewFile
    width:  398
    height: 245
    clip:   true
    property int current_index: 0

    Connections
        {
        target: my_app
        function onSig_set_index_0(arg_index)
                {
                //console.log("in: Курсор: " + arg_index)
                current_index = arg_index
                listViewFile.positionViewAtIndex(arg_index, ListView.Visible)
                //listViewFile.currentIndex = arg_index
                }
        function onSig_set_index_1(arg_index)
                {
                //console.log("in: Курсор в центр списка: " + arg_index)
                current_index = arg_index
                listViewFile.positionViewAtIndex(arg_index, ListView.Center)
                //listViewFile.currentIndex = arg_index
                }

        }

    ScrollBar.vertical:S83_VerticalScrollBar { }

    //function setCurrentIndex(newCurrentIndex)
    //      {
    //      listViewFile.currentIndex = newCurrentIndex
    //      listViewFile.positionViewAtIndex(listViewFile.currentIndex, listViewFile.Beginning)
    //      }


    // Для функции positionViewAtIndex
    //selectedHighlightBegin
    //listViewFile.StrictlyEnforceRange

    //highlightRangeMode:  listViewFile.StrictlyEnforceRange
   // highlightRangeMode:  listViewFile.ApplyRange

    //highlightFollowsCurrentItem: true

    spacing: 1

    boundsBehavior: Flickable.OvershootBounds
    boundsMovement: Flickable.StopAtBounds

    anchors.bottomMargin:   5
    anchors.rightMargin:    5
    anchors.leftMargin:     5
    anchors.topMargin:      5

    delegate: S83_list_wiev_item  {   }
    model: my_app_list_model //из слоя С++

}
