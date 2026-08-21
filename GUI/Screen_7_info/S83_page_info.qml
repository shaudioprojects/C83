import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_info

    content_component:

    ColumnLayout
                {
                anchors.left:   parent.left
                anchors.right:  parent.right
                anchors.top:    parent.top

                clip:           true
                spacing:        0

                S83_page_info_convert_state
                    {
                    id: par_group_info_state
                    name_group:     "Преобразования"
                    }

                S83_page_info_decoder
                    {
                    id: par_group_info_decoder
                    name_group:     "Декодер"
                    }

                S83_page_info_alsa
                    {
                    id: par_group_info_alsa
                    name_group:     "ALSA"

                    decoder_sample_format:  par_group_info_decoder.decoder_sample_format
                    decoder_channel_count:  par_group_info_decoder.decoder_channel_count
                    decoder_freq:           par_group_info_decoder.decoder_freq
                    }

                S83_page_info_devices
                    {
                    id: par_group_devices
                    name_group:     "Устройства"

                    }

                S83_page_info_about_content
                    {
                    id: par_group_info_client
                    name_group:     "Клиент"
                    }

                S83_page_info_about2_content
                    {
                    id: par_group_info_server
                    name_group:     "Сервер"
                    }



                }


    }


