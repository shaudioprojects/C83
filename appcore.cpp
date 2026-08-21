#include <string.h>
#include <QString>
#include <QDebug>
#include <QTime>
#include <QElapsedTimer>
#include <QSettings>

#include "appcore.h"
#include "commands.h"
#include "logging.h"

const char TAG_EMPTY_ARG[] = "-";
#define ROUND(x,y) (float)((int)((x + 5/(float)(y*10)) * y))/y
#define TEST_RCV 0


appcore::appcore()
    {
    client.set_decoder((decoder*)this);
    cmd_parts = "";

    ip_pop[0].init();
    ip_pop[1].init();
    ip_pop[2].init();

    m_temp_file_list        = NULL;
    m_temp_adev_list        = NULL;
    m_temp_alsa_vregch_list = NULL;
    m_temp_sw_list          = NULL;

    client_tcp::connect(this,   &appcore::sig_new_file_list,    this,  &appcore::slot_new_file_list     );
    client_tcp::connect(this,   &appcore::sig_new_vregch_list,  this,  &appcore::slot_new_vregch_list   );
    client_tcp::connect(this,   &appcore::sig_new_sw_list,      this,  &appcore::slot_new_sw_list       );
    client_tcp::connect(this,   &appcore::sig_new_aout_list,    this,  &appcore::slot_new_aout_list     );
    }

appcore::~appcore()
  {

  }
void    replace_symbol(char *arg_src,char arg_del,char arg_new)
    {
    char* tmp_char;
    do
        {
        tmp_char = strrchr(arg_src,arg_del); //ищем последнее вхождение слеш
        if (tmp_char) *tmp_char = arg_new; //Заменяем символ
        }
    while(tmp_char);

    }
/*
//Переопределение функции декодера parse.  Сбор строки текста с коммандой
void appcore::parse(char * arg_buf,int arg_size)
    {
    ulong  i = 0;
    ulong  size = 0;
    std::string test_parts;

    char *pTestFind = NULL;
    int         ret;
    std::string tmp_new_cmd;
    char       *arg_pos_end;

    char *p_start = (char*)malloc(arg_size+1);  //Начало данных. некотороя часть комманды или нескольких комманд
    memcpy(p_start,arg_buf,arg_size);           //Копируем принятое
    *(p_start+arg_size) = 0;                    //Закрываем нулем

    if ( strlen(p_start) != (ulong)arg_size )
    LOGGING_RED<<"!!!!! В принятом блоке данных есть незапланированные нули";

    cmd_parts += p_start; //Все что пришло добовляем к строке для разбора

    arg_pos_end = strchr((char*)cmd_parts.c_str(),TAG_CMD_END);  //ищем конец комманды
    while(arg_pos_end) //конец комманды - найден
            {
            *arg_pos_end = TAG_STR_END; //закрываем комманду нулем. Меняем \n на \0

            ret = command_parse( (char*)cmd_parts.c_str() ); //Парсим текст комманды
            if (ret)
                {
                if ( 0 > command_execute() )
                  {//Ошибка

                  }
                else
                  {

                  }
                }
            else        LOGGING_RED<<"!!!!!!!!!!!!!!!!!!! Ошибка разбора аргументов комманды в [command_parse] !!!!!!!!!!!!!!!!!!";

            tmp_new_cmd = arg_pos_end + 1; //начало новой комманды
            cmd_parts = tmp_new_cmd;

            arg_pos_end = strchr((char*)cmd_parts.c_str(),TAG_CMD_END); //ищем конец комманды
            };


    free(p_start);
}
*/

//Переопределение функции декодера parse.  Сбор строки текста с коммандой
void appcore::parse(char * arg_buf,int arg_size)
    {
    int ret;
    char *p_start;                        //Начало данных. некотороя часть комманды или нескольких комманд
    p_start = (char*)malloc(arg_size+1);
    memcpy(p_start,arg_buf,arg_size);     //Копируем принятое
    *(p_start+arg_size) = 0;              //Закрываем нулем

    char    *arg_pos_start = p_start;
    char    *arg_pos_end;


    arg_pos_end = strchr(arg_pos_start,TAG_CMD_END);  //ищем конец комманды
    while(arg_pos_end) //конец комманды - найден
            {
            *arg_pos_end = TAG_STR_END; //закрываем комманду нулем. Меняем \n на \0
            cmd_parts += arg_pos_start; //Добовляем найденную часть команды к std::string

            ret = command_parse( (char*)cmd_parts.c_str() ); //Парсим текст комманды

            if (ret)  command_execute();
            else      LOGGING<<ANSI_COLOR_RED<<"Ошибка разбора аргументов комманды в функции [command_parse]"<<ANSI_COLOR_RESET;

            cmd_parts = "";
            arg_pos_start = arg_pos_end + 1; //начало новой комманды

            arg_pos_end = strchr(arg_pos_start,TAG_CMD_END); //ищем конец комманды
            };

    cmd_parts += arg_pos_start;  //Остаток добавляем (запоминаем)

    free(p_start);
}

//Выделение аргументов комманды из строки текста
bool appcore::command_parse(char *arg_cmd_text)
  {
  bool    ret = true;
  char    *arg_pos_start;
  char    *arg_pos_end;
  uint8_t arg_index = 0; //Индекс по массиву аргументов

  cmd_current.cmd_init();

  arg_pos_start = arg_cmd_text;
  arg_pos_end = strchr(arg_pos_start,TAG_ARG_END);
  while(arg_pos_end)  //ищем конец аргумента
          {
          *arg_pos_end = TAG_STR_END; //закрываем строку нулем

          cmd_current.args_txt[arg_index] = arg_pos_start; //Копируем строку в std::string
         // if( arg_index == 0 )
          //    LOGGING<<"Аргумет: "<<cmd_current.args_txt[arg_index].c_str();

          //printf("Аргумет: %s\r\n",cmd.args_txt[arg_index].c_str() );
          *arg_pos_end = TAG_ARG_END;     //Восстанавливаем
          //Работа с аргументом завершена
          arg_pos_start = arg_pos_end + 1; //начало нового аргумента
          arg_index++; //Следующий индекс аргумента если он будет
          if (CMD_ITEMS_MAX == arg_index) break;

          arg_pos_end = strchr(arg_pos_start,TAG_ARG_END);
          };

  if (arg_index == 0)
    ret = false;
  //printf("Комманда + аргуметов: %d\r\n",arg_index);
  return ret;
  }



