import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



ColumnLayout
{
    clip:       true
    spacing:    0
    S83_parametr_classic
        {
        id:             par_con_state
        Layout.fillWidth: true
        text_label:     "Состояние:"
        text_value:     "отключено"
        }
    S83_parametr_classic
        {
        id:                 par_byte_send
        text_label:         "Байт отправлено:"
        Layout.fillWidth:   true
        text_value:         "-"
        }
    S83_parametr_classic
        {
        id:                 par_byte_rcv
        Layout.fillWidth:   true
        text_label:         "Байт принято:"
        text_value:         "-"
        }
    S83_parametr_classic
        {
        id:                 par_disconnect_count
        Layout.fillWidth:   true
        text_label:         "Умышленно разорвано (раз):"
        text_value:         "-"
        }
    S83_parametr_classic
        {
        id:                 par_clients_count
        Layout.fillWidth:   true
        text_label:         "Клиентов подключено:"
        text_value:         "-"
        }

    Connections
        {
        target: my_app

        function onSig_connected(arg_ip)
            {
            par_con_state.text_label    = "Подключено к:"
            par_con_state.text_value    = arg_ip
            par_con_state.value_warning = false
            }

        function onSig_connecting_start(arg_ip)
            {
            par_con_state.text_label    = "Подключение к:"
            par_con_state.text_value    = arg_ip
            par_con_state.value_warning = true
            }

        function onSig_disconnected()
            {
            par_con_state.text_label    = "Состояние:"
            par_con_state.text_value=     "отключено"
            par_con_state.value_warning = true
            }
          }

    //Таймер обновления некоторых значений
    Timer
        {
        id:         timer_get_trafik
        interval:   1000
        repeat:     true
        running :   true
        onTriggered:
            {
            par_byte_rcv.text_value     = my_app.slot_get_rcv_bytes()
            par_byte_send.text_value    = my_app.slot_get_send_bytes()
            par_disconnect_count.text_value = disconect_count
            par_clients_count.text_value = client_count
            }
        }



}
