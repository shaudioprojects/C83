import QtQuick 2.0

Item
    {
    property color color_background:        "black"         //Цвет фона
    property color color_ctrl_background:   "#1f1f1f"     //Фоновый цвет области с контролами
    property color color_ctrl_selected:     "#262626"       //Выделенный элемент в области элементов
    property color color_ctrl_main_color:   "#7f7f7f"       //Основной темный цвет органа управления

    property color color_ctrl_cursor_border:"white"         //Цвет контура курсора списка файлов
    property color color_ctrl_cursor:       "#202020"       //Цвет курсора списка файлов
    property color color_ctrl_disable:      "#404040"       //Цвет отключенного элемента

    property string icon_play:              "qrc:/Icon/for_file/play/play_gray.svg"
    property string icon_pause:             "qrc:/Icon/for_file/pause/pause_gray.svg"
    property string bk_image:               "qrc:/Icon/for_page/bk_black.jpg"
    }