//Выполнение комманды
int appcore::command_execute(void)
  {
  int return_value = 0;
  long cmd;
  static std::string current_acard = "no";
  //QTime time;


  //static QTime time_start;
  //QTime time_end;

  cmd = ARG_0_AS_INT;
  //свич и рассылка сигналов
  switch (cmd)
    {
    //Начать прием списка
    case CMD_LIST_FILE_NEW_START:   if (m_temp_file_list)
                                        {
                                        delete m_temp_file_list;
                                        LOGGING<<ANSI_COLOR_RED"Предыдущий список не был закрыт коммандой CMD_LIST_FILE_NEW_END"<<ANSI_COLOR_RESET;
                                        }

                                    m_temp_file_list = new QList<Item_list_file>;
                                    //time = QTime::currentTime();
                                    //LOGGING<<"Новый список файлов будет идти."<<time;
                                    break;

    //Пришел новый элемент списка
    case CMD_LIST_FILE_ITEM:    {
                                Item_list_file *tmp = new Item_list_file( ARG_1_AS_PCHAR, //Имя файла
                                                                          ARG_2_AS_PCHAR, //Расширение
                                                                          ARG_3_AS_INT,   //Иконка
                                                                          ARG_4_AS_INT,   //Флаги
                                                                          ARG_5_AS_INT    //цвет
                                                                          );
                                if (tmp)
                                  {
                                    if (m_temp_file_list)
                                        m_temp_file_list->append(*tmp);
                                    delete tmp;
                                  }

                                //m_list_file->list_add_item(0,cmd_current.args_txt[2].c_str(),cmd_current.args_txt[4].c_str(),0xFFFFFF);
                                //LOGGING(cmd_current.args_txt[2].c_str()<<" "<<cmd_current.args_txt[4].c_str());
                                break;
                                }

    //Закончен прием списка файлов
    case CMD_LIST_FILE_NEW_END: //LOGGING<<"CMD_LIST_FILE_NEW_END -< "<<QThread::currentThread();
                                if (m_temp_file_list)
                                    {
                                    //LOGGING<<"!! Отправим сечас сигналом - "<< m_temp_file_list->count() ;
                                    emit sig_new_file_list(m_temp_file_list,ARG_1_AS_LONG);
                                    m_temp_file_list = NULL;
                                    }
                                break;
    //Позиция курсора
    case CMD_CURSOR_POS:      emit sig_set_index_0(ARG_1_AS_LONG);
                              //LOGGING<<"Позиция курсора: "<<atol(cmd_current.args_txt[1].c_str());
                              break;


    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case CMD_LIST_ADEV_NEW_START:       {
                                        //LOGGING<<"Список аудиовыходов будет идти ";
                                        if (m_temp_adev_list) delete m_temp_adev_list; //Удаляем временный если он есть
                                        m_temp_adev_list = new QList<Item_list_adev>; //Создаем новый
                                        //Первый элемент в списке default
                                        Item_list_adev *tmp = new Item_list_adev( "default","default","Default Audio Device",false);
                                        if (tmp)
                                          {
                                            if (m_temp_adev_list) m_temp_adev_list->append(*tmp);
                                            delete tmp;
                                          }


                                        current_acard = "no";
                                        break;
                                        }

    case CMD_LIST_ADEV_ITEM:            {
                                        Item_list_adev *tmp;
                                        if (current_acard != ARG_1_AS_PCHAR) //если пришел аудиовыход из другой карты
                                            {//добавим разделитель - аудиокарта
                                            //LOGGING<<"Аудиокарта: "<<ARG_1_AS_PCHAR;
                                            tmp = new Item_list_adev(ARG_1_AS_PCHAR,ARG_2_AS_PCHAR,ARG_3_AS_PCHAR,true);
                                            if (tmp)
                                                {
                                                if (m_temp_adev_list) m_temp_adev_list->append(*tmp);
                                                delete tmp;
                                                }
                                            current_acard = ARG_1_AS_PCHAR;
                                            }
                                        //теперь добавим сам аудовыход
                                        //LOGGING<<"    Аудиовыход: ("<<ARG_1_AS_PCHAR<<") "<<ARG_2_AS_PCHAR;
                                        tmp = new Item_list_adev(ARG_1_AS_PCHAR,ARG_2_AS_PCHAR,ARG_3_AS_PCHAR,false);
                                        if (tmp)
                                          {
                                            if (m_temp_adev_list) m_temp_adev_list->append(*tmp);
                                            delete tmp;
                                          }

                                        break;
                                        }

    case CMD_LIST_ADEV_NEW_END:       if (m_temp_adev_list)
                                          {
                                          emit sig_new_aout_list(m_temp_adev_list); //Применить новый список
                                          m_temp_adev_list = NULL;
                                          }
                                      current_acard = "no";
                                      break;

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case CMD_LIST_ALSA_CHVREG_NEW_START:{
                                        //LOGGING<<"Список каналов ALSA будет идти ";
                                        if (m_temp_alsa_vregch_list) delete m_temp_alsa_vregch_list; //Удаляем временный если он есть
                                        m_temp_alsa_vregch_list = new QList<Item_list_alsa_vregch>;  //Создаем новый
                                        break;
                                        }

    case CMD_LIST_ALSA_CHVREG_ITEM:     {
                                        Item_list_alsa_vregch *tmp = new Item_list_alsa_vregch(ARG_1_AS_PCHAR);
                                        if (tmp)
                                            {
                                            if (m_temp_alsa_vregch_list)  m_temp_alsa_vregch_list->append(*tmp);
                                            delete tmp;
                                            }
                                        break;
                                        }

    case CMD_LIST_ALSA_CHVREG_NEW_END:    //LOGGING<<"Закончен прием списка каналов ASLA";
                                        if (m_temp_alsa_vregch_list)
                                           {
                                           emit sig_new_vregch_list(m_temp_alsa_vregch_list,ARG_1_AS_LONG);
                                           m_temp_alsa_vregch_list = NULL;
                                           }
                                        break;
    case CMD_VOL_REG_ALSA_CH:           emit sig_select_alsa_ch(ARG_1_AS_LONG); break;


    /////////////////////////////////////////////////// SW //////////////////////////////////////////////////////////
    case CMD_LIST_SW_NEW_START:
      {
      LOGGING<<"Список каналов SW будет идти ";
      if (m_temp_sw_list) delete m_temp_sw_list;          //Удаляем временный если он есть
      m_temp_sw_list = new QList<Item_list_alsa_vregch>;  //Создаем новый
      break;
      }

    case CMD_LIST_SW_ITEM:
      {
      Item_list_alsa_vregch *tmp = new Item_list_alsa_vregch(ARG_1_AS_PCHAR);
      if (tmp)
          {
          if (m_temp_sw_list)  m_temp_sw_list->append(*tmp);
          delete tmp;
          }
      break;
      }

    case CMD_LIST_SW_NEW_END:    //LOGGING<<"Закончен прием списка SW";
      if (m_temp_sw_list)
         {
         emit sig_new_sw_list(m_temp_sw_list,0);
         m_temp_sw_list = NULL;
         }
      break;

    case CMD_SW_ID: emit sig_sw(ARG_1_AS_LONG,ARG_2_AS_PCHAR,ARG_3_AS_LONG,ARG_4_AS_PCHAR); break;

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    case CMD_AOUT_SELECT:               emit sig_select_aout(ARG_1_AS_PCHAR);       break;
    case CMD_AOUT_FREQ_AVALIABLE:       emit sig_aout_freq_avaliable(ARG_1_AS_INT,(bool)ARG_2_AS_INT);  break;
    case CMD_AOUT_FMT_AVALIABLE:        emit sig_aout_fmt_avaliable(ARG_1_AS_PCHAR,(bool)ARG_2_AS_INT); break;

    case CMD_AOUT_FREQ_CURRENT:         emit sig_aout_freq_current(ARG_1_AS_INT);   break;
    case CMD_AOUT_FMT_CURRENT:          emit sig_aout_fmt_current(ARG_1_AS_PCHAR);  break;
    case CMD_AOUT_CH_COUNT:             emit sig_aout_ch_count(ARG_1_AS_INT,ARG_2_AS_INT,ARG_3_AS_INT);      break;
    case CMD_AOUT_BITRATE_CURRENT:      emit sig_aout_bitrate(ARG_1_AS_LONG);       break;
    case CMD_AOUT_CODEC_CURRENT:        emit sig_aout_codec(ARG_1_AS_PCHAR);        break;
    case CMD_AOUT_OPTS:                 emit sig_opt_alsa(ARG_1_AS_INT,ARG_2_AS_INT,ARG_2_AS_INT);   break;
    case CMD_AOUT_INFO:                 emit sig_aout_info(ARG_1_AS_PCHAR);     break;

    case CMD_DEC_FREQ:                  emit sig_dec_freq_current(ARG_1_AS_INT);    break;
    case CMD_DEC_FMT:                   emit sig_dec_fmt_current(ARG_1_AS_PCHAR);   break;
    case CMD_DEC_CH_COUNT:              emit sig_dec_ch_count(ARG_1_AS_INT);        break;
    case CMD_DEC_BITRATE:               emit sig_dec_bitrate(ARG_1_AS_INT);         break;
    case CMD_DEC_CODEC:                 emit sig_dec_codec(ARG_1_AS_PCHAR);         break;
    case CMD_DEC_SIMD:                  emit sig_dec_simd(ARG_1_AS_PCHAR);          break;

    case CMD_TIME_CURRENT:              emit sig_time_current(ARG_1_AS_LONG);       break;
    case CMD_TIME_MAX:                  emit sig_time_duration(ARG_1_AS_LONG);      break;

    case CMD_BK_LIST_VISIBLE:           emit sig_bk_list(ARG_1_AS_INT);             break;

    case CMD_OPT_REPEATE:               emit sig_repeate(ARG_1_AS_INT);             break;
    case CMD_OPT_RANDOM:                emit sig_random(ARG_1_AS_INT);              break;

    case CMD_OPT_RESTORE_VOLUME:        emit sig_restore_volume(ARG_1_AS_INT);                  break;
    case CMD_OPT_RESTORE_PLAY_FILE:     emit sig_restore_play_file(ARG_1_AS_INT);               break;
    case CMD_OPT_RESTORE_POS_IN_FILE:   emit sig_restore_position_in_play_file(ARG_1_AS_INT);   break;

    case CMD_VOLUME:                    emit sig_volume(ARG_1_AS_INT);          break;
    case CMD_VOLUME_DB:                 emit sig_volume_db(ARG_1_AS_FLOAT);       break;
    case CMD_VOL_REG_STEP_DB:           emit sig_vol_step_db(ARG_1_AS_FLOAT);       break;

    case CMD_BALANCE_DB:                emit sig_balance_db(ARG_1_AS_FLOAT);      break;
    case CMD_BALANCE_MAX_DB:            emit sig_balance_max_db(ARG_1_AS_FLOAT);  break;
    case CMD_BALANCE:                   emit sig_balance(ARG_1_AS_INT,ARG_2_AS_INT);         break;

    case CMD_ADM_VOL_DB:                emit sig_adm_vol_db(ARG_1_AS_FLOAT,ARG_2_AS_FLOAT);         break;
    case CMD_ADM_VOL_LIMIT_DB:          emit sig_adm_vol_limit_db(ARG_1_AS_FLOAT,ARG_2_AS_FLOAT);   break;
    case CMD_VOL_REG_ID:                emit sig_vreg_id(ARG_1_AS_INT,ARG_2_AS_PCHAR);              break;

    case CMD_MESSAGE_BOX:               emit sig_message_box(ARG_1_AS_PCHAR,ARG_2_AS_PCHAR,ARG_5_AS_INT);        break;

    case CMD_CONTEXT_MENU:              LOGGING<<"Контекстное меню: "<<ARG_1_AS_LONG<<" для файла: "<<ARG_2_AS_PCHAR;
                                        emit sig_context_menu(ARG_1_AS_LONG,ARG_2_AS_PCHAR);        break;

    case CMD_CLOSE_CTX_MENU:            LOGGING<<"Закрыть контекстное меню.";
                                        emit sig_ctx_close();
                                        break;

    case CMD_CONVERTER_STATE:           emit sig_convert_state ( (bool)ARG_1_AS_INT, (bool)ARG_2_AS_INT, (bool)ARG_3_AS_INT, (bool)ARG_4_AS_INT);
                                        break;

    case CMD_ABOUT:                     emit sig_about(ARG_1_AS_PCHAR, ARG_2_AS_PCHAR, ARG_3_AS_PCHAR, ARG_4_AS_PCHAR, ARG_5_AS_PCHAR); break;
    case CMD_CHANGE_FREQ:               emit sig_change_freq(ARG_1_AS_LONG);    break;
    case CMD_CHANGE_FMT:                emit sig_change_fmt(ARG_1_AS_LONG);     break;

    case CMD_EQ:                        emit sig_eq_state(ARG_1_AS_INT,(bool)ARG_2_AS_INT);         break;
    case CMD_EQ_BAND:                   emit sig_eq_band(ARG_1_AS_INT,ARG_2_AS_INT,ARG_3_AS_INT);   break;
    case CMD_EQ_FLAG_PLAYER:            emit sig_eq_flag_player((bool)ARG_1_AS_LONG);               break;

    case CMD_DISP_INFO:                 emit sig_disp_id(ARG_1_AS_INT,ARG_2_AS_PCHAR,ARG_3_AS_PCHAR);  break;
    case CMD_DISP_BRIG:                 emit sig_brig_lcd(ARG_1_AS_INT,ARG_2_AS_INT);                break;

    case CMD_VIND_ID:                   emit sig_vind_id(ARG_1_AS_INT,ARG_2_AS_PCHAR);  break;
    case CMD_BRIG_LEDS:                 emit sig_brig_ind_vreg(ARG_1_AS_INT);           break;
    case CMD_KB_ID:                     emit sig_kb_id(ARG_1_AS_INT,ARG_2_AS_PCHAR);    break;

    case CMD_MARK:                      emit sig_mark(ARG_1_AS_LONG,ARG_2_AS_INT);      break;
    case CMD_COLOR_FILES:               {
                                        uint tmp_color = ARG_2_AS_LONG;
                                        float tmp_r = tmp_color >> 16 ;
                                        float tmp_g = (tmp_color & 0xFFFF) >> 8;
                                        float tmp_b = (tmp_color & 0xFF);
                                        emit sig_color_file(ARG_1_AS_INT, tmp_r/255, tmp_g/255, tmp_b/255 );
                                        }
                                        break;
    case CMD_DISP_COLOR:                {
                                        uint tmp_color = ARG_2_AS_LONG;
                                        float tmp_r = tmp_color >> 16 ;
                                        float tmp_g = (tmp_color & 0xFFFF) >> 8;
                                        float tmp_b = (tmp_color & 0xFF);
                                        emit sig_color_disp_parametr(ARG_1_AS_INT, tmp_r/255, tmp_g/255, tmp_b/255 );
                                        }
                                        break;
    case CMD_DISP_CLTH:                 emit sig_set_th(ARG_1_AS_INT);  break;
    case CMD_DISP_LANG:                 emit sig_set_lng(ARG_1_AS_INT,ARG_2_AS_INT); break;
    case CMD_INFO_MS:                   emit sig_client_count(ARG_1_AS_INT);    break;
    case CMD_OPT_NEATLY_VOL:            emit sig_neatly_vol(ARG_1_AS_INT);      break;
    case CMD_BD_ID:                     emit sig_bd_id(ARG_1_AS_INT,ARG_2_AS_PCHAR,ARG_3_AS_PCHAR,ARG_4_AS_INT);
                                        break;
    case CMD_BD_DATA:                   emit sig_bd_data(ARG_1_AS_INT,0,ARG_3_AS_INT,ARG_4_AS_INT,ARG_5_AS_INT);
                                        //LOGGING<<ANSI_COLOR_GREEN<<"DAC module: "<<ARG_2_AS_PCHAR<<" f"<<ARG_3_AS_INT<<ANSI_COLOR_RESET;
                                        break;
    case CMD_INFO_SPACE:                emit sig_hdd_info(ARG_1_AS_PCHAR,ARG_2_AS_PCHAR);
                                        break;
    case CMD_INFO_2:                    assign_node_name(ARG_1_AS_PCHAR); //Назначить имя для текущего IP
                                        break;
    case CMD_AC83_UPDATE:               emit sig_update(ARG_1_AS_INT);
                                        break;
    default:                            //LOGGING<<ANSI_COLOR_RED<<"Неизвестный номер комманды №"<<cmd<<ANSI_COLOR_RESET;
                                        return_value = -1;
    }
  return return_value;
}

