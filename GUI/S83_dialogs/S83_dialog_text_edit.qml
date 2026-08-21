import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12


import "../S83_controls"

S83_dialog_ok
{
    id:             dialog_text_edit
    text_content:   " "
    width:          parent.width * 0.9
    height:         200
    property alias  text_edit:              textEdit.text
    property string name_default_playlist:  "Новый плейлист"

    TextInput
            {
            id:                 textEdit
            width:              parent.width - 50
            height:             60
            clip:               true
            //wrapMode: TextEdit.NoWrap
            autoScroll:         true
            anchors.centerIn:   parent
            echoMode:               TextInput.Normal
            mouseSelectionMode:     TextInput.SelectCharacters
            horizontalAlignment:    TextInput.AlignHCenter
            verticalAlignment:      TextInput.AlignVCenter

            font.pixelSize:     18
            color:              "white"
            selectionColor:     "gray"
            text:               name_default_playlist
            focus:              true

            cursorPosition: 1
            selectByMouse: true



            Rectangle
                    {
                    anchors.fill:   parent
                    color:          "gray"
                    visible:        false //textEdit.width < textEdit.contentWidth
                    radius:         5
                    z:              -1
                    }

            onEditingFinished:
                {
                //dialog_text_edit.accept();
                }

            onActiveFocusChanged:
                {
                    if (activeFocus )
                        {
                        if (Qt.platform.os !== "windows")
                            {
                            dialog_text_edit.y = dialog_text_edit.parent.height * 0.15
                            //console.log("Виртуальная клавиатура отображается")
                            }
                        }

                }
            }

    Component.onCompleted:
        {
        dialog_text_edit.height = 180
        }

    onVisibleChanged:
        {
        console.log("onVisibleChanged")
          textEdit.focus = true
        }

    //Кнопки
    footer:
    ColumnLayout
        {
        spacing: 0
        Item
            {
            height: 2
            //Layout.fillWidth: true //Чтоб размер растягивался
            }
        RowLayout
            {

            Item
                {
                width: 20
                //Layout.fillWidth: true //Чтоб размер растягивался
                }

            S83_Button
                {
                width: 20
                padding:0
                btn_color:          current_theme.color_ctrl_main_color
                text:               ""//"\u2190"
                Layout.fillWidth:   true //Чтоб размер растягивался

                Layout.preferredWidth: 80
                onClicked:
                    {
                    textEdit.cursorPosition = textEdit.cursorPosition - 1
                    textEdit.cursorVisible = true
                    }
                icon.color:     "transparent"
                icon.source:    "qrc:/Icon/for_buttons/cursor_left.svg";
                }

            S83_Button
                {
                width: 20
                padding:0
                btn_color:          current_theme.color_ctrl_main_color
                text:               "Копир."
                Layout.fillWidth:   true //Чтоб размер растягивался

                Layout.preferredWidth: 150
                onClicked:
                    {
                    textEdit.copy()
                    textEdit.cursorVisible = true
                    }

                }
            S83_Button
                {
                width: 20
                padding:0
                btn_color:          current_theme.color_ctrl_main_color
                text:               "Вставить"
                Layout.fillWidth:   true //Чтоб размер растягивался

                Layout.preferredWidth: 150
                onClicked:
                    {
                    textEdit.paste()
                    textEdit.cursorVisible = true
                    }

                }

            S83_Button
                {
                width: 30
                btn_color:          current_theme.color_ctrl_main_color
                text:               ""//"\u2192"
                Layout.fillWidth:   true //Чтоб размер растягивался

                Layout.preferredWidth: 80
                onClicked:
                    {
                    textEdit.cursorPosition = textEdit.cursorPosition + 1
                    textEdit.cursorVisible = true
                    }
                icon.color:     "transparent"
                icon.source:    "qrc:/Icon/for_buttons/cursor_rigth.svg";
                }

            Item
                {
                width: 20
              //  Layout.fillWidth: true //Чтоб размер растягивался
                }
            }

        RowLayout
        {
        Layout.topMargin: -5
        Item
            {
            width: 20
            //Layout.fillWidth: true //Чтоб размер растягивался
            }


        S83_Button
            {
                flat: true
            btn_color:          current_theme.color_ctrl_main_color
            text:               "Отмена"
            Layout.fillWidth:   true //Чтоб размер растягивался
            Layout.preferredWidth: 150
            Layout.topMargin:   0
            onClicked:
                {
                dialog_text_edit.visible = false
                textEdit.text = name_default_playlist
                }
            }


        S83_Button
            {
            btn_color:          current_theme.color_ctrl_main_color
            text:               "Ок"
            Layout.fillWidth:   true //Чтоб размер растягивался
            Layout.preferredWidth: 150

            onClicked:
                {
                dialog_text_edit.accept();
                }
            }

        Item
            {
            width: 20
          //  Layout.fillWidth: true //Чтоб размер растягивался
            }

        }

        Item
            {
            height: 2
            //Layout.fillWidth: true //Чтоб размер растягивался
            }
    }
}
