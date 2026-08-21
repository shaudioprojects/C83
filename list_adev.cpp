#include "list_adev.h"
#include <QQmlEngine>
#include <QDebug>

List_adev_model::List_adev_model()
    {
    m_aouts = new QList<Item_list_adev>;
    }

//Количество элементов в списке
int List_adev_model::rowCount(const QModelIndex& parent) const
    {
    Q_UNUSED(parent)
    return static_cast<int>(m_aouts->size());
    }

QVariant List_adev_model::data(const QModelIndex& index, int role) const
    {
        if (!index.isValid() || index.row() > rowCount(index)) { return {}; }

        const Item_list_adev& aout_item = m_aouts->at(index.row());
        switch (role)
            {
            case ItemRoles::name_card_Role: {
                                            return QVariant::fromValue(aout_item.m_Card);
                                            }
            case ItemRoles::name_aout_Role: {
                                            return QVariant::fromValue(aout_item.m_nAout);
                                            }
            case ItemRoles::name_i_card:    {
                                            return QVariant::fromValue(aout_item.i_card);
                                            }
            case ItemRoles::str_desc:       {
                                            return QVariant::fromValue(aout_item.m_desc);
                                            }
            default:{ return {}; }
            }
    }

QHash<int, QByteArray> List_adev_model::roleNames() const
    {
    QHash<int, QByteArray> roles;
    roles[ItemRoles::name_card_Role] = "nameCardRole";
    roles[ItemRoles::name_aout_Role] = "nameAoutRole";
    roles[ItemRoles::name_i_card]    = "i_cardRole";
    roles[ItemRoles::str_desc]       = "Aout_Desc";

    return roles;
    }

//Применить новый список
void List_adev_model::update_list(QList<Item_list_adev> *arg_data)
    {
    beginResetModel();
    delete m_aouts;     //Удаляем старый
    m_aouts = arg_data; //Используем новый
    endResetModel();
    }
