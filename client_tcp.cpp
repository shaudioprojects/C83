#include "client_tcp.h"
#include "logging.h"

//#define LL_DEBUG 1


client_tcp::client_tcp()
    {
    m_flag_no_connect_mode = true;
    m_state         = client_states::CS_DISCONECTED;
    m_ipaddres      = "192.168.0.105";
    m_port          = 1983;
    m_flag_thr_on   = true;
    m_decoder       = NULL;
    }

//Деструктор
client_tcp::~client_tcp()
    {

    }

//Задать декодер данных
void client_tcp::set_decoder(decoder *arg_dec)
    {
    m_decoder = arg_dec;
    if (arg_dec) start();
    }

//Задать IP адрес
void client_tcp::set_ipaddress(QString arg_ip)
    {
    LOGGING<<"Задать новый адрес: "<<arg_ip;
    m_ipaddres = arg_ip;
    disconnect();      //разрываем старое соединение
    }

//Отослать данные
void client_tcp::send_raw_data(const char *arg_data, qint64 arg_len)
    {
    qint64 size = 0;
    if ( (m_state == client_states::CS_CONNECTED) && m_flag_thr_on )
        {
        size = m_socket.buffer_send((char*) arg_data, arg_len);
        if (arg_len != size)
            {
            LOGGING<<"Не все данные были отправлены ["<<m_socket.get_str_error();
            }
        if (size < 0)
            {
            LOGGING<<"Ошибка отправки данных: "<<m_socket.get_str_error();
            LOGGING<<"Пожалуй переподключимся";
            disconnect();
            }
        }
    return;
    }

//Режим не подключатся
void client_tcp::set_mode_no_connect()
    {
    m_flag_no_connect_mode = true;
    }

//Режим - подключатся автоматически
void client_tcp::set_mode_connect()
  {
  m_flag_no_connect_mode = false;
  }





//Разорвать соединение
void client_tcp::disconnect(void)
    {
    #ifdef LL_DEBUG
    LOGGING<<"Отключение от клиента";
    #endif

    if (0 > m_socket.connection_abort())
        {
        #ifdef LL_DEBUG
        LOGGING<<ANSI_COLOR_RED<<"Ошибка connection_abort: "<<m_socket.get_str_error()<<ANSI_COLOR_RESET;
        #endif
        }

    if (0 > m_socket.connection_close() )
        {
        #ifdef LL_DEBUG
        LOGGING<<ANSI_COLOR_RED<<"Ошибка connection_close: "<<m_socket.get_str_error()<<ANSI_COLOR_RESET;
        #endif
        }
    m_socket.create_socket();
    }

//Разорвать соединение
//void client_tcp::connection_abort()
 //   {
 //   if (m_state != client_states::CS_DISCONECTED)
//        {
//        LOGGING<<"Закрываем сокет (shutdown).";
//        if (0 > m_socket.connection_abort())
//            {
 //           LOGGING<<ANSI_COLOR_RED<<"Ошибка connection_abort: "<<m_socket.get_str_error()<<ANSI_COLOR_RESET;
 //           }
 //       m_socket.create_socket();
//      }
//    }

//Завершить работу
void client_tcp::stop_work()
    {
    LOGGING<<"Подготовка к завершению работы. Останов потока подключений и чтения данных";

    set_mode_no_connect();      //Режим - не соединять
    m_flag_thr_on = false;      //Завершить поток при первом удобном случае

    disconnect();               //Разъеденить



    LOGGING<<"Ожидание завершения потока чтения.";


    if ( !wait(ULONG_MAX) ) { }
    else    {
            LOGGING<<"Поток чтения завершен.";
            }


    }


//Поток подключеия и чтения данных
void client_tcp::run()
    {
    int bytes_read;
    LOGGING<<ANSI_COLOR_GREEN<<"Поток установки подключений и приема данных запущен: "<<QThread::currentThread()<<ANSI_COLOR_RESET;

    m_state = client_states::CS_DISCONECTED;
    if (m_decoder) m_decoder->on_client_change_state(this);

    if (0 > m_socket.create_socket())
        {
        LOGGING<<ANSI_COLOR_RED<<"Ошибка создания сокета: "<<m_socket.get_str_error()<<ANSI_COLOR_RESET;
        return;
        }

    if (m_flag_no_connect_mode)
        {
        LOGGING<<ANSI_COLOR_YELLOW<<"Соединение отсутствует. Режим ожидания"<<ANSI_COLOR_RESET;
        }

    while ( m_flag_thr_on )
          {
          if (m_flag_no_connect_mode)
             {
             usleep(100000);
             if (!m_flag_no_connect_mode)
                {
                disconnect(); //Закроем старый сокет создадим новый
                }
             continue;
             }

          m_state = client_states::CS_CONNECTINGS;
          m_socket.stat_reset();
          LOGGING<<ANSI_COLOR_YELLOW<<"Сокет начал устанавливать соединение c "<<m_ipaddres<<":"<<m_port<<ANSI_COLOR_RESET;
          if (m_decoder) m_decoder->on_client_change_state(this);
          usleep(500000);  //0.5 сек

          //установка соединения с сервером
          if ( m_socket.connect_to_server(m_ipaddres.toStdString().c_str(), m_port) < 0)
              {
              //Соединение НЕ установлено
              m_state = client_states::CS_DISCONECTED;
              LOGGING<<ANSI_COLOR_RED<<"Ошибка подключения к "<< m_socket.m_ipaddres.c_str() <<": "<< m_socket.get_str_error() << ANSI_COLOR_RESET;
              if (m_decoder) m_decoder->on_client_change_state(this); //Уведомление что состояние изменилось
              //Ждем пока сообщение об ошибке наблюдает пользователь 2s
              if (!m_flag_thr_on) break;
              usleep(500000);
              if (!m_flag_thr_on) break;
              usleep(500000);
              if (!m_flag_thr_on) break;
              usleep(500000);
              if (!m_flag_thr_on) break;
              usleep(500000);
              continue;
              }
          else
              {
                //Соединение установлено
                m_state = client_states::CS_CONNECTED;
                if (m_decoder) m_decoder->on_client_change_state(this);
                LOGGING<<ANSI_COLOR_GREEN<<"Соединение установлено c "<<m_ipaddres << "порт: "<<m_port<<ANSI_COLOR_RESET;
                //Цикл чтения данных
                while (m_state == client_states::CS_CONNECTED && m_flag_thr_on)
                        {
                        bytes_read = m_socket.buffer_read(buffer_for_read, BUF_SIZE);
                        if (bytes_read > 0)
                           {
                           //Используем данные
                           if (m_decoder)  m_decoder->parse(buffer_for_read, bytes_read); //Собираем кусочками команду
                           }
                        else
                           {
                           LOGGING<<ANSI_COLOR_RED<<"Ошибка приема данных: "<<m_socket.get_str_error()<<ANSI_COLOR_RESET <<" ret: "<<bytes_read;
                           m_socket.connection_close();
                           m_socket.create_socket();
                           m_state = client_states::CS_DISCONECTED;
                           if (m_decoder) m_decoder->on_client_change_state(this);
                           usleep(50000);
                           break;
                           }
                        }//Цикл чтения данных
              }
           }//Цикл попытки подключения
    LOGGING<<ANSI_COLOR_GREEN<<"Поток приема данных завершен"<<ANSI_COLOR_RESET;
    }


