#include <QQmlEngine>
#include <QDebug>
#include <QThread>

#include "list_file.h"
#include "logging.h"

List_file_Model::List_file_Model()
    {
    m_list_current = new QList<Item_list_file>;
    }

//Количество элементов в списке
int List_file_Model::rowCount(const QModelIndex& parent) const
    {
    Q_UNUSED(parent)
    return static_cast<int>(m_list_current->size());
    }

QVariant List_file_Model::data(const QModelIndex& index, int role) const
    {
    if (!index.isValid() || index.row() > rowCount(index)) {return {}; }

    const Item_list_file& contact = m_list_current->at(index.row());
    switch (role)
            {
            case ItemRoles::role_name_file: { return QVariant::fromValue(contact.m_nFile);  }
            case ItemRoles::role_name_ext:  { return QVariant::fromValue(contact.m_nExt);   }
            case ItemRoles::role_color:     { return QVariant::fromValue(contact.m_color);  }
            case ItemRoles::role_icon:      { return QVariant::fromValue(contact.m_nIcon);  }
            case ItemRoles::role_flags:     { return QVariant::fromValue(contact.m_flags);  }
            default: { return {}; }
            }
    }

QHash<int, QByteArray> List_file_Model::roleNames() const
    {
    QHash<int, QByteArray> roles;
   // LOGGING<<" -< "<<QThread::currentThread();

    roles[ItemRoles::role_name_file] = "nF";
    roles[ItemRoles::role_name_ext]  = "nE";
    roles[ItemRoles::role_color]     = "nCl";
    roles[ItemRoles::role_icon]      = "nIc";
    roles[ItemRoles::role_flags]     = "nFl";
    return roles;
    }

//Применить новый список
void List_file_Model::update_list(QList<Item_list_file> *arg_data)
    {
    beginResetModel();

    QList<Item_list_file> *tmp = m_list_current;
    m_list_current  = arg_data;
    delete tmp;  //Удаляем старый

    endResetModel();
    }

void List_file_Model::reset_model()
    {
    beginResetModel();
    endResetModel();
    }

//Очистить список
void List_file_Model::clear_list(void)
    {
    beginResetModel();
    m_list_current->clear();

    endResetModel();
    }

//void List_file_Model::test_fun(int arg_index)
   // {
    //Item_list_file &tmp = (Item_list_file&)m_list_current->at(arg_index);
    //LOGGING<<"-----------eee------------";
    //tmp.m_nFile = "11111";
    //endResetModel();
    //endMoveColumns();
  //  }