void appcore::assign_node_name(QString arg_name)
    {
    QString current_ip = client.get_ipaddress();
    if (client.get_client_state() == client_states::CS_CONNECTED)
        {
        if (ip_pop[0].ip_string == current_ip)
            ip_pop[0].ip_node_name = arg_name;

        if (ip_pop[1].ip_string == current_ip)
            ip_pop[1].ip_node_name = arg_name;

        if (ip_pop[2].ip_string == current_ip)
            ip_pop[2].ip_node_name = arg_name;
        }
    apply_pop_ip(); //На экран
    }

void appcore::command_send_to_server(int arg_cmd, QString arg_qstr)
      {
      QString tmp_str;
      tmp_str = QString::number(arg_cmd);
      tmp_str += (char)TAG_ARG_END;
      tmp_str += arg_qstr;
      tmp_str += (char)TAG_ARG_END;
      tmp_str += (char)TAG_CMD_END;
      send_string((char*)tmp_str.toStdString().c_str());
      }

void appcore::command_send_to_server(cmd_format_t *arg_cmd)
    {
    int i;
    QString tmp_str;

    tmp_str = arg_cmd->args_txt[0].c_str();
    tmp_str += (char)TAG_ARG_END;

    for(i=1;i<CMD_ITEMS_MAX;i++)
        {
        if (arg_cmd->args_txt[i] != "")
            {
            tmp_str += arg_cmd->args_txt[i].c_str();
            tmp_str += (char)TAG_ARG_END;
            }
        }
    tmp_str += (char)TAG_CMD_END;
    send_string((char*)tmp_str.toStdString().c_str());
    }

