import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_parametr_group
{
    Layout.alignment:   Qt.AlignBottom
    Layout.fillWidth:   true

    content_component:
    ColumnLayout
        {
        spacing:        0
        S83_parametr_classic
            {
            id:             par_app_name
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true

            change_padding: 5
            text_label:     "Приложение:"
            text_value:     "C83"
            }

        S83_parametr_classic
            {
            id:             par_version

            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            change_padding: 5
            text_label:     "Версия:"

            text_value:     version_name

            }

        S83_parametr_classic
            {
            id:                 par_developer
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Загрузить с облака:"
            text_value:         " "

            Text
                {
                text:           "Открыть"
                color:          "white"
                font.pixelSize: 18
                anchors.right:  parent.right

                anchors.verticalCenter:   parent.verticalCenter

                anchors.rightMargin: 7
                font.underline: true
                MouseArea
                    {
                    anchors.fill: parent
                    onClicked:
                        {
                        //Qt.openUrlExternally("https://cloud.mail.ru/public/rH8x/n5FJViueZ")
                        Qt.openUrlExternally("https://cloud.mail.ru/public/AkD7/LU5GEWmy3")
                        }
                    }
                }
            }
/*
        S83_parametr_classic
            {
            id:                 par_developer2
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Загрузить с github:"
            text_value:         " "

            Text
                {
                text:           "Открыть"
                color:          Qt.lighter(par_developer.color_label, 0.75)
                font.pixelSize: 18
                anchors.right:  parent.right

                anchors.verticalCenter:   parent.verticalCenter

                anchors.rightMargin: 7
                font.underline: true
                MouseArea
                    {
                    anchors.fill: parent
                    onClicked:
                        {
                        Qt.openUrlExternally("https://sergiy-83.github.io/AC83/")
                        }
                    }
                }
            }
        */
        S83_parametr_classic
            {
            id:                 par_date
            Layout.alignment:   Qt.AlignBottom
            Layout.fillWidth:   true
            change_padding:     5
            text_label:         "Дата сборки:"
            text_value:         "-"
            }



        Connections
        {
            target: my_app

            function onSig_build_date(arg_date)
            {
                par_date.text_value = arg_date
            }
        }

    }


}
