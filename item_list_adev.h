#pragma once

#include <QString>

class Item_list_adev
{

public:
    Item_list_adev() = default;
    Item_list_adev(QString arg_card_name, QString arg_aout_name, QString arg_aout_desc,bool arg_card);

    QString m_Card;    //Имя Карты
    QString m_nAout;   //Имя Аудиовыхода
    QString m_desc;    //Описание аудиовыхода если i_card = false

    bool i_card;       //флаг - я карта и имя мне m_Card
};


