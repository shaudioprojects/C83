import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



Text
    {
        horizontalAlignment: Text.AlignHCenter
        text:           "Текст"
        font.pixelSize: 18
        color:          "white"
        //textFormat:     Text.NoInteraction
        elide:          Text.ElideRight  //Сокращение точками
    }