//Задать список с файлами
void appcore::set_list(List_file_Model *arg_list)       { m_list_file = arg_list; }
//Задать список аудиоустройств
void appcore::set_list_aout(List_adev_model *arg_list)  { m_list_aout = arg_list; }

void appcore::set_list_alsa_vregch  (List_alsa_vregch_model *arg_list)  {m_list_alsa_vregch = arg_list; }
void appcore::set_list_sw           (List_alsa_vregch_model *arg_list)  {m_list_sw = arg_list; }

//Начало работы
void appcore::start_work(void)
  {
  //Прочитаем тут настройки программы
  read_settings_from_file();
  client.set_ipaddress(ip_from_file);

  emit sig_ipaddress( client.get_ipaddress() );
  emit sig_build_date(__DATE__);

  //Начать подключатся
  client.set_mode_connect();
  }

//Завершение работы
void appcore::stop_work(void)
    {
    client.stop_work();
    write_settings_to_file();
    }

void appcore::read_settings_from_file()
    {
    QSettings settings( "c83_settings.conf", QSettings::IniFormat );
    settings.beginGroup( "IP_address" );

    ip_from_file = settings.value( "IP", "192.168.0.84" ).toString();

    ip_pop[0].ip_string     = settings.value( "IP_POP_1", "192.168.0.83" ).toString();
    ip_pop[1].ip_string     = settings.value( "IP_POP_2", "-" ).toString();
    ip_pop[2].ip_string     = settings.value( "IP_POP_3", "-" ).toString();

    ip_pop[0].connect_time  = settings.value( "IP_POP_1_TIME", "0" ).toLongLong();
    ip_pop[1].connect_time  = settings.value( "IP_POP_2_TIME", "0" ).toLongLong();
    ip_pop[2].connect_time  = settings.value( "IP_POP_3_TIME", "0" ).toLongLong();

    ip_pop[0].ip_node_name  = settings.value( "IP_NNAME_1", " " ).toString();
    ip_pop[1].ip_node_name  = settings.value( "IP_NNAME_2", " " ).toString();
    ip_pop[2].ip_node_name  = settings.value( "IP_NNAME_3", " " ).toString();

    current_th  = settings.value( "C83_TH", "0" ).toInt();
    emit sig_set_th(current_th);//Тема
    apply_pop_ip(); //На экран

    if(ip_from_file.size() != 0)
         LOGGING<<"Целевой адрес сервера: "<<ip_from_file;
    settings.endGroup();
    }

