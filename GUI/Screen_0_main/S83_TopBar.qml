import QtQuick 2.15
import QtQuick.Window 2.15
import "../S83_controls"


Rectangle
    {
    property int def_margin: 5
    property real rect_opacity:   0.85
    id:         topBar
    visible:    true
    width:      100
    height:     40
    color:      current_theme.color_ctrl_background
    radius:     5

    anchors.rightMargin:    def_margin
    anchors.leftMargin:     def_margin - 1
    anchors.topMargin:      def_margin




    Text
        {
        id: textAppState
        text: " "
        color: "#ffffff"
        font.pixelSize: 18

        anchors.left:           parent.left
        anchors.right:          parent.right
        anchors.leftMargin:     8
        anchors.rightMargin:    40//def_margin
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -2
        elide: Text.ElideRight
        //wrapMode: "WordWrap"


        onTextChanged:
            {
            na_str_state.start()
            }
        //Анимация Появления
        NumberAnimation
            {
            id:         na_str_state
            target:     textAppState
            property:   "opacity"
            from:   0
            to:     1
            duration: 300 // длительность анимации в миллисекундах
            }

        }

    Connections
        {
        target: my_app

        function onSig_status_label(arg_text,arg_color)
            {
            textAppState.text   = arg_text

            }
        function onSig_connected(arg_ip)
            {
            textAppState.color  = "white"
            topBar.color        =  tools.colorWithOpacity(current_theme.color_ctrl_background,rect_opacity)
            //na_str_state.start()
            }
        function onSig_connecting_start(arg_ip)
            {
            textAppState.color  =  Qt.lighter("white", 0.6)
            topBar.color        =  tools.colorWithOpacity(current_theme.color_ctrl_background,rect_opacity)
            //na_str_state.start()
            }
        function onSig_disconnected()
            {
            textAppState.color  = "white"
            topBar.color        = "#88550000"
            //na_str_state.start()
            }
        }

}
