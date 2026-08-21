import QtQuick 2.0


Rectangle
    {
    /**
    * @brief Shows this Toast
    * @param {string} text Text to show
    * @param {real} duration Duration to show in milliseconds, defaults to 3000
    */

    function show(text, duration)
        {
        theText.text = text;
        if(typeof duration !== "undefined")
            {
            if (duration >= 2*fadeTime)
                time = duration;
            else
                time = 2*fadeTime;
            }
        else
            time = defaultTime;
        if (anim.running)
            anim.restart();
        else
            anim.start();
        }

    property bool selfDestroying: false // Будет ли этот тост самоуничтожаться, когда он будет закончен

    /**
    * Private
    */

    id: root

    property real          time:        defaultTime
    readonly property real defaultTime: 3000
    readonly property real fadeTime:    300

    property real margin: 10

    width: childrenRect.width + 2*margin
    height: childrenRect.height + 2*margin
    radius: 5

    anchors.horizontalCenter: parent.horizontalCenter

    opacity: 0
    color: "white"

    Text
        {
        id:     theText
        text:   ""

        horizontalAlignment: Text.AlignHCenter
        x: margin
        y: margin
        }

    SequentialAnimation on opacity
        {

        id:         anim
        running:    false

        NumberAnimation
            {
            to: 0.9
            duration: fadeTime
            }

        PauseAnimation
            {
            duration: time - 2*fadeTime
            }

        NumberAnimation
            {
            to: 0
            duration: fadeTime
            }

        onRunningChanged:
            {
            if(!running && selfDestroying)
                root.destroy();
            }
        }
}
