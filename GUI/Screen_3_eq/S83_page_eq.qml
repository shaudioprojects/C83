import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_lan


    content_component:
    ColumnLayout
            {
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.top:    parent.top
            property bool flag_local_eq_checked: false
            clip:           true
            spacing:        0

        S83_parametr_group
            {
            name_group:    "Эквалайзер"
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            content_component:
            ColumnLayout
                {
                id:                 cl_eq
                spacing:            0
                Layout.fillWidth:   true

                Rectangle
                    {
                    Layout.fillWidth: true
                    height: 50
                    color:  "transparent"

                    Rectangle
                            {
                            width:  36
                            height: 36
                            radius: 18
                            color: "transparent"
                            border.color: "gray"

                            anchors.left:   parent.left
                            anchors.top:    parent.top
                            anchors.topMargin:     10
                            anchors.leftMargin:    10

                            Image
                                {
                                id: image_eq
                                width:  24
                                height: 24
                                visible:  true

                                anchors.centerIn: parent
                                z: -1
                                source: "qrc:/Icon/for_drawer/dr_eq.svg";
                                }
                             }



                    S83_CheckBox
                            {
                            id:             cb_eq_on_off
                            text:           "Включить"
                            anchors.right:  parent.right
                            font.pixelSize: 18
                            color_point:    checked ? band_31.color_slider : "white"

                            MouseArea
                                {
                                anchors.fill: parent
                                onClicked:
                                    {
                                    if (rb_eq_global.checked)
                                        my_app.slot_eq(2,0);
                                    else
                                        {
                                        if (rb_eq_local.checked)
                                        my_app.slot_eq(2,1); //2 - комманда включить_выключить
                                        }
                                    }
                                }
                            }//cb
                }

                RowLayout
                       {
                       id:      rl_eq
                       property int h_sliders: 38
                       property string color_eq_global:    current_theme.color_ctrl_main_color
                       property string color_eq_local:     "#4169e1"

                       spacing: 0
                       width:   cl_eq.width

                       function send_band_to_server(arg_band,arg_value)
                            {
                            if (rb_eq_global.checked)
                                my_app.slot_eq_band(0,arg_band,arg_value)
                            if (rb_eq_local.checked)
                                my_app.slot_eq_band(1,arg_band,arg_value)
                            }

                       S83_page_eq_band_control
                           {
                           id:              band_31
                           band_name:       "31"
                           h_slider:        rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true


                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(0,value)
                               }


                           }

                       S83_page_eq_band_control
                           {
                           id:         band_62
                           band_name:  "62"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(1,value)
                               }
                           }

                       S83_page_eq_band_control
                           {
                           id:         band_125
                           band_name:  "125"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true


                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(2,value)
                               }
                           }

                       S83_page_eq_band_control
                           {
                           id:         band_250
                           band_name:  "250"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(3,value)
                               }
                           }
                       S83_page_eq_band_control
                           {
                           id:         band_500
                           band_name:  "500"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(4,value)
                               }
                           }

                       S83_page_eq_band_control
                           {
                           id:         band_1K
                           band_name:  "1K"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(5,value)
                               }
                           }
                       S83_page_eq_band_control
                           {
                           id:         band_2K
                           band_name:  "2K"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(6,value)
                               }
                           }
                       S83_page_eq_band_control
                           {
                           id:         band_4K
                           band_name:  "4K"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true



                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(7,value)
                               }
                           }
                       S83_page_eq_band_control
                           {
                           id:         band_8K
                           band_name:  "8K"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true


                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(8,value)
                               }
                           }
                       S83_page_eq_band_control
                           {
                           id:         band_16K
                           band_name:  "16K"
                           h_slider:   rl_eq.h_sliders
                           Layout.alignment: Qt.AlignHCenter
                           Layout.fillWidth: true


                           onMoved_finished:
                               {
                               rl_eq.send_band_to_server(9,value)
                               }
                           }
                       } //RowLayout Экв
                   // }//рект

                S83_RadioButton
                    {
                    id: rb_eq_global
                    text:               "Общий"
                    Layout.alignment:   Qt.AlignBottom
                    Layout.leftMargin:  10
                    font.pixelSize:     18
                    Layout.fillWidth:   true

                    color:              checked ? current_theme.color_ctrl_main_color : "white"
                    color_point:        color
                    MouseArea
                        {
                        anchors.fill: parent
                        onClicked:
                            {

                            my_app.slot_eq(0,0)
                            }
                        }
                    }

                S83_RadioButton
                    {
                    id:                 rb_eq_local
                    text:               "Локальный"
                    Layout.alignment:   Qt.AlignBottom
                    font.pixelSize:     18
                    Layout.leftMargin:  10
                    color:              checked ? current_theme.color_ctrl_main_color : "white"
                    color_point:        color
                    MouseArea
                        {
                        anchors.fill: parent
                        onClicked:
                            {

                            my_app.slot_eq(1,0)
                            }
                        }
                    }

                S83_parametr_classic
                    {
                    id:                 par_eq_state

                    Layout.alignment:   Qt.AlignBottom
                    Layout.fillWidth:   true
                    Layout.leftMargin:  10
                    Layout.rightMargin: 10
                    Layout.bottomMargin:15

                    change_padding:     5

                    text_label:     "Состояние фильтра \"Equalizer\":"
                    text_value:     "-"
                    }

                Connections
                    {
                    target: my_app

                    function onSig_eq_state(arg_eq_id,arg_sate)
                        {

                        if (arg_eq_id === 0) //Глобальный
                            {
                            rb_eq_global.checked = true
                            }
                        if (arg_eq_id === 1) //Локальный
                            {
                            rb_eq_local.checked = true
                            }

                        cb_eq_on_off.checked = arg_sate
                        w_eq_local.visible = rb_eq_local.checked
                        }
                    function onSig_eq_band(arg_eq_id,arg_band,arg_value)
                        {
                        //console.log("in: onSig_eq_band " + arg_band + " - " + arg_value);
                        switch(arg_band)
                            {
                            case 0: band_31.value = arg_value
                                break;
                            case 1: band_62.value = arg_value
                                break;
                            case 2: band_125.value = arg_value
                                break;
                            case 3: band_250.value = arg_value
                                break;
                            case 4: band_500.value = arg_value
                                break;
                            case 5: band_1K.value = arg_value
                                break;
                            case 6: band_2K.value = arg_value
                                break;
                            case 7: band_4K.value = arg_value
                                break;
                            case 8: band_8K.value = arg_value
                                break;
                            case 9: band_16K.value = arg_value
                                break;
                            }
                        }

                    //Состояние эквалайзера
                    function onSig_eq_flag_player(arg_value)
                        {
                        if (arg_value)
                            {
                            par_eq_state.text_value = "on"
                            par_eq_state.value_warning = true
                            }
                        else
                            {
                            par_eq_state.text_value = "off"
                            par_eq_state.value_warning = false
                            }
                        }

                    }
                } //ColumnLayout
            } //pg

        S83_warning
            {
            id:                 w_eq_local
            Layout.fillWidth:   true
            Layout.topMargin:   8
            text:               "Выбран эквалайзер для конкретного плейлиста (каталога)"
            }
        }
    }


