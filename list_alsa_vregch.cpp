#include "list_alsa_vregch.h"

//Конструктор
List_alsa_vregch_model::List_alsa_vregch_model()
    {
    m_vregchs = new QList<Item_list_alsa_vregch>;
    }

//Количество элементов в списке
int List_alsa_vregch_model::rowCount(const QModelIndex& parent) const
    {
    Q_UNUSED(parent)
    return static_cast<int>(m_vregchs->size());
    }

QVariant List_alsa_vregch_model::data(const QModelIndex& index, int role) const
    {
        if (!index.isValid() || index.row() > rowCount(index)) { return {}; }

        const Item_list_alsa_vregch& vregch_item = m_vregchs->at(index.row());
        switch (role)
            {
            case ItemRoles::name_channel:   { return QVariant::fromValue(vregch_item.m_name_ch); }

            default:{ return {}; }
            }
    }

QHash<int, QByteArray> List_alsa_vregch_model::roleNames() const
    {
    QHash<int, QByteArray> roles;
    roles[ItemRoles::name_channel] = "nameChannelRole";
    return roles;
    }

//Применить новый список
void List_alsa_vregch_model::update_list(QList<Item_list_alsa_vregch> *arg_data)
    {
    beginResetModel();
    delete m_vregchs;     //Удаляем старый
    m_vregchs = arg_data; //Используем новый
    endResetModel();
    }
