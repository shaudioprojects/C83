import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"



S83_page_opt
    {
    id: page_s83

    content_component:
    Rectangle
        {
        id:             rect_content
        color:          "transparent"
        clip:           true

        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top

        height:         cl_my_buttons.height +5 //300

        property int btn_lr_margin : 10


        ColumnLayout
                {
                id: cl_my_buttons
                anchors.left:       parent.left
                anchors.right:      parent.right
                anchors.top:        parent.top
                spacing:            0



            S83_Button
                {
                id:                 btn_poffac
                width:              200
                height:             50

                enabled:            state_conected

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10
                Layout.topMargin:   5

                contentItem: S83_Text_for_buttons
                    {
                    text: "Завершение работы AC83"
                    }

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          dialog_acoff.visible = true
                }




            S83_Button
                {
                //text:               "Задать текущий каталог, как стартовый."
                width:              200
                height:             50
                enabled:            state_conected

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                contentItem: S83_Text_for_buttons
                    {
                    text: "Задать текущий каталог, как стартовый"
                    }

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          dialog_start_path.visible = true
                }
/*
            S83_Button
                {
                text:               "Обновить список файлов."
                width:              200
                height:             50
                enabled:            state_conected

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          my_app.slot_test_update_file_list();
                }
*/
            S83_Button
                {
                id:      btn_upd_check
                width:   200
                height:  50
                enabled: state_conected

                contentItem: S83_Text_for_buttons
                    {
                    text: "Проверить обновления AC83"
                    }

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          { my_app.slot_update(0); }
                }
            S83_Button
                {
                id:      btn_upd_apply
                width:   200
                height:  50

                enabled: false
                contentItem: S83_Text_for_buttons
                    {
                    text: "Обновить AC83"
                    }

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          { my_app.slot_update(1); }
                }

            S83_Button
                {

                width:              200
                height:             50


                contentItem: S83_Text_for_buttons
                    {
                    text: "Выход"
                    }

                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                Layout.leftMargin:  10
                Layout.rightMargin: 10

                btn_color:          current_theme.color_ctrl_main_color
                onClicked:          { my_app.slot_prepare_for_exit(); Qt.quit() }
                }

            Connections
                {
                target: my_app

                function onSig_update(arg_value)
                    {
                    if (arg_value === 3)    btn_upd_apply.enabled = true
                    else                    btn_upd_apply.enabled = false
                    }

                }


            }




        }


    }


