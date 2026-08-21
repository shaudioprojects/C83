#pragma once

#include <QAbstractListModel>
#include <QList>

#include "item_list_alsa_vregch.h"

class List_alsa_vregch_model : public QAbstractListModel
    {
    Q_OBJECT
public:
    List_alsa_vregch_model();

    void update_list(QList<Item_list_alsa_vregch> *data);

    int                     rowCount(const QModelIndex& parent = {}) const override;
    QVariant                data(const QModelIndex& index = {}, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray>  roleNames() const override;

private:
    QList<Item_list_alsa_vregch> *m_vregchs;

    enum ItemRoles
        {
        name_channel
        };

    };


