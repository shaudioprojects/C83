#pragma once
#include <string>

//Основные комманды
enum CMD_MAIN
    {
    CMD_NO_CMD = 0,    //Нет комманды
    CMD_GET_STATE,     //Получить состояние

    CMD_CURSOR_POS,    //Позиция курсора
    CMD_CURSOR_UP,     //Курсор вверх
    CMD_CURSOR_DOWN,   //Курсор вниз

    CMD_STOP,          //Стоп
    CMD_PAUSE_RESUME,  //Пауза, снять с паузы
    CMD_PAUSE,         //Посавить на паузу
    CMD_RESUME,        //Снять с паузы
    CMD_PREVIOUS,      //Предыдущий трек
    CMD_NEXT,          //Следующий трек
    CMD_OPEN_ONLY,     //Открыть
    CMD_OPEN_ALL,      //Открыть все
    CMD_OPEN_BK_LIST,  //Открыть фоновый список

    CMD_POFF,          //Завершение работы
    CMD_ACOFF,         //Выход из приложения
    CMD_SEEK_POS,      //Позиционирование по файлу

    CMD_TIME_CURRENT,  //Текущее время для клиента
    CMD_TIME_MAX,      //Масимальное время для клиента

    CMD_CHANGE_FREQ,   //Изменить значение передискретизации
    CMD_CHANGE_FMT,    //Изменить формат сэмпла

    CMD_EQ_BAND,            //Значение полосы эвалайзера
    CMD_EQ,                 //Остальные характеристики эквалазера (трактуется клиентом и сервером по разному)
    CMD_EQ_FLAG_PLAYER,     //Состояние фильтра эквалайзера плеера (по факту)

    CMD_ABOUT,              //О приложении
    CMD_CONVERTER_STATE,    //Преобразование потока

    CMD_MESSAGE_BOX,        //Сообщение (для клиента)
    CMD_BK_LIST_VISIBLE,    //Отобразить значек фотонового листа

    CMD_COLOR_FILES,        //Цвет файла
    CMD_COLOR_DEF,          //Сбросить цвета
    CMD_INFO_MS,            //Информация от сервера управления
    CMD_CP_AS_SP,            //Текущий каталог как стартовый
    CMD_OPEN_ONLY_KB,       //Открыть (от клавиатуры)
    CMD_INFO_SPACE,          //Информация о HDD
    CMD_INFO_2,
    CMD_SEEK_F,             //Позиционирование вперед
    CMD_SEEK_B,             //Позиционирование назад
    CMD_AC83_UPDATE
};

enum CMD_OPT
    {
    CMD_OPT_RANDOM = 50,            //Случайный порядок воспроизведения
    CMD_OPT_REPEATE,                //Повтор списка воспроизведения
    CMD_OPT_RESTORE_VOLUME,         //Восстановить громкость после включения
    CMD_OPT_RESTORE_PLAY_FILE,      //Восстанавливать воспроизведение последнего фала
    CMD_OPT_RESTORE_POS_IN_FILE,    //Восстанавливать воспроизведение последнего фала с места останова
    CMD_OPT_NEATLY_VOL,             //Опция - осторожно с громкостью
    CMD_OPT_02,
    CMD_OPT_03,
    CMD_OPT_04,
    CMD_OPT_05

    };

enum CMD_AOUT
    {
    CMD_AOUT_FMT_AVALIABLE = 100,   //Доступный формат сэмпла аудиовыхода
    CMD_AOUT_FMT_CURRENT,           //Текущий формат сэмпла аудиовыхода
    CMD_AOUT_FREQ_AVALIABLE,        //Доступные значения частот аудиовыхода

    CMD_AOUT_FREQ_CURRENT,      //Текущая частота аудиовыхода
    CMD_AOUT_CH_COUNT,          //Информация о каналах
    CMD_AOUT_BITRATE_CURRENT,   //Битрейт
    CMD_AOUT_CODEC_CURRENT,     //PCM / DSD(не реализовано пока)
    CMD_AOUT_SELECT,            //Выбрать аудиодевайс в списке клиента или выбрать в плеере аудиовыход
    CMD_AOUT_OPTS,              //Опции ALSA (resamper,pcmvregchmixer)
    CMD_AOUT_INFO,              //Версия. Еще что нибудь
    CMD_AOUT_03,
    CMD_AOUT_04,
    CMD_AOUT_05
    };

enum CMD_DEC
    {
    CMD_DEC_FREQ = 150,     //Частота
    CMD_DEC_FMT,            //Формат сэмпла
    CMD_DEC_CH_COUNT,       //Кол. каналов
    CMD_DEC_BITRATE,        //Битрейт
    CMD_DEC_CODEC,          //Имя кодека
    CMD_DEC_SIMD,           //Оптимизация
    CMD_DEC_02,
    CMD_DEC_03,
    CMD_DEC_04,
    CMD_DEC_05,
    };

//Списки
enum CMD_LIST
    {
    CMD_LIST_FILE_NEW_START = 200,  //Новый список файлов
    CMD_LIST_FILE_ITEM,             //Элемент списка файлов
    CMD_LIST_FILE_NEW_END,          //Новый список файлов прием закончен

    CMD_LIST_ADEV_NEW_START,        //Новый список аудиоустройств
    CMD_LIST_ADEV_ITEM,             //Элемент списка устройств
    CMD_LIST_ADEV_NEW_END,          //Новый список аудиоустройств прием закончен

    CMD_LIST_ALSA_CHVREG_NEW_START, //Новый список каналов ALSA регулятора громкости
    CMD_LIST_ALSA_CHVREG_ITEM,      //Элемент списка каналов ALSA регулятора громкости
    CMD_LIST_ALSA_CHVREG_NEW_END,

    CMD_LIST_SW_NEW_START,
    CMD_LIST_SW_ITEM,
    CMD_LIST_SW_NEW_END

    };

