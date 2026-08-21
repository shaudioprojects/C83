#include <QString>
#include "socket_tcp.h"


#ifdef Q_OS_UNIX
#include <sys/socket.h>
#include <unistd.h>
#include <errno.h>

tcp_socket::tcp_socket()
        {
        addr.sin_family = AF_INET;
        stat_reset();
        }

int tcp_socket::create_socket(void)
        {
        socket_des = socket(AF_INET, SOCK_STREAM, 0); // создание TCP-сокета
        if(socket_des < 0)
            {
            sock_error = qt_error_string(errno).toStdString();
            }
        return socket_des;
        }

int     tcp_socket::connect_to_server(std::string arg_ip, int arg_port)
        {
        int ret = 0;


        m_ipaddres  = arg_ip;
        m_port      = arg_port;

        addr.sin_port = htons(m_port);
        addr.sin_addr.s_addr = inet_addr(m_ipaddres.c_str());
        ret = connect(socket_des, (const struct sockaddr *)&addr, (socklen_t)sizeof(addr));
        if (ret < 0)
            {
            sock_error = qt_error_string(errno).toStdString();
            }
        return ret;
        }

int     tcp_socket::buffer_send(char *arg_buffer,int arg_max_size)
        {
        int size = 0;
        size = send(socket_des, arg_buffer, arg_max_size, MSG_NOSIGNAL);      //MSG_NOSIGNAL|MSG_DONTWAIT
        if (size < 0)
            sock_error = qt_error_string(errno).toStdString();
        else
            m_num_send_bytes += size;

        return size;
        }

int     tcp_socket::buffer_read(char *arg_buffer,int arg_max_size)
        {
        int size = recv(socket_des, arg_buffer, arg_max_size, 0);
        if (size > 0)
            m_num_recv_bytes += size;
        else
            sock_error = qt_error_string( errno ).toStdString();
        return size;
        }

int     tcp_socket::connection_close(void)
        {
        int ret = 0;
        ret = close(socket_des);
        if (ret < 0)
            sock_error = qt_error_string( errno ).toStdString();

        return ret;
        }

int     tcp_socket::connection_abort(void)
        {
        int ret = 0;
        ret = shutdown(socket_des,2);
        if (ret < 0)
            sock_error = qt_error_string( errno ).toStdString();

        return ret;
        }
#endif



#ifdef Q_OS_WINDOWS

#include <WinSock2.h>
#include <WS2tcpip.h>

//#pragma comment(lib, "Ws2_32.lib")



tcp_socket::tcp_socket()
        {
        addr.sin_family = AF_INET;
        stat_reset();

        if (FAILED (WSAStartup (MAKEWORD( 1, 1 ), &wsadata) ) )
            {
            sock_error = qt_error_string( WSAGetLastError() ).toStdString();
            }
        }

int tcp_socket::create_socket(void)
        {
        int ret = 0;


        if (INVALID_SOCKET == (socket_des = socket (AF_INET, SOCK_STREAM, 0) ) )
          {
           sock_error = qt_error_string( WSAGetLastError() ).toStdString();
           ret = -1;
          }

        return ret;
        }

int tcp_socket::connect_to_server(std::string arg_ip, int arg_port)
        {
        int ret = 0;

        m_ipaddres  = arg_ip;
        m_port      = arg_port;
        ZeroMemory (&addr, sizeof (addr));
        addr.sin_family = AF_INET;

        addr.sin_addr.S_un.S_addr = inet_addr(m_ipaddres.c_str()); //адрес сервера. Т.к. TCP/IP представляет адреса в числовом виде, то для перевода адреса используем функцию inet_addr.
        addr.sin_port = htons (m_port); // Порт. Используем функцию htons для перевода номера порта из обычного в //TCP/IP представление.


        if (SOCKET_ERROR == ( connect (socket_des, (sockaddr *) &addr, sizeof (addr) ) ) )
              {
              ret = -1;
              sock_error = qt_error_string( WSAGetLastError() ).toStdString();
              }
         return ret;
         }

int     tcp_socket::buffer_send(char *arg_buffer,int arg_max_size)
        {
        int size = 0;
        size = send(socket_des, (const char* )arg_buffer, arg_max_size, 0 );
        if (size < 0 )
            {
            sock_error = qt_error_string( WSAGetLastError() ).toStdString();
            }
        else m_num_send_bytes += size;
        return size;
        }

int     tcp_socket::buffer_read(char *arg_buffer,int arg_max_size)
        {
        int size = recv(socket_des, arg_buffer, arg_max_size, 0);
        if (size > 0)
            m_num_recv_bytes += size;
        else
            sock_error = qt_error_string( WSAGetLastError() ).toStdString();
        return size;
        }

int    tcp_socket::connection_close(void)
        {
        int ret = 0;
        ret = closesocket(socket_des);
        if ( ret < 0)
            sock_error = qt_error_string( WSAGetLastError() ).toStdString();

        return ret;
        }

int     tcp_socket::connection_abort(void)
        {
        int ret = 0;
        ret = shutdown(socket_des,2);
        if (ret < 0)
            sock_error = qt_error_string( WSAGetLastError() ).toStdString();

        return ret;
        }
#endif

void    tcp_socket::stat_reset()
        {
        m_num_send_bytes = 0;
        m_num_recv_bytes = 0;
        }
