import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_parametr_group
    {
    Layout.alignment:   Qt.AlignBottom
    Layout.fillWidth:   true

    property string decoder_sample_format: "-"
    property int    decoder_channel_count: 0
    property int    decoder_freq: 0

    content_component:
    ColumnLayout
        {
        spacing: 0

        S83_parametr_classic
        {
            id:             par_dec_freq

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5
            text_label:     "Частота дискретизации:"


            text_value:     "-"

        }
        S83_parametr_classic
        {
            id:             par_dec_fsample

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Формат сэмпла:"


            text_value:     "-"


        }
        S83_parametr_classic
        {
            id:             par_dec_bitrate

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Битрейт:"


            text_value:     "-"


        }
        S83_parametr_classic
        {
            id:             par_dec_ch

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Каналов:"


            text_value:     "-"


        }

        S83_parametr_classic
            {
            id:             par_dec_codec

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Кодек:"


            text_value:     "-"

            }

        S83_parametr_classic
            {
            id:             par_dec_simd

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Оптимизация SIMD:"


            text_value:     "-"

            }

        Connections
        {
            target: my_app
            function onSig_disconnected()
                {
                var defice = "-"
                par_dec_freq.text_value    = defice
                par_dec_fsample.text_value = defice
                par_dec_bitrate.text_value = defice
                par_dec_ch.text_value      = defice
                par_dec_codec.text_value   = defice
                par_dec_simd.text_value   = defice
                }
            //Декодер частота дискретизации
            function onSig_dec_freq_current(arg_value)
                {
                decoder_freq = arg_value
                console.log("in: Декодер - частота дискретизации: " + arg_value + " Гц")
                if(arg_value)
                    {
                    par_dec_freq.text_value = arg_value / 1000
                    par_dec_freq.text_value += " КГц"
                    }
                else
                    {
                    par_dec_freq.text_value = "-"
                    }
                }
            //Декодер формат сэмпла
            function onSig_dec_fmt_current(arg_value)
                {
                console.log("in: Декодер - формат сэмпла: " + arg_value)
                par_dec_fsample.text_value = arg_value
                decoder_sample_format = arg_value
                }
            //Декодер количество каналов
            function onSig_dec_ch_count(arg_value)
                {
                decoder_channel_count = arg_value
                console.log("in: Декодер - количество каналов: " + arg_value)
                if (arg_value)
                    par_dec_ch.text_value = arg_value
                else
                    par_dec_ch.text_value = "-"
                }
            //Декодер битрейт
            function onSig_dec_bitrate(arg_value)
                {
                //console.log("in: Декодер - битрейт: " + arg_value + " КБит/сек")
                if (arg_value)
                    {
                    par_dec_bitrate.text_value = arg_value
                    par_dec_bitrate.text_value += " КБит/сек"
                    }
                else
                    {
                    par_dec_bitrate.text_value = "-"
                    }
                }
            //Декодер кодек
            function onSig_dec_codec(arg_value)
                {
                //console.log("in: Декодер - кодек: " + arg_value)
                par_dec_codec.text_value = arg_value
                }
            //Декодер оптимизация декодирования
            function onSig_dec_simd(arg_value)
                {
                //console.log("in: Декодер - SIMD: " + arg_value)
                par_dec_simd.text_value = arg_value
                }


        }

    }


}
