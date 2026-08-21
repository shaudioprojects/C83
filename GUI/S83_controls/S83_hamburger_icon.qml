import QtQuick 2.2

Rectangle {
  width: 40
  height: 40
  color: "transparent"
  property string icon_state: "-"
  signal iconClicked();



  S83_MenuBackIcon
    {
    id: menuBackIcon
    anchors.centerIn: parent
    }

  function set_state_menu()
    {
    menuBackIcon.state ="menu"
    }

  function set_state_back()
    {
    menuBackIcon.state ="back"
    }

  MouseArea
    {
    anchors.fill: parent
    onClicked:
        {
        menuBackIcon.state = menuBackIcon.state === "menu" ? "back" : "menu"
        icon_state = menuBackIcon.state
        iconClicked();
        }
    }
}
