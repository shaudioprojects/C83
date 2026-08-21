#include "item_list_file.h"

Item_list_file::Item_list_file(QString arg_name_file, QString arg_name_ext, uint arg_icon, uint arg_flags, QColor arg_color)
    : m_nFile {std::move(arg_name_file)},  m_nExt {std::move(arg_name_ext)}
    {
    m_nIcon = arg_icon;
    m_color = arg_color;
    m_flags = arg_flags;
    }