void appcore::write_settings_to_file()
    {
    LOGGING<<"Запись настроек в файл [c83_settings.conf]";
    QSettings settings( "c83_settings.conf", QSettings::IniFormat );

    settings.beginGroup( "IP_address" );
        settings.setValue( "IP", client.get_ipaddress() );
        settings.setValue( "IP_POP_1",      ip_pop[0].ip_string );
        settings.setValue( "IP_POP_2",      ip_pop[1].ip_string );
        settings.setValue( "IP_POP_3",      ip_pop[2].ip_string );
        settings.setValue( "IP_POP_1_TIME", ip_pop[0].connect_time );
        settings.setValue( "IP_POP_2_TIME", ip_pop[1].connect_time );
        settings.setValue( "IP_POP_3_TIME", ip_pop[2].connect_time );
        settings.setValue( "IP_NNAME_1", ip_pop[0].ip_node_name );
        settings.setValue( "IP_NNAME_2", ip_pop[1].ip_node_name );
        settings.setValue( "IP_NNAME_3", ip_pop[2].ip_node_name );
        settings.setValue( "C83_TH", current_th );

    settings.endGroup();
    }

//Открыть альбом
void appcore::slot_open_album(void)
    {
    command_send_to_server((int)CMD_MAIN::CMD_OPEN_ONLY, "1" );
    }

//Открыть артиста
void appcore::slot_open_artist(void)
    {
        command_send_to_server((int)CMD_MAIN::CMD_OPEN_ONLY, "2" );
    }
//Открыть
void appcore::slot_open(void)
    {
    command_send_to_server((int)CMD_MAIN::CMD_OPEN_ONLY, TAG_EMPTY_ARG );
    }
//Открыть с подпапками
void appcore::slot_open_all()
    {
    command_send_to_server((int)CMD_MAIN::CMD_OPEN_ALL, TAG_EMPTY_ARG );
    }
//Открыть фоновый список
void appcore::slot_open_bk_list()
    {
    command_send_to_server((int)CMD_MAIN::CMD_OPEN_BK_LIST, TAG_EMPTY_ARG );
    }
//Следующий трек
void appcore::slot_next()
    {
    command_send_to_server((int)CMD_MAIN::CMD_NEXT,TAG_EMPTY_ARG);
    }
//Повтор списка воспроизведениея
void appcore::slot_repeate(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_REPEATE,QString::number((int)arg_value));
    }
//Случайный порядок
void appcore::slot_random(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_RANDOM,QString::number((int)arg_value));
    }

