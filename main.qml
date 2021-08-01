import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Window {
    id:window
    visible: true
    width: 640
    height: 480
    title: qsTr("stopWatch")
    Functions{
        id:functions
    }

    FontLoader{
        id:adabFont
        source:"qrc:/fonts/Far_Curves.ttf"
    }

    Rectangle{
        anchors.fill: parent
        color: "#040012"
        TabBar{
            id:tabBar
            width: parent.width
            height: functions.getHeightSize(60,window)
            currentIndex: 1
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }

            TabButton{
                text:qsTr("پرسش و پاسخ")
                enabled: presentation.running.running === false
                font{pixelSize: functions.getFontSize(30,window);family: adabFont.name}
                height: functions.getHeightSize(60,window)
                background: Rectangle{
                    anchors.fill: parent
                    color: parent.checked?"#ff8a00":"transparent"
                }
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color:"white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            TabButton{
                text:qsTr("ارائه")
                enabled: answer.running.running === false
                height: functions.getHeightSize(60,window)
                background: Rectangle{
                    anchors.fill: parent
                    color: parent.checked?"#ff8a00":"transparent"
                }
                font{pixelSize: functions.getFontSize(30,window);family: adabFont.name}
                contentItem: Text {
                    text: parent.text
                    font: parent.font
                    opacity: enabled ? 1.0 : 0.3
                    color:"white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.centerIn: parent
                }
            }
        }
        TimeCounter{
            //ارائه
            id:presentation
            visible: tabBar.currentIndex===1
            minute: 5
            second: 0
            mg.isPie:true

        }
        TimeCounter{
            //پرسش و پاسخ
            id: answer
            visible: tabBar.currentIndex===0
            mg.isPie:true
            minute: 3
            second: 0
        }

        Image {
            id: viewControl
            source: "qrc:/images/Full_Screen.png"
            anchors.right: parent.right
            anchors.rightMargin: functions.getWidthSize(20,window)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: functions.getHeightSize(20,window)
            width: functions.getWidthSize(50,window)
            height: functions.getHeightSize(50,window)
            sourceSize.width: width*2
            sourceSize.height: height*2
            rotation: window.visibility===Window.FullScreen ? 180:0
            MouseArea{
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    window.visibility= window.visibility===Window.FullScreen ? Window.Maximized: Window.FullScreen
                }
            }
        }
        Image {
            id: logo
            source: "qrc:/images/LOGO.png"
            anchors.left: parent.left
            anchors.leftMargin: functions.getWidthSize(20,window)
            anchors.bottom: parent.bottom
            anchors.bottomMargin: functions.getHeightSize(20,window)
            width: functions.getWidthSize(118,window)
            height: functions.getHeightSize(100,window)
            sourceSize.width: width*2
            sourceSize.height: height*2
        }
    }

}