//Команды контекстного меню
enum CMD_MENU_CTX
    {
    CMD_CONTEXT_MENU = 250, //Запросить контекстное меню (для сервера)  Значение контекстного меню (для клиента)
    CMD_MARK,               //Отметить
    CMD_MARK_ALL,           //Отметить все
    CMD_MARK_CLEAN,         //Снять все выделения
    CMD_NEW_FOLDER,         //Новый плейлист
    CMD_ASS_TARGET_PLS,     //Задать как целевой плейлист
    CMD_ADD_TO_PLS_TARGET,  //добавить в целевой
    CMD_ADD_TO_PLS_BK,      //Добавить в фоновый
    CMD_ADD_POFF,           //Добавить завершение работы
    CMD_DELETE_FROM_LIST,   //Удалить из списка
    CMD_DELETE_TO_CART,     //Удалить файлы в корзину
    CMD_RENAME,             //Переименовать
    CMD_CLOSE_CTX_MENU,     //Закрыть контекстное меню
    CMD_LIKE                //Нравится
    };

//
enum CMD_XXX
    {
    CMD_X = 300,
    };

//Значения связанные с громкостью
enum CMD_VOLUME
    {
    CMD_VOLUME = 400,       //Громкость %
    CMD_VOLUME_DB,          //Громкость в db
    CMD_VOL_UP,             //Громкость +1
    CMD_VOL_DOWN,           //Громкость -1

    CMD_ADM_VOL_DB,         //Минимальная и максимальная громкость db
    CMD_ADM_VOL_LIMIT_DB,   //Пределы минимальной и максимальонй громкости db

    CMD_MUTE,               //Приглушить громкость
    CMD_VOL_REG_ID,         //Регулятор громкости
    CMD_VOL_REG_STEP_DB,    //Шаг изменениея регулятора громкости
    CMD_VOL_REG_ALSA_CH,    //Канал регулировки громкости ALSA регулятора громкости

    CMD_BALANCE,            //Значение баланса %
    CMD_BALANCE_DB,         //Значение баланса в децибелах
    CMD_BALANCE_MAX_DB      //Значение максимальное баланса
    };

enum CMD_VIND
    {
    CMD_VIND_ID = 450,      //ID Индикатора уровня громкости
    CMD_BRIG_LEDS           //Яркость индикатора уровня громкости
    };

enum CMD_DISPLAY
    {
    CMD_DISP_INFO = 500,   //ID дисплея и о дисплее
    CMD_DISP_BRIG,          //Яркость дисплея
    CMD_DISP_COLOR,         //Цвет параметра (номер цвета парметра в аргументах комманды)
    CMD_DISP_COLOR_DEF,     //Сбросить по умолчанию
    CMD_DISP_MSG,           //Отобразить сообщение на дисплее
    CMD_DISP_CLTH,          //Установить цветовую тему
    CMD_DISP_LANG           //Язык интерфейса
    };

enum CMD_KB
    {
    CMD_KB_ID = 550,        //Клавиатура
    CMD_CURRENT_KEY_CODE    //Текущий код клавиатуры
    };

enum CMD_BOARD
    {
    CMD_BD_ID = 600,
    CMD_BD_DATA
    };

enum CMD_SW
    {
    CMD_SW_ID = 650        //Оснавная информация
    };

#define  CMD_ITEMS_MAX 6
struct cmd_format_t
  {
  std::string args_txt[CMD_ITEMS_MAX];
  void cmd_init(void)
      {
      for(int i=0; i<CMD_ITEMS_MAX ; i++)
          {
          args_txt[i].clear();
          }
      }

  };

#define ARG_0_AS_INT    atoi(cmd_current.args_txt[0].c_str())

#define ARG_1_AS_INT    atoi(cmd_current.args_txt[1].c_str())
#define ARG_1_AS_LONG   atol(cmd_current.args_txt[1].c_str())
#define ARG_1_AS_FLOAT  atof(cmd_current.args_txt[1].c_str())
#define ARG_1_AS_PCHAR  cmd_current.args_txt[1].c_str()

#define ARG_2_AS_INT    atoi(cmd_current.args_txt[2].c_str())
#define ARG_2_AS_LONG   atol(cmd_current.args_txt[2].c_str())
#define ARG_2_AS_FLOAT  atof(cmd_current.args_txt[2].c_str())
#define ARG_2_AS_PCHAR  cmd_current.args_txt[2].c_str()

#define ARG_3_AS_INT    atoi(cmd_current.args_txt[3].c_str())
#define ARG_3_AS_LONG   atol(cmd_current.args_txt[3].c_str())
#define ARG_3_AS_PCHAR  cmd_current.args_txt[3].c_str()


#define ARG_4_AS_INT    atoi(cmd_current.args_txt[4].c_str())
#define ARG_4_AS_PCHAR  cmd_current.args_txt[4].c_str()

#define ARG_5_AS_INT    atoi(cmd_current.args_txt[5].c_str())
#define ARG_5_AS_PCHAR  cmd_current.args_txt[5].c_str()
