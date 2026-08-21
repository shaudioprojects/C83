QT += quick
QT += xml svg
# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        appcore.cpp \
        client_tcp.cpp \
        decoder.cpp \
        item_list_adev.cpp \
        item_list_alsa_vregch.cpp \
        item_list_file.cpp \
        list_adev.cpp \
        list_alsa_vregch.cpp \
        list_file.cpp \
        logging.cpp \
        main.cpp \
        socket_tcp.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    appcore.h \
    client_tcp.h \
    commands.h \
    decoder.h \
    esc_sequences.h \
    item_list_adev.h \
    item_list_alsa_vregch.h \
    item_list_file.h \
    list_adev.h \
    list_alsa_vregch.h \
    list_file.h \
    logging.h \
    socket_tcp.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

win32: RC_ICONS = $$PWD/Icon/for_app/din.ico
win32: LIBS += -lWs2_32


contains(ANDROID_TARGET_ARCH,armeabi-v7a)
    {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android_armeabi_v7a
    }
contains(ANDROID_TARGET_ARCH,arm64-v8a)
        {
        ANDROID_PACKAGE_SOURCE_DIR = \
            $$PWD/android_arm64_v8a
        }