void appcore::slot_neatly_vol(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_NEATLY_VOL,QString::number((int)arg_value));
    }
//Поставить на паузу снять с паузы
void appcore::slot_pause_resume()
    {
    command_send_to_server((int)CMD_MAIN::CMD_PAUSE_RESUME,TAG_EMPTY_ARG);
    }

void appcore::slot_pause()
    {
    command_send_to_server((int)CMD_MAIN::CMD_PAUSE,TAG_EMPTY_ARG);
    }

void appcore::slot_pre()
    {
    command_send_to_server((int)CMD_MAIN::CMD_PREVIOUS,TAG_EMPTY_ARG);
    }

void appcore::slot_stop()
    {
    command_send_to_server((int)CMD_MAIN::CMD_STOP,TAG_EMPTY_ARG);
    }

void appcore::slot_cursor_up()
    {
    command_send_to_server((int)CMD_MAIN::CMD_CURSOR_UP,TAG_EMPTY_ARG);
    }

void appcore::slot_cursor_down()
    {
    command_send_to_server((int)CMD_MAIN::CMD_CURSOR_DOWN,TAG_EMPTY_ARG);
    }

void appcore::slot_click_on_item(unsigned int arg_cursor_pos)
    {
    command_send_to_server((int)CMD_MAIN::CMD_CURSOR_POS,QString::number(arg_cursor_pos) );
    }

//Приостановить работу программы
void appcore::slot_set_mode_pause()
  {
  //LOGGING<<QSysInfo::currentCpuArchitecture();
  if (QSysInfo::productType() != "windows")
    {
      client.set_mode_no_connect(); //Не подключатся
      //client.connection_abort();    //Разорвать подключение
      client.disconnect();
    }


  }

//Продолжить работу
void appcore::slot_set_mode_play()
  {
  if (QSysInfo::productType() != "windows")
    {
    client.set_mode_connect();  // Доем добро на установку связи
    //client.disconnect();        // Пересоздать сокет
    }
  }

//Громкость
void appcore::slot_send_volume(float arg_perc)
    {
    //LOGGING<<"Установка громкости: "<< QString::number(ROUND(arg_perc,1))<< "raw: "<<arg_perc;
    command_send_to_server((int)CMD_VOLUME, QString::number(ROUND(arg_perc,10)) );
    }

//Баланс
void appcore::slot_balance(float arg_value)
    {
    command_send_to_server((int)CMD_BALANCE, QString::number( ROUND(arg_value,10) ) );
    }

//Пределы громкости
void appcore::slot_admin_volume(float arg_min_value, float arg_max_value)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_ADM_VOL_DB);
    cmd.args_txt[1] = std::to_string(arg_min_value);
    cmd.args_txt[2] = std::to_string(arg_max_value);
    command_send_to_server(&cmd);
    }

///////////////////////////////////////////////
int appcore::slot_get_tcp_thr_read_state()
    {
    return 0;//client.get_test_state();
    }

long appcore::slot_get_rcv_bytes()
    {
    return client.get_rcv_bytes();
    }

long appcore::slot_get_send_bytes()
    {
     return client.get_send_bytes();
    }
//Восстановить громкость
void appcore::slot_restore_volume(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_RESTORE_VOLUME,QString::number((int)arg_value));
    }
//Восстановить воспроизведение файла
void appcore::slot_restore_play_file(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_RESTORE_PLAY_FILE,QString::number((int)arg_value));
    }
//Восстановить позицию в файле
void appcore::slot_restore_pos_in_play_file(bool arg_value)
    {
    command_send_to_server((int)CMD_OPT_RESTORE_POS_IN_FILE,QString::number((int)arg_value));
    }

void appcore::send_string(char *arg_str)
    {
    client.send_raw_data(arg_str,strlen(arg_str));
    }

void appcore::apply_pop_ip (void)
    {
    emit sig_pop_ip(ip_pop[0].ip_string, 0, ip_pop[0].ip_state, ip_pop[0].ip_node_name);
    emit sig_pop_ip(ip_pop[1].ip_string, 1, ip_pop[1].ip_state, ip_pop[1].ip_node_name);
    emit sig_pop_ip(ip_pop[2].ip_string, 2, ip_pop[2].ip_state, ip_pop[2].ip_node_name);
    }

void appcore::event_connected (QString arg_ip)
    {
    int i;
    emit sig_status_label(QString("Соединен c ") + arg_ip,QColorConstants::Green);
    emit sig_connected(arg_ip);
    command_send_to_server((int)CMD_MAIN::CMD_GET_STATE,TAG_EMPTY_ARG);             //Запросить все данные

    currentDateTime = QDateTime::currentDateTime();


    for(i=0;i<3;i++)
        {
        ip_pop[i].ip_state = false;
        }

    //Поиск - может есть в списке
    for(i=0;i<3;i++)
        {
        if ( ip_pop[i].ip_string == arg_ip) //Уже есть в списке
            {
            ip_pop[i].ip_state      = true;
            ip_pop[i].connect_time  = currentDateTime.toSecsSinceEpoch(); //Обновляем время
            ip_pop[i].ip_node_name  = " ";
            apply_pop_ip();
            return;
            }
        }
    //Поиск свободной ячейки
    for(i=0;i<3;i++)
        {
        if ( ip_pop[i].ip_string == "-")    //Свободная ячейка
            {
            ip_pop[i].ip_string     = arg_ip;
            ip_pop[i].ip_state      = true;
            ip_pop[i].ip_node_name  = " ";
            ip_pop[i].connect_time  = currentDateTime.toSecsSinceEpoch(); //Обновляем время
            apply_pop_ip();
            return;
            }
        }

    //Все заняты - заменяем на самую старую
    int i_target=0;
    if ( ip_pop[0].connect_time > ip_pop[1].connect_time )
        {
        i_target = 1;
        }

    if ( ip_pop[i_target].connect_time > ip_pop[2].connect_time )
        {
        i_target = 2;
        }

    ip_pop[i_target].ip_string     = arg_ip;
    ip_pop[i_target].ip_state      = true;
    ip_pop[i_target].ip_node_name  = " ";
    ip_pop[i_target].connect_time  = currentDateTime.toSecsSinceEpoch(); //Обновляем время
    apply_pop_ip();
    }

