import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls


ScrollBar
{
    implicitWidth:  6
    id:             verticalScrollBar
    active:         pressed
    orientation:    Qt.Vertical
    opacity:        active ? 1:0
    Behavior on opacity {NumberAnimation {duration: 500}}

    contentItem: Rectangle
        {
        color:  "gray"
        radius: 2
        implicitHeight: parent.height
        }
}
