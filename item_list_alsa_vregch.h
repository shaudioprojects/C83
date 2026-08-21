#pragma once

#include <QString>
#include <QColor>

class Item_list_alsa_vregch
	{
	public:
		Item_list_alsa_vregch() = default;
		Item_list_alsa_vregch(QString arg_ch_name);

		QString m_name_ch;    //Имя канала
	};

