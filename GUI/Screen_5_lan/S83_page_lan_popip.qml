import QtQuick 2.15
//import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

ColumnLayout
    {
    clip:       true
    spacing:    8


            Item {height: 8 }

    S83_popip_item
        {
        id: ip_1
        }

    S83_popip_item
        {
        id: ip_2
        }

    S83_popip_item
        {
        id: ip_3
        }

            Item {height: 8}

    Connections
            {
            target: my_app

            function onSig_pop_ip(arg_ip, arg_num_ip, arg_ip_state,arg_nname)
                {//
                if (arg_num_ip === 0)
                    {
                    ip_1.text_ip    = arg_ip
                    ip_1.text_nname = arg_nname
                    if (arg_ip_state)  ip_1.image_icon = "qrc:/Icon/for_page/ip_connect.svg"
                    else               ip_1.image_icon = "qrc:/Icon/for_page/ip_gray.svg"
                    }

                if (arg_num_ip === 1)
                    {
                    ip_2.text_ip    = arg_ip
                    ip_2.text_nname = arg_nname
                    if (arg_ip_state)  ip_2.image_icon = "qrc:/Icon/for_page/ip_connect.svg"
                    else               ip_2.image_icon = "qrc:/Icon/for_page/ip_gray.svg"
                    }

                if (arg_num_ip === 2)
                    {
                    ip_3.text_ip    = arg_ip
                    ip_3.text_nname = arg_nname
                    if (arg_ip_state)  ip_3.image_icon = "qrc:/Icon/for_page/ip_connect.svg"
                    else               ip_3.image_icon = "qrc:/Icon/for_page/ip_gray.svg"
                    }
                }

            }
    }
