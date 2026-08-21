#pragma once

#include <QString>
#include <QColor>

class Item_list_file
    {
    public:
        Item_list_file() = default;
        Item_list_file(QString arg_name_file, QString arg_name_ext, uint arg_icon, uint arg_flags, QColor arg_color);

        QString m_nFile;    //Имя файла
        QString m_nExt;     //Имя расширения
        int     m_nIcon;    //Номер иконки
        int     m_flags;    //флаги
        QColor  m_color;    //Цвет
    };

