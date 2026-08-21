#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "logging.h"
#include "appcore.h"

int main(int argc, char *argv[])
  {
  #if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
      QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
  #endif
      QGuiApplication app(argc, argv);



    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));



    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated, &app, [url](QObject *obj, const QUrl &objUrl)
        {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);


    QQmlContext *rootContext = engine.rootContext();

    List_file_Model           m_list_file;      //Список файлов (модель для QML) Создана сдесь что бы прокинуть в слой QML через setContextProperty
    List_adev_model           m_list_aout;      //Модель списка аудиоустройств. Создана сдесь что бы прокинуть в слой QML через setContextProperty
    List_alsa_vregch_model    m_list_vregch;    //Модель списка каналов ALSA регуляторов громкости
    List_alsa_vregch_model    m_list_sw;        //Модель списка каналов SW

    appcore     myApp;                          //Ядро приложения - весь функционал
    myApp.set_list      (&m_list_file);         //Пропишем список файлов.
    myApp.set_list_aout (&m_list_aout);         //Пропишем список аудиоустройств.
    myApp.set_list_alsa_vregch(&m_list_vregch); //Список каналов ALSA
    myApp.set_list_sw   (&m_list_sw);           //Список каналов SW

    rootContext->setContextProperty("my_app_sw",            &m_list_sw);
    rootContext->setContextProperty("my_app_alsa_vregch",   &m_list_vregch);
    rootContext->setContextProperty("my_app_aout_model",    &m_list_aout);
    rootContext->setContextProperty("my_app_list_model",    &m_list_file);
    rootContext->setContextProperty("my_app",               &myApp);

    //LOGGING<<ANSI_COLOR_GREEN"Основной поток: "<<QThread::currentThread()<<ANSI_COLOR_RESET;



    QObject::connect(&app, &QCoreApplication::aboutToQuit, [&myApp]()
        {
        myApp.stop_work();//Заканчиваем
        });

    engine.load(url);       //Запускаем QML
    int ret = app.exec();
    LOGGING<<"Работа завершена.";
    return ret;
}
