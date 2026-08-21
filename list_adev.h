#pragma once
#include <QAbstractListModel>
#include <QList>

#include "item_list_adev.h"

class List_adev_model : public QAbstractListModel
{
    Q_OBJECT
public:
    List_adev_model();

   // void list_clear();
    void update_list(QList<Item_list_adev> *data);

    int                     rowCount(const QModelIndex& parent = {}) const override;
    QVariant                data(const QModelIndex& index = {}, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray>  roleNames() const override;

private slots:


private:
    QList<Item_list_adev> *m_aouts;

    enum ItemRoles
        {
        name_card_Role,
        name_aout_Role,
        name_i_card,
        str_desc
        };


};