//Событие - tcp сокет изменил состояние
//Эта функция вызывается из другого потока
void appcore::on_client_change_state(void *arg_state)
  {
  client_tcp* tcp_client = (client_tcp*)arg_state;
  QString current_ip = tcp_client->get_ipaddress();
  switch (tcp_client->get_client_state())
    {
    case client_states::CS_CONNECTED:   event_connected (current_ip);
                                        break;
    case client_states::CS_CONNECTINGS: emit sig_status_label(QString("Соединение c ") + tcp_client->get_ipaddress(),QColorConstants::Yellow);
                                        emit sig_disconnected();
                                        emit sig_connecting_start(current_ip);
                                        break;
    case client_states::CS_DISCONECTED: event_disconected(); break;
    }

  }

void appcore::event_disconected(void)
    {
    if (m_temp_file_list)  m_temp_file_list->clear();
    m_list_file->clear_list(); //Очистить список файлов
    reset_parser();
    emit sig_status_label("Соединение не установлено!",QColorConstants::Red);
    emit sig_disconnected();

    int i;
    for(i=0;i<3;i++)
        {
        ip_pop[i].ip_state = false;
        }
    apply_pop_ip();
    }

void appcore::reset_parser(void)
    {
    cmd_parts.clear();
    }

void appcore::slot_start(void)
    {
    start_work();     //Начинаем
    }

//Был изменен адрес
void appcore::slot_ip_address_change(QString arg_ip)
    {
    client.set_ipaddress(arg_ip);   //Задаем новый адрес
    write_settings_to_file();
    }

//Позицианирование
void appcore::slot_seek_sec(long arg_sec)
    {
    command_send_to_server((int)CMD_MAIN::CMD_SEEK_POS, QString::number(arg_sec));
    }

//Завершить работу системы
void appcore::slot_poff(void)
    {
    command_send_to_server((int)CMD_MAIN::CMD_POFF, TAG_EMPTY_ARG);
    }

//Завершение работы только плеера
void appcore::slot_poff_ac(void)
    {
    command_send_to_server((int)CMD_MAIN::CMD_ACOFF, TAG_EMPTY_ARG);
    }
//Добавить завершение работы
void appcore::slot_poff_add()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_ADD_POFF, TAG_EMPTY_ARG);
    }

//Подготовится к выходу из приложения
void appcore::slot_prepare_for_exit(void)
    {
    client.set_mode_no_connect();
    LOGGING<<"Разрываем соединение";
    client.disconnect();
    }
//Разъединить
void appcore::slot_disconnect(void)
    {
    client.disconnect();
    }

void appcore::slot_opt_alsa(bool arg_value1,bool arg_value2,bool arg_value3)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_AOUT::CMD_AOUT_OPTS);
    cmd.args_txt[1] = std::to_string((int)arg_value1);
    cmd.args_txt[2] = std::to_string((int)arg_value2);
    cmd.args_txt[3] = std::to_string((int)arg_value3);
    command_send_to_server(&cmd);
    }

void appcore::slot_update(int arg_mode)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_MAIN::CMD_AC83_UPDATE);
    cmd.args_txt[1] = "upd";
    cmd.args_txt[2] = std::to_string(arg_mode);
    command_send_to_server(&cmd);
    }

void appcore::slot_set_theme (int arg_th)
    {
    current_th = arg_th;
    LOGGING<<"Установить тему: "<<arg_th;
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_DISP_CLTH);
    cmd.args_txt[1] = std::to_string(arg_th);
    command_send_to_server(&cmd);
    }

void appcore::slot_set_gui_lang(int arg_lang)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_DISP_LANG);
    cmd.args_txt[1] = std::to_string(arg_lang);
    command_send_to_server(&cmd);
    }

void appcore::slot_select_sw_item(int index)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_SW::CMD_SW_ID);
    cmd.args_txt[1] = std::to_string((int)index);
    command_send_to_server(&cmd);
    }

void appcore::slot_board_dac(int arg_1, int arg_2,  int arg_3, int arg_4)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_BOARD::CMD_BD_ID);
    cmd.args_txt[1] = std::to_string(arg_1);
    cmd.args_txt[2] = std::to_string(arg_2);
    cmd.args_txt[3] = std::to_string(arg_3);
    cmd.args_txt[4] = std::to_string(arg_4);
    command_send_to_server(&cmd);
    }



//void appcore::slot_test_update_file_list()
//   {
//    LOGGING<<"test - Сброс модели списка файлов";
//    m_list_file->reset_model();
//    }

void appcore::slot_set_start_path()
    {
    command_send_to_server((int)CMD_CP_AS_SP, TAG_EMPTY_ARG );
    }

//Выбрать аудиовыход
void appcore::slot_click_on_acard(QString arg_aout)
    {
    command_send_to_server((int)CMD_AOUT_SELECT, arg_aout );
    }

//Выбрать канал ALSA
void appcore::slot_click_on_alsa_ch(int arg_pos)
    {
    command_send_to_server((int)CMD_VOL_REG_ALSA_CH,  QString::number(arg_pos) );
    }

//Запросит контексное меню
void appcore::slot_context_menu()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_CONTEXT_MENU, TAG_EMPTY_ARG );
    }

//Как целевой
void appcore::slot_as_target()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_ASS_TARGET_PLS, TAG_EMPTY_ARG );
    }

//Добавить в целевой
void appcore::slot_add_to_pls()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_ADD_TO_PLS_TARGET, TAG_EMPTY_ARG );
    }

//Добавить в фоновый
void appcore::slot_add_to_bk_pls()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_ADD_TO_PLS_BK, TAG_EMPTY_ARG );
    }

//Новый плейлист
void appcore::slot_new_pls(QString arg_name)
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_NEW_FOLDER, arg_name );
    }

