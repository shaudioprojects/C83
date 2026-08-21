import QtQuick 2.0


    Item
    {
        height: 0
        id: disp_ids

        readonly property int dp_NO:         0  //Без дисплея
        readonly property int dp_SPI:        1  //SPI
        readonly property int dp_USB:        2  //На плате USBEB
        readonly property int dp_DRM:        3  //DRM дисплей
    }

