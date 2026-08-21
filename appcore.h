#pragma once

#include <QObject>
#include <string>
#include <QDateTime>

#include "commands.h"

#include "list_file.h"
#include "list_adev.h"
#include "list_alsa_vregch.h"

#include "decoder.h"
#include "client_tcp.h"

struct ip_pop_struct
    {
    QString ip_string;
    QString ip_node_name;
    bool    ip_state;
    qint64  connect_time;
    void init (void)
        {
        ip_string    = "-";
        ip_node_name = "-";
        ip_state     = 0;
        connect_time = 0;
        }
    };

class appcore : public QObject, decoder
{
    Q_OBJECT
public:
    //explicit decoder_C83(QObject *parent = nullptr);
    appcore();
   ~appcore();
    void parse(char * arg_buf,int arg_size);
    void on_client_change_state(void *arg_state);

    void set_list (List_file_Model *arg_list);        //Задать список файлов
    void set_list_aout (List_adev_model *arg_list);   //Задать список аудиоустройств
    void set_list_alsa_vregch (List_alsa_vregch_model *arg_list);   //Задать список каналов ALSA
    void set_list_sw (List_alsa_vregch_model *arg_list);            //Задать список SW

    void start_work(void);  //Начать работу
    void stop_work(void);   //Закончить работу

public slots:
    //Эти функции дергает слой QML
    void slot_start();
    void slot_ip_address_change(QString arg_ip);

    void slot_pre(void);
    void slot_stop(void);
    void slot_pause_resume(void);
    void slot_pause(void);
    void slot_next(void);

    void slot_open(void);
    void slot_open_all(void);
    void slot_open_bk_list(void);

    void slot_repeate(bool arg_value);
    void slot_random(bool arg_value);
    void slot_neatly_vol(bool arg_value);

    void slot_cursor_up(void);
    void slot_cursor_down(void);
    void slot_click_on_item(unsigned int arg_cursor_pos); //Изменить положение курсора

    void slot_set_mode_pause(void);    //Приостановить работу
    void slot_set_mode_play(void);     //Продолжить работу

    void slot_send_volume(float arg_perc);      //Установить громкость
    void slot_send_vol_up();
    void slot_send_vol_down();

    void slot_balance(float arg_value);         //Установить баланс
    void slot_admin_volume(float arg_min_value,float arg_max_value); //Установить пределы громкости

    int  slot_get_tcp_thr_read_state(void);

    long slot_get_rcv_bytes(void);
    long slot_get_send_bytes(void);

    void slot_restore_volume(bool arg_value);
    void slot_restore_play_file(bool arg_value);
    void slot_restore_pos_in_play_file(bool arg_value);

    void slot_seek_sec(long arg_sec);

    void slot_poff(void);
    void slot_poff_ac(void);
    void slot_poff_add(void);
    void slot_prepare_for_exit(void);



    void slot_click_on_acard(QString arg_aout);
    void slot_click_on_alsa_ch(int arg_pos);

    void slot_context_menu(void);
    void slot_ctx_close(void);
    void slot_as_target(void);
    void slot_add_to_pls(void);
    void slot_add_to_bk_pls(void);
    void slot_delete_to_cart(void);
    void slot_delete_from_list(void);

    void slot_mark(unsigned int arg_mark);
    void slot_mark_all(void);
    void slot_mark_all_clear(void);
    void slot_like(int arg_mode);

    void slot_new_pls(QString arg_name);
    void slot_rename(QString arg_name);

    void slot_change_freq   (int arg_value);
    void slot_change_fmt    (int arg_value);

    void slot_eq_band   (int arg_eqnum, int arg_band, int arg_value);
    void slot_eq        (int arg_eq_cmd,int arg_eq_id);

    void slot_brig_lcd      (int arg_value);
    void slot_brig_ind_vreg (int arg_value);

    void slot_set_color_file(int arg_id_color,QColor arg_color);
    void slot_reset_colors_file(void);
    void slot_set_color_parametr_disp(int arg_id_color,QColor arg_color);
    void slot_reset_colors_parametr_disp(void);
    void slot_set_start_path(void);
    void slot_disconnect    (void);

