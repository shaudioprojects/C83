import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

ColumnLayout
    {
    property int kb_id:     0
    spacing:                0
    Layout.alignment:       Qt.AlignHCenter | Qt.AlignTop

    S83_parametr_classic
        {
        id:                 pc_kb
        Layout.fillWidth:   true
        text_label:         "Текущая клавиатура:"
        text_value:         "."
        }

    S83_warning
        {
        id:                 dev_warning

        Layout.fillWidth:   true
        text:               "Это устройство не имеет настроек."

        }


    Connections
        {
        target: my_app

        function onSig_kb_id(arg_id,arg_name)
            {
            kb_id               = arg_id
            pc_kb.text_value    = arg_name
            }
        }
}