//Переименовать
void appcore::slot_rename(QString arg_name)
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_RENAME, arg_name );
    }

//Удалить в корзину
void appcore::slot_delete_to_cart()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_DELETE_TO_CART, TAG_EMPTY_ARG );
    }

//Удалить из списка
void appcore::slot_delete_from_list()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_DELETE_FROM_LIST, TAG_EMPTY_ARG );
    }

//Снять выделения
void appcore::slot_mark_all_clear()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_MARK_CLEAN, TAG_EMPTY_ARG );
    }
//Нравится
void appcore::slot_like(int arg_mode)
    {
    if (arg_mode)
        command_send_to_server((int)CMD_MENU_CTX::CMD_LIKE, "1" );
    else
        command_send_to_server((int)CMD_MENU_CTX::CMD_LIKE, "0" );
    }
//
void appcore::slot_new_file_list(QList<Item_list_file> *arg_new_list,int arg_cursor_pos)
    {
    //LOGGING<<"Прием списка файлов закончен.";
    //LOGGING<<"-< "<<QThread::currentThread();
    m_list_file->update_list(arg_new_list);  //Применить новый список
    emit sig_set_index_1(arg_cursor_pos);    //курсор в позицию
    }

void appcore::slot_new_vregch_list(QList<Item_list_alsa_vregch> *arg_new_list, int arg_cursor_pos)
    {
    (void)arg_cursor_pos;
    //LOGGING<<"Прием списка каналов регулировки громкости ALSA закончен.";
    // LOGGING<<"-< "<<QThread::currentThread();
    m_list_alsa_vregch->update_list(arg_new_list);  //Применить новый список
    }

void appcore::slot_new_sw_list(QList<Item_list_alsa_vregch> *arg_new_list, int arg_selected)
    {
    (void)arg_selected;
    //LOGGING<<"Прием списка SW элементов закончен.";
    //LOGGING<<"-< "<<QThread::currentThread();
    m_list_sw->update_list(arg_new_list);  //Применить новый список
    }

void appcore::slot_new_aout_list(QList<Item_list_adev> *arg_new_list)
    {
    //LOGGING<<"Прием списка аудиовыходов закончен.";
    m_list_aout->update_list(arg_new_list);  //Применить новый список
    }

//Закрыть контекстное меню
void appcore::slot_ctx_close()
    {
    command_send_to_server((int)CMD_MENU_CTX::CMD_CLOSE_CTX_MENU, TAG_EMPTY_ARG );
    }

void appcore::slot_change_freq(int arg_value)
    {
    command_send_to_server((int)CMD_MAIN::CMD_CHANGE_FREQ, QString::number(arg_value));
    }

void appcore::slot_change_fmt(int arg_value)
    {
    command_send_to_server((int)CMD_MAIN::CMD_CHANGE_FMT, QString::number(arg_value));
    }

//Значение полосы эквалайзера
void appcore::slot_eq_band(int arg_eqnum, int arg_band, int arg_value)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_EQ_BAND);
    cmd.args_txt[1] = std::to_string(arg_eqnum);    //Номер эквалайзера
    cmd.args_txt[2] = std::to_string(arg_band);     //Номер эквалайзера
    cmd.args_txt[3] = std::to_string(arg_value);    //Значение
    command_send_to_server(&cmd);
    }

//Управление экваалйзером
void appcore::slot_eq(int arg_eq_cmd,int arg_eq_id)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_EQ);
    cmd.args_txt[1] = std::to_string(arg_eq_cmd);   //Комманда 0 - запрос общий, 1 - запрос локальный, 2 - команда on_off
    cmd.args_txt[2] = std::to_string(arg_eq_id);    //Общий / Локальный
    command_send_to_server(&cmd);
    }

void appcore::slot_brig_lcd(int arg_value)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_DISP_BRIG);
    cmd.args_txt[1] = std::to_string(arg_value);

    command_send_to_server(&cmd);
    }

void appcore::slot_brig_ind_vreg(int arg_value)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_BRIG_LEDS);
    cmd.args_txt[1] = std::to_string(arg_value);

    command_send_to_server(&cmd);
  }

void appcore::slot_set_color_file(int arg_id_color, QColor arg_color)
  {
  cmd_format_t cmd;
  cmd.args_txt[0] = std::to_string(CMD_COLOR_FILES);
  cmd.args_txt[1] = std::to_string(arg_id_color);
  cmd.args_txt[2] = std::to_string(0xFFFFFF & arg_color.rgba());

  command_send_to_server(&cmd);
  }

//Сброс цветов файлов
void appcore::slot_reset_colors_file()
  {
  cmd_format_t cmd;
  cmd.args_txt[0] = std::to_string(CMD_COLOR_DEF);
  command_send_to_server(&cmd);
  }

//Отметить
void appcore::slot_mark(unsigned int arg_mark)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_MARK);
    cmd.args_txt[1] = std::to_string(arg_mark);

    command_send_to_server(&cmd);
    }

//отметить все
void appcore::slot_mark_all()
    {
    command_send_to_server((int)CMD_MARK_ALL, TAG_EMPTY_ARG  );
    }

void appcore::slot_set_color_parametr_disp(int arg_id_color, QColor arg_color)
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_DISP_COLOR);
    cmd.args_txt[1] = std::to_string(arg_id_color);
    cmd.args_txt[2] = std::to_string(0xFFFFFF & arg_color.rgba());

    command_send_to_server(&cmd);
    }

void appcore::slot_reset_colors_parametr_disp()
    {
    cmd_format_t cmd;
    cmd.args_txt[0] = std::to_string(CMD_DISP_COLOR_DEF);
    command_send_to_server(&cmd);
    }

void appcore::slot_send_vol_up()
    {
    command_send_to_server((int)CMD_VOL_UP, TAG_EMPTY_ARG  );
    }

void appcore::slot_send_vol_down()
    {
    command_send_to_server((int)CMD_VOL_DOWN, TAG_EMPTY_ARG  );
    }
