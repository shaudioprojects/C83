import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls
import "../S83_controls"



S83_page_opt
    {
    id: page_volumes

    content_component:
    ColumnLayout
           {
           anchors.left:   parent.left
           anchors.right:  parent.right
           anchors.top:    parent.top
         //  height:         330 //Проверить прокруткой страницы
           clip:           true
           spacing:        0

           property int offset_x: 10 //Смещение для чекбоксов

            S83_parametr_group
                {
                 name_group:    "Основные опции"

                 Layout.alignment: Qt.AlignBottom
                 Layout.fillWidth: true

                 content_component:
                 ColumnLayout
                         {
                         spacing:        0

                         S83_CheckBox
                             {
                             id:            chb_01
                             text_color:    "white"

                             checked:       false
                             text:          "Случайный порядок"
                             padding:       5
                             color_point:       current_theme.color_ctrl_main_color
                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x

                             font.pixelSize:    18
                             onClicked:
                                 {
                                 //console.log("out: CheckBox [Случайный порядок]: " + chb_01.checked)
                                 my_app.slot_random(checked)
                                 }
                             }

                         S83_CheckBox
                             {
                             id:            chb_02
                             text_color:    "white"

                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x
                             color_point:       current_theme.color_ctrl_main_color
                             checked:   false
                             text:      "Повтор списка воспроизведения"
                             padding:   5
                             font.pixelSize: 18
                             onClicked:
                                 {
                                 //console.log("out: CheckBox [Повтор списка воспроизведения]: " + chb_02.checked)
                                 my_app.slot_repeate(checked)
                                 }
                             }

                         S83_CheckBox
                             {
                             id:            chb_03
                             text_color:    "white"

                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x
                             color_point:       current_theme.color_ctrl_main_color
                             checked:   false
                             text:      "Осторожно с громкостью"
                             padding:   5
                             font.pixelSize: 18
                             onClicked:
                                 {
                                 //console.log("out: CheckBox [Осторожно с громкостью]: " + chb_03.checked)
                                 my_app.slot_neatly_vol(checked)
                                 }
                             }

                         Connections
                                 {
                                 target: my_app

                                 function onSig_random(arg_value)
                                     {
                                     //console.log("in: Установить CheckBox [random] в " + arg_value)
                                     chb_01.checked = arg_value
                                     }

                                 function onSig_repeate(arg_value)
                                     {
                                     //console.log("in: Установить CheckBox [repeate] в " + arg_value)
                                     chb_02.checked = arg_value
                                     }

                                 function onSig_neatly_vol(arg_value)
                                     {
                                     //console.log("in: Установить CheckBox [neatly_vol] в " + arg_value)
                                     chb_03.checked = arg_value
                                     }
                                }

                     }
                }

            S83_parametr_group
                {
                 name_group:    "После загрузки"

                 Layout.alignment: Qt.AlignBottom
                 Layout.fillWidth: true

                 content_component:
                 ColumnLayout
                        {
                        spacing:        0

                        S83_CheckBox
                            {
                            id:            chb_restvol
                            text_color:    "white"
                            x:             offset_x

                            checked:       false
                            text:          "Воcстановить громкость"
                            padding:       5

                            Layout.alignment:   Qt.AlignBottom
                            Layout.fillWidth:   true
                            Layout.leftMargin:  offset_x
                            color_point:        current_theme.color_ctrl_main_color
                            font.pixelSize:     18
                            onClicked:
                                {
                                //console.log("out: CheckBox [Воcстановить громкость]: " + chb_033.checked)
                                my_app.slot_restore_volume(checked)
                                }
                            }

                        S83_CheckBox
                            {
                            id:            chb_finfile
                            text_color:    "white"
                            x:             offset_x

                            checked:       false
                            text:          "Воспроизвести последний файл"
                            padding:       5

                            Layout.alignment:  Qt.AlignBottom
                            Layout.fillWidth:  true
                            Layout.leftMargin: offset_x
                            color_point:       current_theme.color_ctrl_main_color
                            font.pixelSize: 18
                            onClicked:
                                {
                                //console.log("out: CheckBox [Воспроизвести последний файл]: " + chb_04.checked)
                                my_app.slot_restore_play_file(checked)
                                }
                            }


                        S83_CheckBox
                            {
                            id:                chb_filepos
                            text_color:        "white"
                            x:                 offset_x

                            checked:           false
                            text:              "Воспроизвести с места останова"
                            padding:           5
                            color_point:       current_theme.color_ctrl_main_color
                            enabled:           chb_finfile.checked
                            Layout.alignment:  Qt.AlignBottom
                            Layout.fillWidth:  true
                            Layout.leftMargin: offset_x

                            font.pixelSize: 18
                            onClicked:
                                {
                                //console.log("out: CheckBox [Воспроизвести с места останова]: " + chb_05.checked)
                                my_app.slot_restore_pos_in_play_file(checked)
                                }
                            }

                     Connections
                            {
                             target: my_app

                             function onSig_restore_volume(arg_value)
                                 {
                                 //console.log("in: Установить CheckBox [restore volume] в " + arg_value)
                                 chb_restvol.checked = arg_value
                                 }
                             function onSig_restore_play_file(arg_value)
                                 {
                                 //console.log("in: Установить CheckBox [restore file] в " + arg_value)
                                 chb_finfile.checked = arg_value
                                 }
                             function onSig_restore_position_in_play_file(arg_value)
                                 {
                                 //console.log("in: Установить CheckBox [restore pos in file] в " + arg_value)
                                 chb_filepos.checked = arg_value
                                 }
                            }

                    }
                }
            }
    }


