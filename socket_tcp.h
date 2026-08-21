#pragma once
#include <qglobal.h>

#ifdef Q_OS_UNIX
#include <arpa/inet.h>
#endif

#ifdef Q_OS_WINDOWS
#include "winsock2.h"
#endif




#include <string>

class tcp_socket
{
private:
    struct  sockaddr_in addr;
    #ifdef Q_OS_UNIX

    int     socket_des;
    #endif

    #ifdef Q_OS_WINDOWS
    WSADATA wsadata;
    SOCKET  socket_des;
    #endif

    std::string         sock_error;

public:
    tcp_socket();

    int     create_socket       (void);                                     //Создать сокет
    int     connect_to_server   (std::string arg_ip,int arg_port    );      //Подключится к серверу
    int     buffer_send         (char *arg_buffer,  int arg_max_size);      //Отослать буффер
    int     buffer_read         (char *arg_buffer,  int arg_max_size);      //Прочитать буффер
    int     connection_close    (void);                                     //Разорвать подключение по хорошему
    int     connection_abort    (void);                                     //Разорвать подключение по плохому
    char*   get_str_error       (void) {return (char*)sock_error.c_str();}  //Получить указатель на строку ошибки
    void    stat_reset(void);

    std::string m_ipaddres;
    int         m_port;
    uint64_t    m_num_send_bytes;
    uint64_t    m_num_recv_bytes;
};
