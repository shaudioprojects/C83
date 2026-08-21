import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"
import "../S83_dialogs"
import "../Enums"



S83_page_opt
    {
    id: page_colors



    content_component:
    ColumnLayout
            {
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.top:    parent.top
            clip:           true
            spacing:        0

            S83_parametr_group
                {
                id:                 pg_colors
                name_group:         "Цвета файлов"

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true

                property bool  flag_btn_block: false

                S83_afile_ids
                    {
                    id: ids_files
                    }

                content_component:

                RowLayout
                    {
                    id: rl_rb_groups
                    spacing: 0

                ColumnLayout
                        {
                        id:     cl_group_1
                        spacing: 0
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop

                        S83_RadioButton
                            {
                            id:             rb_flac
                            text:           "FLAC"
                            font.pixelSize: 18


                            MouseArea
                                    {
                                    id: ma_flac
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond(ids_files.id_flac,parent.color)
                                        reset_radiobutton()
                                        parent.checked = true
                                        }

                                    }
                            }

                        S83_RadioButton
                            {
                                id:             rb_ape
                                text:           "APE"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_ape, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true
                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_wav
                                text:           "WAV"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_wav, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_dsf
                                text:           "DSF"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_dsf, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_dts
                                text:           "DTS"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_dts, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true
                                        }
                                    }
                            }

                        Connections
                            {
                            target: my_app

                            function onSig_color_file(arg_id_file, arg_red, arg_green, arg_blue)
                                {
                                switch (arg_id_file)
                                    {
                                    case ids_files.id_flac: rb_flac.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_ape:  rb_ape.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_wav:  rb_wav.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_dsf:  rb_dsf.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_dts:  rb_dts.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    }
                                }
                            }
                        }

                ColumnLayout
                        {
                        spacing: 0
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        S83_RadioButton
                            {
                                id:             rb_mp3
                                text:           "MP3"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_mp3, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_ac3
                                text:           "AC3"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_ac3, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_aac
                                text:           "AAC"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_aac, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_m4a
                                text:           "m4a"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_m4a, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true
                                        }
                                    }
                            }

                        Connections
                            {
                            target: my_app

                            function onSig_color_file(arg_id_file, arg_red, arg_green, arg_blue)
                                {
                                switch (arg_id_file)
                                    {
                                    case ids_files.id_mp3: rb_mp3.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_ac3:  rb_ac3.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_aac:  rb_aac.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_m4a:  rb_m4a.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    }
                                }
                            }
                        }

                ColumnLayout
                        {
                        spacing: 0
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        S83_RadioButton
                            {
                                id:             rb_mpc
                                text:           "MPC"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_mpc, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_ogg
                                text:           "OGG"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_ogg, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_wv
                                text:           "WV"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_wv, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_wma
                                text:           "WMA"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_wma, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        Connections
                            {
                            target: my_app

                            function onSig_color_file(arg_id_file, arg_red, arg_green, arg_blue)
                                {
                                switch (arg_id_file)
                                    {
                                    case ids_files.id_mpc: rb_mpc.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_ogg:  rb_ogg.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_wv:  rb_wv.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_wma:  rb_wma.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break

                                    }
                                }
                            }
                        }

                ColumnLayout
                        {
                        spacing: 0
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        S83_RadioButton
                            {
                                id: rb_dir
                                text: "DIR"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_dir, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_bk
                                text:           "BACK"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_back, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_poff
                                text:           "POFF"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_poff, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }
                        S83_RadioButton
                            {
                                id:             rb_cue
                                text:           "CUE"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_cue, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }

                        S83_RadioButton
                            {
                                id:             rb_url
                                text:           "URL"
                                font.pixelSize: 18
                                MouseArea
                                    {
                                    anchors.fill: parent
                                    onClicked:
                                        {
                                        dlg_colors.set_start_cond( ids_files.id_url, parent.color )
                                        reset_radiobutton()
                                        parent.checked = true

                                        }
                                    }
                            }

                   //    Item
                   //         {
                   //         id: it_tmp
                   //         height: 50

                   //         }

                        Connections
                            {
                            target: my_app

                            function onSig_color_file(arg_id_file, arg_red, arg_green, arg_blue)
                                {
                                switch (arg_id_file)
                                    {
                                    case ids_files.id_dir: rb_dir.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_back:  rb_bk.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_poff:  rb_poff.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_cue:  rb_cue.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    case ids_files.id_url:  rb_url.color = Qt.rgba(arg_red, arg_green, arg_blue, 1)
                                        break
                                    }
                                }
                            }

                        Rectangle
                            {
                            color: "transparent"
                            height: 45
                            }
                        }

                function reset_radiobutton ()
                    {
                    pg_colors.flag_btn_block = true

                    rb_flac.checked = false
                    rb_ape.checked = false
                    rb_wav.checked = false
                    rb_dsf.checked = false
                    rb_dts.checked = false

                    rb_mp3.checked = false
                    rb_ac3.checked = false
                    rb_aac.checked = false
                    rb_m4a.checked = false

                    rb_mpc.checked = false
                    rb_ogg.checked = false
                    rb_wv.checked  = false
                    rb_wma.checked = false


                    rb_dir.checked  = false
                    rb_bk.checked   = false
                    rb_poff.checked = false
                    rb_cue.checked  = false
                    rb_url.checked  = false
                    }

                }




                //Кнопки
                RowLayout
                    {
                    spacing: 10
                    anchors.bottom:             parent.bottom
                    anchors.horizontalCenter:   parent.horizontalCenter

                    S83_Button
                            {
                            text:      "    Изменить    "
                            btn_color: current_theme.color_ctrl_main_color
                            enabled:  pg_colors.flag_btn_block

                            onClicked:
                                {
                                dlg_colors.visible = true
                                }
                            }


                    S83_Button
                            {
                            text:      "    Сбросить    "
                            btn_color: current_theme.color_ctrl_main_color
                            onClicked: dialog_reset_colors.visible = true
                            }
                    }

                }


            S83_parametr_group
                {
                id:                 pg_colors_ui
                name_group:         "Цветовая тема интерфейса"

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true

                property bool  flag_btn_block: false

                content_component:
                RowLayout
                        {
                        id:     cl_colors
                        spacing: 0
                        Layout.alignment: Qt.AlignHCenter|Qt.AlignTop
                        property int left_margins: 5

                        property string theme_color_turquoise:  "#3c8080" //"#3d08fb"
                        property string theme_color_red:        "#cc0000"
                        property string theme_color_green:      "#009933"
                        property string theme_color_gray:       "#707070"
                        property string theme_color_blue:       "#3366ff"//"#3d08fb"
                        property string theme_color_orange:     "chocolate"

                        function th_turquoise()
                            {
                            rb_dd.checked = true
                            current_theme.color_ctrl_main_color = theme_color_turquoise
                            current_theme.icon_play  = "qrc:/Icon/for_file/play/play_01_turquoise.svg"
                            current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_01_turquoise.svg"
                            current_theme.bk_image   = "qrc:/Icon/for_page/bk_rain.jpg"
                            }

                        function th_red()
                            {
                            rb_red.checked = true
                            current_theme.color_ctrl_main_color = theme_color_red
                            current_theme.icon_play  = "qrc:/Icon/for_file/play/play_02_red.svg"
                            current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_02_red.svg"
                            current_theme.bk_image   = "qrc:/Icon/for_page/bk_red.jpg"
                            }

                        function th_green()
                            {
                            rb_green.checked = true
                            current_theme.color_ctrl_main_color = theme_color_green
                            current_theme.icon_play  = "qrc:/Icon/for_file/play/play_03_green.svg"
                            current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_03_green.svg"
                            current_theme.bk_image   = "qrc:/Icon/for_page/bk_green.jpg"
                            }

                        function th_himikat()
                            {
                            rb_himikat.checked = true
                            current_theme.color_ctrl_main_color = theme_color_gray
                            current_theme.icon_play  = "qrc:/Icon/for_file/play/play_05_gray.svg"
                            current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_05_gray.svg"
                            current_theme.bk_image   = "qrc:/Icon/for_page/bk_h2o.jpg"
                            }

                        function th_blue ()
                            {
                            rb_blue.checked = true
                            current_theme.color_ctrl_main_color = theme_color_blue
                            current_theme.icon_play  = "qrc:/Icon/for_file/play/play_04_blue.svg"
                            current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_04_blue.svg"
                            current_theme.bk_image   = "qrc:/Icon/for_page/bk_blue.jpg"
                            }

                        function th_orange()
                             {
                             rb_orange.checked = true
                             current_theme.color_ctrl_main_color = theme_color_orange
                             current_theme.icon_play  = "qrc:/Icon/for_file/play/play_06_orang.svg"
                             current_theme.icon_pause = "qrc:/Icon/for_file/pause/pause_06_orang.svg"
                             current_theme.bk_image   = "qrc:/Icon/for_page/bk_orange.jpg"
                             }

                        S83_RadioButton
                           {
                           id:                  rb_dd
                           text:                ""
                           font.pixelSize:      18

                           color_disable:       current_theme.color_ctrl_disable
                           color_point:         current_theme.color_ctrl_main_color
                           color_enable:        theme_color_turquoise

                           verticalPadding:     8
                           horizontalPadding:   10
                           Layout.leftMargin:   left_margins



                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_turquoise()
                                   my_app.slot_set_theme(0)
                                   }
                               }
                           }

                        S83_RadioButton
                           {
                           id:              rb_red
                           text:            ""
                           font.pixelSize:  18

                           color_disable:   current_theme.color_ctrl_disable
                           color_point:     current_theme.color_ctrl_main_color
                           color_enable:    theme_color_red

                           verticalPadding: 8
                           horizontalPadding: 10
                           Layout.leftMargin: left_margins



                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_red()
                                   my_app.slot_set_theme(1)
                                   }
                               }
                           }

                        S83_RadioButton
                           {
                           id:              rb_green
                           text:            ""//"Зеленый"
                           font.pixelSize:  18

                           color_disable:   current_theme.color_ctrl_disable
                           color_point:     current_theme.color_ctrl_main_color
                           color_enable:    theme_color_green

                           verticalPadding:     8
                           horizontalPadding:   10
                           Layout.leftMargin:   left_margins


                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_green()
                                   my_app.slot_set_theme(2)
                                   }
                               }
                           }

                        S83_RadioButton
                           {
                           id:                  rb_blue
                           text:                ""//"Синяя"
                           font.pixelSize:      18

                           color_disable:       current_theme.color_ctrl_disable
                           color_point:         current_theme.color_ctrl_main_color
                           color_enable:        theme_color_blue

                           verticalPadding:     8
                           horizontalPadding:   10
                           Layout.leftMargin:   left_margins



                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_blue()
                                   my_app.slot_set_theme(3)
                                   }
                               }
                           }

                        S83_RadioButton
                           {
                           id:                  rb_himikat
                           text:                ""//"Неизвестная субстанция"
                           font.pixelSize:      18

                           color_disable:       current_theme.color_ctrl_disable
                           color_point:         current_theme.color_ctrl_main_color
                           color_enable:        theme_color_gray

                           verticalPadding:     8
                           horizontalPadding:   10
                           Layout.leftMargin:   left_margins



                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_himikat()
                                   my_app.slot_set_theme(4)
                                   }
                               }
                           }

                        S83_RadioButton
                           {
                           id:                  rb_orange
                           text:                ""//"Хэллоуин"
                           font.pixelSize:      18

                           color_disable:       current_theme.color_ctrl_disable
                           color_point:         current_theme.color_ctrl_main_color
                           color_enable:        theme_color_orange

                           verticalPadding:     8
                           horizontalPadding:   10
                           Layout.leftMargin:   left_margins



                           MouseArea
                               {
                               anchors.fill: parent
                               onClicked:
                                   {
                                   th_orange()
                                   my_app.slot_set_theme(5)
                                   }
                               }
                           }

                        Connections
                            {
                            target: my_app

                            function onSig_set_th(arg_th)
                                {
                                switch (arg_th)
                                    {
                                    case 0: th_turquoise()
                                        break
                                    case 1: th_red()
                                        break
                                    case 2: th_green()
                                        break
                                    case 3: th_blue()
                                        break
                                    case 4: th_himikat()
                                        break
                                    case 5: th_orange()
                                        break
                                    }
                                }
                            }

                        }
                }



        }

    }


