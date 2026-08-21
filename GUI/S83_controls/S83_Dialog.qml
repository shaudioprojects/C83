/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.Dialog {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding,
                            implicitHeaderWidth,
                            implicitFooterWidth)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding
                             + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
                             + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))

    padding:            3//24
    topPadding:         3//20
    bottomPadding:      0
   // Material.elevation: 24

    enter: Transition {
        // grow_fade_in
        NumberAnimation { property: "scale"; from: 0.9; to: 1.0; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.OutCubic; duration: 150 }
    }

    exit: Transition {
        // shrink_fade_out
        NumberAnimation { property: "scale"; from: 1.0; to: 0.9; easing.type: Easing.OutQuint; duration: 220 }
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.OutCubic; duration: 150 }
    }



    header:
    Rectangle
            {
            //radius: 10
            width:  100
            height: 30
            color: "transparent"
            visible: false
            Text
                {
                anchors.fill: parent

                anchors.leftMargin:     5
                anchors.rightMargin:    5

                text:   "Сообщение"
                elide: Text.ElideRight
                font.pixelSize: 18
                color: "white"

                }
            }

    background:
    Rectangle
        {
        radius: 5
        anchors.fill: parent
        color: current_theme.color_ctrl_background//control.Material.dialogColor

        layer.enabled: control.Material.elevation > 0
        layer.effect: ElevationEffect
            {
            elevation: control.Material.elevation
            }
        }



    /*
    Label {
        text: control.title
        visible: control.title
        elide: Label.ElideRight
        padding: 24
        bottomPadding: 0
        // TODO: QPlatformTheme::TitleBarFont
        font.bold: true
        font.pixelSize: 16
        background: PaddedRectangle {
            radius: 2
            color: control.Material.dialogColor
            bottomPadding: -2
            clip: true
        }
    }*/

    footer:
    Rectangle
        {
        radius: 2
        width: 100
        height: 20
        color: "green"
        }

    T.Overlay.modal: Rectangle
        {
        color: "#bb000000"
        Behavior on opacity { NumberAnimation { duration: 250 } }
        }

    T.Overlay.modeless: Rectangle
        {
        color: "#bb000000"
        Behavior on opacity { NumberAnimation { duration: 250 } }
        }
}
