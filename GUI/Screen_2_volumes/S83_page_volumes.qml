import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_volumes
    content_component:
    ColumnLayout
               {
               id:             cl_page_volumes
               anchors.left:   parent.left
               anchors.right:  parent.right
               anchors.top:    parent.top
               //height:         543 //Проверить прокруткой страницы
               clip:           true
               spacing:        0

               S83_parametr_group
                    {
                    id:             pg_volumes
                    name_group:     "Громкости"

                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true

                    content_component:
                        S83_page_volumes_content  { }
                    }

               S83_parametr_group
                    {
                    id:             pg_elem_alsa_mixer
                    name_group:     "Элементы микшера ALSA"

                    Layout.alignment: Qt.AlignTop
                    Layout.fillWidth: true



                    content_component:
                    //Список какналов ALSA
                    Item
                       {
                       id: tmp_item_list_alsach
                       Layout.alignment: Qt.AlignTop
                       Layout.fillWidth: true

                       height: list_alsach.height_2 + 10
                       S83_list_alsa_ch
                           {
                           id:                     list_alsach
                           y:5
                           property int height_1: height_item * 3
                           property int height_2: 180
                           property int height_11: height_item * 3 +10
                           property int height_22: 190

                           anchors.left:           parent.left
                           anchors.right:          parent.right

                           Layout.alignment: Qt.AlignTop
                           Layout.fillWidth: true
                           //Layout.fillHeight: true
                           height: height_2

                           onCountChanged:
                           {
                           if (count > 3)
                                {
                                height = height_2
                                tmp_item_list_alsach.height = height_22

                                }
                           else
                                {
                                height = height_1
                                tmp_item_list_alsach.height = height_11
                                }
                           }

                          // Rectangle
                          //    {
                          //    id: r_list_alsach
                          //    anchors.fill: parent
                          //    color: "gray"
                          //    z:-1
                          //    }

                           }
                       }
                    }

               Connections
                   {
                   target: my_app
                   //Регулятор громкости
                   function onSig_vreg_id(arg_vreg_id,arg_vreg_name)
                       {

                       if (arg_vreg_id === 2) //Если алса микшер
                           pg_elem_alsa_mixer.visible = true
                       else
                           pg_elem_alsa_mixer.visible = false

                       if (arg_vreg_id) //если регулятор громкости есть
                          pg_volumes.enabled = true
                       else
                          pg_volumes.enabled = false
                       }
                   }
                }
    }


