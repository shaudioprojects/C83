import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

S83_page_opt
    {
    id: page_dev

    content_component:
    Rectangle
            {
            id:     clDevices

            width:  100
            height: update_h()

            color: "transparent"
            clip:   true

            function update_h()
                {
                 return  pgKb.height + pgDisplay.height + pgVind.height + pgBDDAC.height + pg_sw.get_h()
                }

            S83_parametr_group
                 {
                 id:             pg_sw
                 name_group:     "Коммутатор"

                 anchors.top:        parent.top
                 anchors.left:       parent.left
                 anchors.right:      parent.right
                 visible:            false
                 function get_h()
                     {
                     return visible ? height : 0
                     }

                 content_component:
                 //Список какналов ALSA
                 Item
                    {
                    id:               tmp_item_list_sw
                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true

                    //height: list_sw.height_2 + 10
                    height: list_sw.height + 9

                    S83_list_sw
                        {
                        id: list_sw
                        y:  5
                        property int count_item_smal_window: 3      //Количество элементов при которо окно небольшое
                        property int height_1: height_item * count_item_smal_window + 5  //высота списка
                        //property int height_11: height_item * count_item_smal_window + 10

                        property int height_2: height_item * count_item_smal_window + 84 + 5
                        //property int height_22: height_item * count_item_smal_window + 84 + 10

                        anchors.left:           parent.left
                        anchors.right:          parent.right

                        Layout.alignment: Qt.AlignTop
                        Layout.fillWidth: true
                        height: height_2

                        onCountChanged:
                            {
                            if (count > 3)
                                 {
                                 height = height_2
                               //  tmp_item_list_sw.height = height_22

                                 }
                            else
                                 {
                                 height = height_1
                                // tmp_item_list_sw.height = height_11
                                 }
                            }



                        }
                    }

                 }//Коммутатор

            S83_parametr_group
                {
                id:             pgKb

                anchors.top:    pg_sw.top
                anchors.left:   parent.left
                anchors.right:  parent.right

                name_group:         "Клавиатура"
                Layout.fillWidth:   true
                content_component:  S83_page_dev_keyboard { }
                }

            S83_parametr_group
                {
                id: pgDisplay
                name_group:         "Дисплей"

                anchors.top:    pgKb.bottom
                anchors.left:   parent.left
                anchors.right:  parent.right

                content_component:  S83_page_dev_display {  }
                }

            S83_parametr_group
                {
                id: pgVind
                anchors.top:        pgDisplay.bottom
                anchors.left:       parent.left
                anchors.right:      parent.right
                name_group:         "Индикатор уровня громкости"
                Layout.fillWidth:   true
                content_component:  S83_page_dev_vind { }
                }

            S83_parametr_group
                {
                id: pgBDDAC
                anchors.top:        pgVind.bottom
                anchors.left:       parent.left
                anchors.right:      parent.right
                name_group:         "Модуль ЦАП"
                Layout.fillWidth:   true
                content_component:  S83_page_dev_bd_dac { }
                }



            Connections
                {
                target: my_app
                function onSig_sw(arg_id, arg_swname, arg_sItem, arg_sItemName)
                    {
                    if (arg_id < 1)
                        {
                        pg_sw.visible = false
                        pgKb.anchors.top = pg_sw.top
                        }
                    else
                        {
                        pg_sw.visible = true
                        pgKb.anchors.top = pg_sw.bottom
                        }

                    clDevices.update_h()

                    pg_sw.name_group = arg_swname
                    }

                }
            }
    }