    void slot_opt_alsa  (bool arg_value1, bool arg_value2, bool arg_value3);
    void slot_board_dac (int arg_id, int arg_2,  int arg_3, int arg_4);
    void slot_select_sw_item(int index);
    void slot_update    (int arg_mode);
    void slot_set_theme (int arg_th);
    void slot_set_gui_lang(int arg_lang);
    void slot_open_album(void);
    void slot_open_artist(void);

signals:
    void sig_status_label(QString arg_txt,QColor arg_color);
    void sig_connected(QString arg_ip);
    void sig_set_th(int arg_th);
    void sig_set_lng(int arg_lng,int arg_status);
    void sig_pop_ip(QString arg_txt, int arg_num_ip, int arg_ip_state,QString arg_nname );
    void sig_connecting_start(QString arg_ip);
    void sig_disconnected();
    void sig_ipaddress(QString arg_ip);
    void sig_build_date(QString arg_date);
    void sig_set_index_0(unsigned int arg_index);
    void sig_set_index_1(unsigned int arg_index);

    void sig_repeate(bool arg_value);
    void sig_random(bool arg_value);
    void sig_neatly_vol(bool arg_value);

    void sig_restore_volume(bool arg_value);
    void sig_restore_play_file(bool arg_value);
    void sig_restore_position_in_play_file(bool arg_value);

    void sig_time_current(long arg_current_time);
    void sig_select_aout(QString arg_name);
    void sig_select_alsa_ch(int arg_num);
    void sig_sw(int arg_id,QString arg_swname,int arg_sItem,QString arg_sItemName);
    void sig_time_duration(long arg_end_time);
    void sig_bk_list(int arg_mode);

    void sig_volume             (int    arg_value);
    void sig_volume_db          (float  arg_value_db);
    void sig_vol_step_db        (float  arg_value_db);

    void sig_balance            (int    arg_value, int arg_bal_state);
    void sig_balance_db         (float  arg_value_db);
    void sig_balance_max_db     (float  arg_value_db);


    void sig_adm_vol_db         (float arg_min, float arg_max);
    void sig_adm_vol_limit_db   (float arg_min, float arg_max);

    void sig_vreg_id            (int arg_vreg_id,   QString arg_vreg_name);
    void sig_aout_freq_avaliable(int arg_freq,      bool arg_value);
    void sig_aout_fmt_avaliable (QString arg_fmt,   bool arg_value);

    void sig_aout_freq_current  (int arg_value);
    void sig_aout_fmt_current   (QString arg_value);
    void sig_aout_ch_count      (int arg_value1, int arg_value2, int arg_value3);
    void sig_aout_bitrate       (int arg_value);
    void sig_aout_codec         (QString arg_value);

    void sig_opt_alsa           (bool arg_value1,bool arg_value2,bool arg_value3);

    void sig_dec_freq_current   (int arg_value);
    void sig_dec_fmt_current    (QString arg_value);

    void sig_dec_ch_count   (int arg_value);
    void sig_dec_bitrate    (int arg_value);
    void sig_dec_codec      (QString arg_value);
    void sig_dec_simd       (QString arg_value);

    void sig_message_box    (QString arg_text_1,QString arg_text_2,int arg_flags);
    void sig_context_menu   (long arg_value,QString arg_fname);

    void sig_ctx_close      (void);
    void sig_convert_state  (bool arg_bp, bool swr1_state, bool swr2_state, bool swvol);

    void sig_eq_band        (int arg_eq_id,int arg_band,int arg_value);
    void sig_eq_state       (int arg_eq_id,bool arg_state);
    void sig_eq_flag_player (bool arg_value);

    void sig_about          (QString arg_sname, QString arg_sv, QString arg_author, QString arg_build_date, QString  arg_arch);
    void sig_change_freq    (int arg_value);
    void sig_change_fmt     (int arg_value);

