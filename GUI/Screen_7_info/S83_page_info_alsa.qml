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
        spacing:        0

        S83_parametr_classic
            {
            id:                 par_alsa_freq
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true

            change_padding: 5
            text_label:     "Частота дискретизации:"
            text_value:     "-"
            }

        S83_parametr_classic
            {
            id:                 par_alsa_fsample
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true

            change_padding: 5
            text_label:     "Формат сэмпла:"
            text_value:     "-"
            }

        S83_parametr_classic
            {
            id:                 par_alsa_bitrate
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true

            change_padding: 5
            text_label:     "Битрейт:"
            text_value:     "-"
            }

        S83_parametr_classic
            {
            id:                 par_alsa_ch
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true

            change_padding: 5
            text_label:     "Каналов:"
            text_value:     "-"
            }

        S83_parametr_classic
            {
            id:                 par_alsa_codec
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true

            change_padding: 5
            text_label:     "Кодек:"
            text_value:     "-"
            }

        S83_parametr_classic
        {
            id:             par_alsa_version

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5

            text_label:     "Версия:"


            text_value:     "-"


        }

        Connections
            {
            target: my_app

            function onSig_disconnected()
                {
                var defice = "-"
                par_alsa_freq.text_value    = defice
                par_alsa_fsample.text_value = defice
                par_alsa_bitrate.text_value = defice
                par_alsa_ch.text_value      = defice
                par_alsa_codec.text_value   = defice
                par_alsa_version.text_value = defice
                }

            //ALSA частота дискретизации
            function onSig_aout_freq_current(arg_value)
                {

                if(arg_value)
                    {
                    par_alsa_freq.text_value = arg_value / 1000
                    par_alsa_freq.text_value += " КГц"
                    }
                else
                    {
                    par_alsa_freq.text_value = "-"
                    }

                if (decoder_freq !== arg_value )
                    par_alsa_freq.value_warning = true
                else
                    par_alsa_freq.value_warning = false
                }

            //ALSA формат сэмпла
            function onSig_aout_fmt_current(arg_value)
                {
                par_alsa_fsample.text_value = arg_value

                if (decoder_sample_format !== arg_value)
                    par_alsa_fsample.value_warning = true
                else
                    par_alsa_fsample.value_warning = false
                }

            //ALSA количество каналов
            function onSig_aout_ch_count(arg_value1,arg_value2,arg_value3)
                {
                if (arg_value1)
                    par_alsa_ch.text_value = arg_value1
                else
                    par_alsa_ch.text_value = "-"

                if (decoder_channel_count !== arg_value1)
                    par_alsa_ch.value_warning = true
                else
                    par_alsa_ch.value_warning = false
                }

            //ALSA битрейт
            function onSig_aout_bitrate(arg_value)
                {
                if (arg_value)
                    {
                    par_alsa_bitrate.text_value = arg_value / 1000
                    par_alsa_bitrate.text_value += " КБит/сек"
                    }
                else
                    {
                    par_alsa_bitrate.text_value = "-"
                    }
                }

            //ALSA кодек
            function onSig_aout_codec(arg_value)
                {
                par_alsa_codec.text_value = arg_value
                }

            //ALSA версия
            function onSig_aout_info(arg_version)
                {
                par_alsa_version.text_value = arg_version
                }


        }

    }


}
