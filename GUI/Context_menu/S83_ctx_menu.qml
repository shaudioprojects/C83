import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.12
import "../S83_controls"

S83_Dialog
{
    id:     ctx_dialog
    title:  "Title"
    modal:  true

    width:              310
    contentHeight:      400

    anchors.centerIn: parent

    property alias  text_btn_content:   btn_ok.text
    property int    item_num:           0

    //Содержимое
    Flickable
        {
        id:              flk_ctx
        anchors.fill:    parent
        clip:            true
        contentWidth:    flk_ctx.width
       // contentHeight:   cl_ctx_list.height
        contentHeight:   ctx_dialog.height

        boundsBehavior:     Flickable.OvershootBounds
        boundsMovement:     Flickable.StopAtBounds
        ScrollBar.vertical: S83_VerticalScrollBar  { }

      //  Rectangle
      //  {
      //  color: "red"
      ///  anchors.fill:    parent
      //  }

    ColumnLayout
        {
        id:             cl_ctx_list
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.top:    parent.top
        spacing:        0

        S83_ctx_menu_item
                {
                id:                 mi_play
                item_text:          "Воспроизвести"
                item_icon:          "qrc:/Icon/for_ctx_menu/01.play.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_pause
                item_text:          "Пауза"
                item_icon:          "qrc:/Icon/for_ctx_menu/02.pause.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_pause()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_open
                item_text:          "Открыть"
                item_icon:          "qrc:/Icon/for_ctx_menu/03.open.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_open_all
                item_text:          "Открыть все"
                item_icon:          "qrc:/Icon/for_ctx_menu/03.open_all.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open_all()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_open_bk
                item_text:          "Открыть фоновый список"
                item_icon:          "qrc:/Icon/for_ctx_menu/05.open_bk.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open_bk_list()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_add_poff
                item_text:          "Доб. завершение работы"
                item_icon:          "qrc:/Icon/for_ctx_menu/04.poweroff.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_poff_add()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_ass_target_pls
                item_text:          "Задать как целевой плейлист"
                item_icon:          "qrc:/Icon/for_ctx_menu/06.as_target.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_as_target()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_add_to_pls
                item_text:          "Доб. в целевой плейлист"
                item_icon:          "qrc:/Icon/for_ctx_menu/07.add_to_target.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_add_to_pls()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_add_to_bk
                item_text:          "Добавить в фоновый"
                item_icon:          "qrc:/Icon/for_ctx_menu/08.add_to_bk.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_add_to_bk_pls()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_new_pls
                item_text:          "Новый плейлист"
                item_icon:          "qrc:/Icon/for_ctx_menu/09.new_folder.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    dialog_new_playlist.visible = true
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_rename
                item_text:          "Переименовать"
                item_icon:          "qrc:/Icon/for_ctx_menu/10.rename.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:
                    {
                    dialog_rename.visible   = true
                    ctx_dialog.visible      = false
                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_delete
                item_text:          "Удалить в корзину"
                item_icon:          "qrc:/Icon/for_ctx_menu/12.delete.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_delete_to_cart()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_hide
                item_text:          "Удалить из списка"
                item_icon:          "qrc:/Icon/for_ctx_menu/11.hide.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_delete_from_list()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_mark_all
                item_text:          "Выделить все файлы"
                item_icon:          "qrc:/Icon/for_ctx_menu/15.mark_all.svg"
                Layout.alignment:   Qt.AlignBottom
                visible:            true
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_mark_all()
                                    ctx_dialog.visible = false
                                    }
                }

        S83_ctx_menu_item
                {
                id:                 mi_clean_all_mark
                item_text:          "Снять все выделения"
                item_icon:          "qrc:/Icon/for_ctx_menu/14.no_check.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_mark_all_clear()
                                    ctx_dialog.visible = false
                                    }
                }
        S83_ctx_menu_item
                {
                id:                 mi_like
                item_text:          "Нравится"
                item_icon:          "qrc:/Icon/for_ctx_menu/16.like.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_like(0)
                                    ctx_dialog.visible = false
                                    }
                }
        S83_ctx_menu_item
                {
                id:                 mi_like_remove
                item_text:          "Больше не нравится"
                item_icon:          "qrc:/Icon/for_ctx_menu/16.like_remove.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_like(1)
                                    ctx_dialog.visible = false
                                    }
                }
        S83_ctx_menu_item
                {
                id:                 mi_open_album
                item_text:          "Перейти к альбому"
                item_icon:          "qrc:/Icon/for_ctx_menu/03.open.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open_album()
                                    ctx_dialog.visible = false
                                    }
                }
        S83_ctx_menu_item
                {
                id:                 mi_open_artist
                item_text:          "Перейти к исполнителю"
                item_icon:          "qrc:/Icon/for_ctx_menu/03.open.svg"
                Layout.alignment:   Qt.AlignBottom
                Layout.fillWidth:   true
                onItemClicked:      {
                                    my_app.slot_open_artist()
                                    ctx_dialog.visible = false
                                    }
                }
        }
    }

    //низ
    footer:
    RowLayout
            {
            Item
                    {
                    width: 50
                    Layout.fillWidth: true //Чтоб размер растягивался
                    }

                S83_Button
                    {
                    id:                 btn_ok
                    btn_color:          current_theme.color_ctrl_main_color
                    text:               "Отмена"
                    Layout.fillWidth:   true //Чтоб размер растягивался
                    onClicked:          accept();
                    }

                Item
                    {
                    width: 50
                    Layout.fillWidth: true //Чтоб размер растягивался
                    }
            }

    onAccepted:
        {
        console.log("Нажата ктопка диалога Отмена")
        visible = false
        }

    Connections
        {
        target: my_app
        function onSig_ctx_close()
                {
                ctx_dialog.visible = false
                }

        function onSig_context_menu(arg_value,arg_fname)
                {
               // ctx_dialog.height = cl_ctx_list.height + 100
                item_num = 1
                console.log("in: Контекстное меню: " + arg_value)
                if (arg_value & 0x1)    {mi_play.visible = true; item_num++}                //Play
                else                    mi_play.visible = false

                if (arg_value & 0x2)    {mi_pause.visible = true; item_num++}               //Pause
                else                    mi_pause.visible = false

                if (arg_value & 0x4)    {mi_add_poff.visible = true; item_num++}            //Add poff
                else                    mi_add_poff.visible = false

                if (arg_value & 0x8)    {mi_ass_target_pls.visible = true; item_num++}      //ass target pls
                else                    mi_ass_target_pls.visible = false

                if (arg_value & 0x10)   {mi_add_to_pls.visible = true; item_num++}          //add to pls
                else                    mi_add_to_pls.visible = false

                if (arg_value & 0x20)   {mi_delete.visible = true; item_num++}              //delete
                else                    mi_delete.visible = false

                if (arg_value & 0x40)   {mi_hide.visible = true; item_num++}                //hide
                else                    mi_hide.visible = false

                if (arg_value & 0x80)   {mi_open.visible = true; item_num++}                //open
                else                    mi_open.visible = false

                if (arg_value & 0x100)  {mi_open_all.visible = true; item_num++}             //open all
                else                    mi_open_all.visible = false

                if (arg_value & 0x400)  {mi_new_pls.visible = true; item_num++}              //new_pls
                else                    mi_new_pls.visible = false

                if (arg_value & 0x800)  {mi_rename.visible = true; item_num++}              //rename
                else                    mi_rename.visible = false

                if (arg_value & 0x1000) {mi_add_to_bk.visible = true; item_num++}           //Добавить в фоновый
                else                    mi_add_to_bk.visible = false

                if (arg_value & 0x2000) {mi_open_bk.visible = true; item_num++}             //Открыть фоновый
                else                    mi_open_bk.visible = false

                if (arg_value & 0x4000) {mi_clean_all_mark.visible = true; item_num++}      //Снять все выделения
                else                    mi_clean_all_mark.visible = false

                if (arg_value & 0x8000) {mi_like.visible = true; item_num++}                //Нравится
                else                    mi_like.visible = false;

                if (arg_value & 0x10000) {mi_like_remove.visible = true; item_num++}        //Больше не нравится
                else                    mi_like_remove.visible = false;

                if (arg_value & 0x20000) {mi_open_album.visible = true; item_num++}        //Открыть альбом
                else                    mi_open_album.visible = false;

                if (arg_value & 0x40000) {mi_open_artist.visible = true; item_num++}        //Открыть исполнителя
                else                    mi_open_artist.visible = false;

                dialog_rename.text_edit = arg_fname //Если будем переименовывать
                ctx_menu.visible = true //Отобразить

                var height_menu = item_num * 40
                flk_ctx.contentHeight = height_menu
                contentHeight = height_menu


                console.log("in: Высота итемов: " + item_num * 40)

                }
        }

    onVisibleChanged:  if (!visible)  my_app.slot_ctx_close() //Закрыть меню на всех клиентах




}
