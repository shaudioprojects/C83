#pragma once
#include <QAbstractListModel>
#include <QList>

#include "item_list_file.h"

class List_file_Model : public QAbstractListModel
    {
    Q_OBJECT
public:
    List_file_Model();
    void update_list(QList<Item_list_file> *data); //Применить новый список
    void reset_model(void);
    void clear_list(void); //Очистить список

    //void test_fun(int arg_index);
    int                     rowCount(const QModelIndex& parent = {}) const override;
    QVariant                data(const QModelIndex& index = {}, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray>  roleNames() const override;

private:
    QList<Item_list_file> *m_list_current; //Указатель на список рабочий

    enum ItemRoles
        {
        role_name_file,
        role_name_ext,
        role_color,
        role_icon,
        role_flags
        };
    };
