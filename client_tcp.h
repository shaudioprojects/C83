#pragma once

#include <QString>
#include <QThread>
#include <QMutex>


#include "decoder.h"
#include "socket_tcp.h"

#define BUF_SIZE 2048 //Размер буффера для чтения из сокета
//Состояния клиента
enum class client_states
    {
    CS_DISCONECTED = 0, //Отключено
    CS_CONNECTINGS,     //Выполняется подключение
    CS_CONNECTED,       //Подключено
    };

///////////////////////////////////////////////////////////////////////////////////////////
class client_tcp : public QThread
{
    Q_OBJECT
public:
    client_tcp();
    ~client_tcp();


    client_states get_client_state(void)  {return m_state;    };
    QString       get_ipaddress()         {return m_ipaddres; };
    QString       get_last_error()        {return m_last_error;};
    qint64        get_send_bytes() {return m_socket.m_num_send_bytes; };
    qint64        get_rcv_bytes()  {return m_socket.m_num_recv_bytes; };

    void set_decoder        (decoder* arg_dec); //Задать приемник
    void set_ipaddress      (QString arg_ip);   //Задать IP адресс
    void set_mode_connect   (void);
    void set_mode_no_connect(void);
    void send_raw_data      (const char *arg_data, qint64 arg_len);
    void disconnect         (void);
   // void connection_abort   (void);
    void stop_work          (void);







private:

    void            run() override; //Поток чтения
    qint64          get_rcv_data(char *arg_buff,qint64 arg_max_bytes); //Прочитать данные  из сокета


    tcp_socket      m_socket;                   //Сокет
    QMutex          m_mutex_sock;               //Мютекс доступа к функциям сокета
    QString         m_ipaddres;                //ip к которому будем подключатся
    QString         m_last_error;               //Ошибка последняя
    client_states   m_state;                    //Состояние меня
    int             m_port;                     //порт
    bool            m_flag_no_connect_mode;     //Режим "не подключаться пока"


    decoder*        m_decoder;                  //Обработчик данных
    bool            m_flag_thr_on;              //флаг разрешения работы потока чтения данных
    char            buffer_for_read[BUF_SIZE];  //Буффер для входных данных
    };