    void sig_brig_lcd       (int arg_value,int arg_status);
    void sig_brig_ind_vreg  (int arg_value);

    void sig_vind_id        (int arg_id, QString arg_name);
    void sig_disp_id        (int arg_id, QString arg_name, QString arg_gui);
    void sig_kb_id          (int arg_id, QString arg_name);

    void sig_bd_id          (int arg_id, QString arg_name, QString arg_port,int arg_port_status);
    void sig_bd_data        (int arg_id, int arg_2,int arg_3,int arg_4,int arg_5);
    void sig_update         (int arg_value);
    void sig_mark           (unsigned int arg_index,int arg_value);
    void sig_color_file     (unsigned arg_id_file,float arg_red,float arg_green, float arg_blue);
    void sig_color_disp_parametr (unsigned arg_id_parametr,float arg_red,float arg_green, float arg_blue);
    void sig_client_count   (int arg_count);
    void sig_aout_info      (QString arg_version);
    void sig_hdd_info       (QString arg_space_full, QString arg_space_free);
    //Сигналы о готовности новых списков
    void sig_new_file_list      (QList<Item_list_file>          *arg_new_list, long arg_cursor_pos);
    void sig_new_vregch_list    (QList<Item_list_alsa_vregch>   *arg_new_list, long arg_cursor_pos);
    void sig_new_sw_list        (QList<Item_list_alsa_vregch>   *arg_new_list, long arg_selected);
    void sig_new_aout_list      (QList<Item_list_adev>          *arg_new_list );


private slots:

    //Слоты принятия новых списков
    void slot_new_file_list     (QList<Item_list_file> *arg_new_list,       int arg_cursor_pos);
    void slot_new_vregch_list   (QList<Item_list_alsa_vregch> *arg_new_list,int arg_cursor_pos);
    void slot_new_sw_list       (QList<Item_list_alsa_vregch> *arg_new_list,int arg_selected);
    void slot_new_aout_list     (QList<Item_list_adev> *arg_new_list);

private:
    bool  command_parse (char *arg_cmd_text);
    int   command_execute(void);
    void  command_send_to_server(int arg_cmd,QString arg_qstr);
    void  command_send_to_server(cmd_format_t *arg_cmd);
    void  send_string   (char *arg_str);



    void  write_settings_to_file    (void);
    void  read_settings_from_file   (void);
    void  apply_pop_ip              (void);
    void  event_connected   (QString arg_ip);
    void  event_disconected (void);     //Произошел разрыв соединения
    void  assign_node_name  (QString arg_name);

    void  reset_parser              (void);     //Сбросить парсер (вызываем после дисконекта)
    List_file_Model*        m_list_file;        //Указатель на модель списка файлов
    List_adev_model*        m_list_aout;        //Указатель на модель списка аудиоустройств
    List_alsa_vregch_model* m_list_alsa_vregch; //Указатель на модель списка каналов ALSA
    List_alsa_vregch_model* m_list_sw;          //Указатель на модель списка SW

    QList<Item_list_file>           *m_temp_file_list;          //указатель на принимаемый список файлов
    QList<Item_list_adev>           *m_temp_adev_list;          //указатель на принимаемый список звуковых устройств
    QList<Item_list_alsa_vregch>    *m_temp_alsa_vregch_list;   //указатель на принимаемый список каналов ALSA
    QList<Item_list_alsa_vregch>    *m_temp_sw_list;            //указатель на принимаемый список SW элементов

    QString       ip_from_file;     //Прочтенный из файла
    QDateTime     currentDateTime;
    ip_pop_struct ip_pop[3];        //Популярные ip
    cmd_format_t  cmd_current;
    std::string   cmd_parts;
    client_tcp    client;           //Сетевой клиент - подключается к серверу и получает данные с помощью декодера пользователя
    uint8_t       current_th;
    const uint8_t TAG_ARG_END = '\r';
    const uint8_t TAG_STR_END = '\0';
    const uint8_t TAG_CMD_END = '\n';
};


