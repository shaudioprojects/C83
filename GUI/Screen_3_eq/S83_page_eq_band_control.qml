import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_Slider_01
{
    S83_tools {id: tools }

    id:                     slider_eq

    Layout.fillHeight:      true
    Layout.topMargin:       16
    Layout.bottomMargin:    16
    snapMode: Slider.SnapOnRelease

    from:   -12
    value:  -12
    to:     0
    stepSize: 1

    orientation:  Qt.Vertical
    color_slider: current_theme.color_ctrl_main_color

    property alias  band_name:  txt_1.text
    property alias  band_value: slider_eq.value
    property string band_unit:  " дБ"

    signal moved_finished()

    Text
    {
        id: txt_1
        anchors.top:        parent.top
        anchors.topMargin:  - 13
        text:   "0"
        color:  "white"
        font.pixelSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Text
    {
        id: txt_2
        anchors.bottom:         parent.bottom
        anchors.bottomMargin:   -13
        text:                   tools.round(value,1) + band_unit
        color:                  "white"
        font.pixelSize:         12
        anchors.horizontalCenter: parent.horizontalCenter
    }

    onPressedChanged:
        {
        if (pressed === false)
            {

            moved_finished()
            }
        else
            {

            }
        }
}
