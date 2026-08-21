#include "item_list_adev.h"



Item_list_adev::Item_list_adev(QString arg_card_name, QString arg_aout_name, QString arg_aout_desc, bool arg_card)
{
    m_Card = arg_card_name;    //Имя Карты
    m_nAout = arg_aout_name;   //Имя Аудиовыхода
    i_card = arg_card;
    m_desc = arg_aout_desc;
}
