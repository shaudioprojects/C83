import QtQuick 2.0

Item
{
    id: vreg_ids
    readonly property int vr_NO:         0  //Нет регулятора громкости
    readonly property int vr_PGA2310:    1  //PGA2310
    readonly property int vr_ALSA_MIXER: 2  //Системный ALSA
    readonly property int vr_SMBUS_ADAU: 3  //Регулятор громкости в чипе ADAU
    readonly property int vr_SOFTWARE:   4  //Програмный регулятор громкости
}
