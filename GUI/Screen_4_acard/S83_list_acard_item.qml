import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

Rectangle
{
    width:  list_acard.width - 6

    height: 32
    anchors.leftMargin: 5
    color:         i_cardRole ? current_theme.color_ctrl_selected : "transparent"
    border.color:  "transparent"
    radius: 5



    property int text_list_item_string_size: 18
    property int def_margin: 5
    property int text_y_correction:-2

    //Иконка
    Image
         {
         id:     icon_acard
         width:  28
         height: 28
         visible:                i_cardRole
         anchors.verticalCenter: parent.verticalCenter
         anchors.left:           parent.left
         anchors.leftMargin:     def_margin
         source:                 "qrc:/Icon/for_aout_list/chip.svg"
         }


    // Я Аудиокарта
    Text
         {
         text:   nameCardRole
         width:  100
         anchors.verticalCenter:         parent.verticalCenter
         anchors.verticalCenterOffset:   text_y_correction
         elide:  Text.ElideRight  //Сокращение точками
         //clip: true
         anchors.right:          parent.right
         anchors.left:           icon_acard.right
         anchors.leftMargin:     def_margin
         anchors.rightMargin:    5
         visible: i_cardRole
         Layout.fillWidth: true
         font.bold: true
         color:                  "white"
         font.pixelSize:         text_list_item_string_size
         }


        //Я Аудиовыход
        S83_RadioButton
            {
            width:                  100
            height:                 38
            anchors.right:          parent.right
            anchors.left:           parent.left

            anchors.leftMargin:     20
            anchors.rightMargin:    5
            text:                   nameAoutRole
            visible:                !i_cardRole

            checked:                selected_name === nameAoutRole     //Выделим если имена совподают
            anchors.verticalCenter: parent.verticalCenter


            contentItem:
                    Text
                        {
                        text:               nameAoutRole
                        color:              "white"
                        leftPadding:        30
                        verticalAlignment:  Text.AlignVCenter

                        anchors.verticalCenter:         parent.verticalCenter
                        anchors.verticalCenterOffset:   -7

                        font.pixelSize:     text_list_item_string_size
                        elide:              Text.ElideLeft   //Сокращение точками
                        }

            onCheckedChanged:
                {

                if (checked)
                    {
                    //console.log("event: Изменился cheked делегата. Индекс - " + index)
                    list_acard.currentIndex = index
                    }
                }
            //Описание
            Text
                {
                 text:      Aout_Desc
                 color:     "gray"
                 leftPadding:       38
                 font.pixelSize:    12
                 anchors.left:      parent.left
                 anchors.right:     parent.right
                 anchors.bottom:    parent.bottom
                 anchors.bottomMargin: 3

                elide:              Text.ElideLeft   //Сокращение точками
                }
            }



        MouseArea
            {
            anchors.fill: parent

            onClicked:
                {
                if (  !i_cardRole)
                    {
                    if (selected_name !== nameAoutRole)
                        {
                        my_app.slot_click_on_acard(nameAoutRole)
                        console.log("out: Выбрать аудиовыход: " + nameAoutRole)
                        }
                    }

                }

            }


}
