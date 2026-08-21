import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12

import "../S83_controls"
import "../Screen_4_acard"
import "../Drawer"

S83_page_opt
    {
    content_component:
    ColumnLayout
           {
            id: cl_alsa_page
            anchors.left:   parent.left
            anchors.right:  parent.right
            anchors.top:    parent.top
           // height:         785 //Проверить прокруткой страницы
            clip:           true
            spacing:        0

            property real   curren_frec:        0
            property int    curren_ch_count:    0
            property string curren_fmt:         " "


            S83_parametr_group
                    {
                    id:             group_aout
                    name_group:     "Аудиовыход (ALSA)"

                    Layout.alignment: Qt.AlignBottom
                    Layout.fillWidth: true

                    content_component:
                    //Список аудиоустройств
                    Item
                        {
                        Layout.alignment: Qt.AlignBottom
                        Layout.fillWidth: true

                        height: 200+10

                        S83_list_acard
                                {
                                anchors.left:           parent.left
                                anchors.right:          parent.right
                                y:5
                                height: 200
                                }
                        }
                    }

            S83_parametr_group
                {
                id:             group_support_modes
                name_group:     "Состояние аудиовыхода"

                Layout.alignment: Qt.AlignBottom
                Layout.fillWidth: true

                content_component:
                ColumnLayout
                    {
                    spacing: 0



                    S83_parametr_classic
                        {
                        id:                 par_current_aout
                        Layout.alignment:   Qt.AlignBottom
                        Layout.fillWidth:   true

                        Layout.topMargin:   5
                        Layout.leftMargin:  5
                        Layout.rightMargin: 5

                        change_padding:     5

                        text_label:   "Аудиовыход:"
                        text_value:   "-"

                        }

                    S83_parametr_classic
                        {
                        id:                 par_режим
                        anchors.leftMargin: 5
                        Layout.alignment:   Qt.AlignBottom
                        Layout.fillWidth:   true
                        text_label:         "Режим сейчас:"
                        text_value:         (curren_frec || curren_ch_count) ? curren_frec + " КГц, " + curren_ch_count + "к, " + curren_fmt : "-"
                        change_padding:     5
                        Layout.leftMargin:  5
                        Layout.rightMargin: 5
                        }

                    S83_parametr_classic
                        {
                        id:                 par_каналов_доступно
                        anchors.leftMargin: 5
                        Layout.alignment:   Qt.AlignBottom
                        Layout.fillWidth:   true
                        text_label:         "Каналов доступно:"
                        text_value:         "-"
                        change_padding:     5
                        Layout.leftMargin:  5
                        Layout.rightMargin: 5
                        }

                    S83_parametr_classic
                        {
                        id:                 par_alsa_version
                        anchors.leftMargin: 5
                        Layout.alignment:   Qt.AlignBottom
                        Layout.fillWidth:   true
                        change_padding:     5
                        text_label:         "Версия ALSA:"
                        text_value:         "-"

                        Layout.leftMargin:  5
                        Layout.rightMargin: 5
                        Layout.bottomMargin: 3
                        }

                    Connections
                            {
                            target:     my_app

                            //Выбор аудиовыхода
                            function onSig_select_aout(arg_name)
                                {
                                par_current_aout.text_value = arg_name
                                }

                            //ALSA Каналов сечас
                            function onSig_aout_ch_count(arg_value1,arg_value2,arg_value3)
                                {
                                curren_ch_count = arg_value1 //Текущее количество каналов


                                if (arg_value2 !== 0 && arg_value3 !== 0)
                                    if (arg_value2 === arg_value3)
                                        par_каналов_доступно.text_value = arg_value2
                                    else
                                        par_каналов_доступно.text_value = arg_value2 + ".." + arg_value3
                                else
                                    par_каналов_доступно.text_value = "-"



                                }

                            //ALSA версия
                            function onSig_aout_info(arg_version)
                                {
                                par_alsa_version.text_value = arg_version
                                }

                            }
                    }
             } //группа параметров

            S83_parametr_group
                    {
                    id:             group_resample
                    name_group:     "Формат принудительно"

                    Layout.alignment: Qt.AlignBottom
                    Layout.fillWidth: true

                    content_component:


                        Rectangle
                            {
                            color:              "transparent"
                            Layout.fillWidth:   true
                            Layout.alignment:   Qt.AlignBottom

                            height:             155

                        RowLayout
                                {
                                anchors.left:   parent.left
                                anchors.right:  parent.right
                                anchors.top:    parent.top

                                anchors.leftMargin:     15
                                anchors.rightMargin:    15
                                anchors.topMargin:      0

                                height:                 150
                                spacing:                0

                                Connections
                                        {
                                        target:     my_app
                                        //property string avaliable_color: "white"//current_theme.color_ctrl_parametr_value



                                        //Доступный формат сэмпла
                                        function onSig_aout_fmt_avaliable(arg_fmt,arg_value)
                                            {
                                            //console.log("in: Дост. формат семпла аудиовыхода: " + arg_fmt + " значение: " + arg_value)
                                            switch (arg_fmt)
                                                {
                                                case "U8":  fmt_u8.enabled  = arg_value
                                                    break
                                                case "S16": fmt_s16.enabled = arg_value
                                                    break
                                                case "S32": fmt_s32.enabled = arg_value
                                                    break
                                                case "F32": fmt_f32.enabled = arg_value
                                                    break
                                                case "F64": fmt_f64.enabled = arg_value
                                                    break
                                                default:;
                                                }
                                            }

                                        //Текущий формат
                                        function onSig_aout_fmt_current(arg_value)
                                            {
                                            //console.log("in: Текущий формат семпла аудиовыхода: " + arg_value)
                                            curren_fmt = arg_value
                                            }

                                        //Доступная частота
                                        function onSig_aout_freq_avaliable(arg_freq,arg_value)
                                            {
                                            //console.log("in: Дост. частота аудиовыхода: " + arg_freq + " значение: " + arg_value)
                                            switch (arg_freq)
                                                {
                                                case 44100: freq_44.enabled = arg_value
                                                    break
                                                case 88200: freq_88.enabled = arg_value
                                                    break
                                                case 176400: freq_176.enabled = arg_value
                                                    break
                                                case 352800: freq_352.enabled = arg_value
                                                    break

                                                case 48000: freq_48.enabled = arg_value
                                                    break
                                                case 96000: freq_96.enabled = arg_value
                                                    break
                                                case 192000: freq_192.enabled = arg_value
                                                    break
                                                case 384000: freq_384.enabled = arg_value
                                                    break

                                                default:;
                                                }
                                            }


                                        //Текущая частота аудиовыхода
                                        function onSig_aout_freq_current(arg_value)
                                            {
                                            //console.log("in: Текущая частота аудиовыхода: " + arg_value )
                                            curren_frec = arg_value / 1000
                                            }

                                        function reset_freq_radiobutton()
                                            {
                                            freq_44.checked  = false
                                            freq_88.checked  = false
                                            freq_176.checked = false
                                            freq_352.checked = false

                                            freq_48.checked  = false
                                            freq_96.checked  = false
                                            freq_192.checked = false
                                            freq_384.checked = false
                                            }

                                        function reset_fmt_radiobutton()
                                            {
                                            fmt_u8.checked  = false
                                            fmt_s16.checked = false
                                            fmt_s32.checked = false
                                            fmt_f32.checked = false
                                            fmt_f64.checked = false
                                            }

                                        function onSig_change_freq(arg_value)
                                            {
                                            console.log("in: Включена передискретизация: " + arg_value)
                                            reset_freq_radiobutton()
                                            switch (arg_value)
                                                {
                                                case 44100: freq_44.checked     = true
                                                          //  frec_no_resample.checked = false
                                                            break
                                                case 88200: freq_88.checked     = true
                                                          //  frec_no_resample.checked = false
                                                            break
                                                case 176400:freq_176.checked   = true
                                                          //  frec_no_resample.checked = false
                                                            break
                                                case 352800:freq_352.checked   = true
                                                           // frec_no_resample.checked = false
                                                            break

                                                case 48000: freq_48.checked     = true
                                                           // frec_no_resample.checked = false
                                                            break
                                                case 96000: freq_96.checked     = true
                                                           // frec_no_resample.checked = false
                                                            break
                                                case 192000:freq_192.checked   = true
                                                          //  frec_no_resample.checked = false
                                                            break
                                                case 384000:freq_384.checked   = true
                                                          //  frec_no_resample.checked = false
                                                            break

                                                default:
                                                }
                                            }
                                        function onSig_change_fmt(arg_value)
                                            {
                                            console.log("in: Включено изменение формата сэмпла: " + arg_value)
                                            reset_fmt_radiobutton()
                                            switch (arg_value)
                                                {

                                                case 0: fmt_u8.checked    = true
                                                        //frec_no_resample.checked = false
                                                        break
                                                case 1: fmt_s16.checked   = true
                                                       // frec_no_resample.checked = false
                                                        break
                                                case 2: fmt_s32.checked   = true
                                                       // frec_no_resample.checked = false
                                                        break

                                                case 3: fmt_f32.checked   = true
                                                       // frec_no_resample.checked = false
                                                        break
                                                case 4: fmt_f64.checked   = true
                                                       // frec_no_resample.checked = false
                                                        break

                                                default:
                                                }
                                            }

                                        }

                                ColumnLayout
                                            {
                                            S83_RadioButton
                                               {
                                               id:              freq_44
                                               text:            "44.1 КГц"
                                               font.pixelSize:  18
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               color_disable:   current_theme.color_ctrl_disable

                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(44100)
                                                       console.log("out: Включить передискретизацию: " + freq_44.text)
                                                       }
                                                   }

                                               }

                                            S83_RadioButton
                                               {
                                               id:              freq_88
                                               text:            "88.2 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(88200)
                                                       console.log("out: Включить передискретизацию: " + freq_88.text)
                                                       }
                                                   }
                                               }

                                            S83_RadioButton
                                               {
                                               id:              freq_176
                                               text:            "176.4 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(176400)
                                                       console.log("out: Включить передискретизацию: " + freq_176.text)
                                                       }
                                                   }
                                               }
                                            S83_RadioButton
                                               {
                                               id:              freq_352
                                               text:            "352.8 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(352800)
                                                       console.log("out: Включить передискретизацию: " + freq_352.text)
                                                       }
                                                   }
                                               }
                                            S83_RadioButton
                                               {
                                               id:                  frec_no_resample
                                               text:                "Как есть"
                                               font.pixelSize:      18
                                               verticalPadding:     0
                                               horizontalPadding:   0
                                               color_disable:       current_theme.color_ctrl_disable
                                               enabled:             true
                                               checked:             !freq_44.checked && !freq_88.checked && !freq_176.checked && !freq_352.checked &&         !freq_48.checked && !freq_96.checked && !freq_192.checked && !freq_384.checked &&          !fmt_u8.checked  && !fmt_s16.checked  && !fmt_s32.checked && !fmt_f32.checked  && !fmt_f64.checked
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(0)
                                                       my_app.slot_change_fmt(-1)
                                                       console.log("out: Отключить передискретизацию и изменение формата сэмпла.")
                                                       }
                                                   }
                                               }
                                            }

                                ColumnLayout
                                            {

                                            S83_RadioButton
                                               {
                                               id:              freq_48
                                               text:            "48.0 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(48000)
                                                       console.log("out: Включить передискретизацию: " + freq_48.text)
                                                       }
                                                   }
                                               }
                                            S83_RadioButton
                                               {
                                               id:              freq_96
                                               text:            "96.0 КГц"
                                               font.pixelSize:   18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(96000)
                                                       console.log("out: Включить передискретизацию: " + freq_96.text)
                                                       }
                                                   }
                                               }
                                            S83_RadioButton
                                               {
                                               id:              freq_192
                                               text:            "192.0 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(192000)
                                                       console.log("out: Включить передискретизацию: " + freq_192.text)
                                                       }
                                                   }
                                               }
                                            S83_RadioButton
                                               {
                                               id:              freq_384
                                               text:            "384.0 КГц"
                                               font.pixelSize:  18
                                               color_disable:   current_theme.color_ctrl_disable
                                               verticalPadding: 0
                                               horizontalPadding: 0
                                               MouseArea
                                                   {
                                                   anchors.fill: parent
                                                   onClicked:
                                                       {
                                                       my_app.slot_change_freq(384000)
                                                       console.log("out: Включить передискретизацию: " + freq_384.text)
                                                       }
                                                   }
                                               }
                                            Text
                                               {
                                               text: " "
                                               font.pixelSize:   18
                                               }

                                            }

                                ColumnLayout
                                            {

                                            S83_RadioButton
                                                {
                                                    id:                 fmt_u8
                                                    text:               "U8"
                                                    font.pixelSize:     18
                                                    color_disable:      current_theme.color_ctrl_disable
                                                    verticalPadding:    0
                                                    horizontalPadding: 0

                                                    MouseArea
                                                        {
                                                        anchors.fill: parent
                                                        onClicked:
                                                            {
                                                            my_app.slot_change_fmt(0)
                                                            console.log("out: Изменить формат сэмпла на: " + fmt_u8.text)
                                                            }
                                                        }
                                                }
                                            S83_RadioButton
                                                {
                                                    id:                 fmt_s16
                                                    text:               "S16"
                                                    font.pixelSize:     18
                                                    color_disable:      current_theme.color_ctrl_disable
                                                    verticalPadding:    0
                                                    horizontalPadding: 0
                                                    MouseArea
                                                        {
                                                        anchors.fill: parent
                                                        onClicked:
                                                            {
                                                            my_app.slot_change_fmt(1)
                                                            console.log("out: Изменить формат сэмпла на: " + fmt_s16.text)
                                                            }
                                                        }
                                                }
                                            S83_RadioButton
                                                {
                                                    id:   fmt_s32
                                                    text: "S32"
                                                    font.pixelSize:   18
                                                    color_disable:   current_theme.color_ctrl_disable
                                                    verticalPadding: 0
                                                    horizontalPadding: 0
                                                    MouseArea
                                                        {
                                                        anchors.fill: parent
                                                        onClicked:
                                                            {
                                                            my_app.slot_change_fmt(2)
                                                            console.log("out: Изменить формат сэмпла на: " + fmt_s32.text)
                                                            }
                                                        }
                                                }
                                            S83_RadioButton
                                                {
                                                    id:   fmt_f32
                                                    text: "F32"
                                                    font.pixelSize:   18
                                                    color_disable:   current_theme.color_ctrl_disable
                                                    verticalPadding: 0
                                                    horizontalPadding: 0
                                                    MouseArea
                                                        {
                                                        anchors.fill: parent
                                                        onClicked:
                                                            {
                                                            my_app.slot_change_fmt(3)
                                                            console.log("out: Изменить формат сэмпла на: " + fmt_f32.text)
                                                            }
                                                        }
                                                }
                                            S83_RadioButton
                                                {
                                                    id:   fmt_f64
                                                    text: "F64"
                                                    font.pixelSize:   18
                                                    color_disable:   current_theme.color_ctrl_disable
                                                    verticalPadding: 0
                                                    horizontalPadding: 0
                                                    MouseArea
                                                        {
                                                        anchors.fill: parent
                                                        onClicked:
                                                            {
                                                            my_app.slot_change_fmt(4)
                                                            console.log("out: Изменить формат сэмпла на: " + fmt_f64.text)
                                                            }
                                                        }
                                                }
                                            }

                                }
                            }
                    }


            S83_parametr_group
                {
                 name_group:    "Опции ALSA"

                 Layout.alignment: Qt.AlignBottom
                 Layout.fillWidth: true

                 content_component:
                 ColumnLayout
                         {
                         spacing:        0

                         property int offset_x: 10 //Смещение для чекбоксов

                         S83_CheckBox
                             {
                             id:            chb_alsa_rsml
                             text_color:    "white"

                             checked:       false
                             text:          "Откл. ALSA преобразования"
                             padding:       5

                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x

                             font.pixelSize:    18
                             onClicked:
                                 {
                                 console.log("out: CheckBox [Отключить ALSA преобразования]: " + chb_alsa_rsml.checked)
                                 my_app.slot_opt_alsa(chb_alsa_rsml.checked,chb_alsa_softvol.checked,chb_acces.checked)
                                 }
                             }

                         S83_CheckBox
                             {
                             id:            chb_alsa_softvol
                             text_color:    "white"

                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x

                             checked:   false
                             text:      "Откл. ALSA PCM рег. громкости"
                             padding:   5
                             font.pixelSize: 18
                             onClicked:
                                 {
                                 console.log("out: CheckBox [Отключить программную рег. громкости]: " + chb_alsa_softvol.checked)
                                 my_app.slot_opt_alsa(chb_alsa_rsml.checked,chb_alsa_softvol.checked,chb_acces.checked)
                                 }
                             }

                         S83_CheckBox
                             {
                             id:            chb_acces
                             text_color:    "white"

                             Layout.alignment:  Qt.AlignBottom
                             Layout.fillWidth:  true
                             Layout.leftMargin: offset_x
                             enabled:   false
                             checked:   true
                             text:      "Монопольный доступ"
                             padding:   5
                             font.pixelSize: 18
                             onClicked:
                                 {
                                 console.log("out: CheckBox [Монопольный доступ]: " + chb_acces.checked)
                                 my_app.slot_opt_alsa(chb_alsa_rsml.checked,chb_alsa_softvol.checked,chb_acces.checked)
                                 }
                             }


                         Connections
                                 {
                                 target: my_app

                                 function onSig_opt_alsa(arg_value1, arg_value2, arg_value3)
                                     {
                                     console.log("in: Установить CheckBoxS [Опции ALSA] " + arg_value1 + " " + arg_value2 + " " + arg_value3)
                                     chb_alsa_rsml.checked      = arg_value1
                                     chb_alsa_softvol.checked   = arg_value2
                                     //chb_acces.checked          = arg_value3
                                     }
                                }

                     }
                }

        }

    }
