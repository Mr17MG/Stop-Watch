import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
//import QtQuick.Dialogs 1.2
Item {
    anchors.top:tabBar.bottom
    anchors.topMargin: functions.getHeightSize(20,window)
    anchors.right: parent.right
    anchors.left: parent.left
    anchors.bottom: parent.bottom
    property int minute: 0
    property int second: 3
    property int minuteCounter : minute
    property int secondCounter : second
    property alias mg: progress
    property alias running: timeCounting

    FontLoader{
        id:digitFont
        source:"qrc:/fonts/digital-7.regular.ttf"
    }
    Timer{
        id:timeCounting
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            progress.value++
            if(--secondCounter < 0)
            {
                secondCounter+=60
                minuteCounter--
            }
            time.text= (minuteCounter<10?"0"+minuteCounter:minuteCounter) + " : " + (secondCounter<10?"0"+secondCounter:secondCounter)
            if(minuteCounter === 0 && secondCounter===0)
            {
                running=false
                startBtn.text = "شروع"
                resetBtn.enabled=true
            }

        }
    }
    ProgressBarCircle{
        id:progress
        anchors.horizontalCenter:  parent.horizontalCenter
        size:functions.getWidthSize(500,window)
        value: 0
        maxVal: second + (minute*60)
        colorBackground: "transparent"
        colorCircle:"#2196F3"
        isPie: true
    }

    Text {
        id: time
        text: (minute<10?"0"+minute:minute) + " : " + (second<10?"0"+second:second)
        font{pixelSize: functions.getFontSize(150,window);family:digitFont.name}
        color:"white"
        anchors.centerIn: progress
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        MouseArea{
            anchors.fill: parent
            onClicked:{
                if(timeCounting.running === false)
                    timePicker.open()
            }
        }
    }

    Button{
        id:startBtn
        anchors.bottom: parent.bottom
        anchors.bottomMargin: functions.getHeightSize(20,window)
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: functions.getWidthSize(25,window)
        text: qsTr("شروع")
        font{family: adabFont.name;pixelSize: functions.getFontSize(40,window)}
        width: functions.getWidthSize(250,window)
        height: functions.getHeightSize(60,window)
        contentItem: Text {
            text: parent.text
            font: parent.font
            opacity: enabled ? 1.0 : 0.3
            color: parent.down ? "#cccccc" : "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            color: "#04b9d4"
            implicitWidth: 100
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            radius: functions.getWidthSize(50,window)
        }
        onClicked: {
            if(minuteCounter === 0 && secondCounter===0)
            {
                minuteCounter = minute
                secondCounter = second
                time.text= (minuteCounter<10?"0"+minuteCounter:minuteCounter) + " : " + (secondCounter<10?"0"+secondCounter:secondCounter)
                progress.value = 0
                timeCounting.running =true
                return
            }

            if(timeCounting.running===false)
            {
                timeCounting.running=true
                startBtn.text="توقف"
            }
            else if(timeCounting.running===true){
                timeCounting.running=false
                startBtn.text="شروع"
            }
        }
    }
    Button{
        id:resetBtn
        enabled: timeCounting.running || !(minute === minuteCounter || second === secondCounter)
        anchors.bottom: parent.bottom
        anchors.bottomMargin: functions.getHeightSize(20,window)
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: functions.getWidthSize(25,window)
        text: qsTr("راه اندازی مجدد")
        font{family: adabFont.name;pixelSize: functions.getFontSize(40,window)}
        width: functions.getWidthSize(250,window)
        height: functions.getHeightSize(60,window)
        onClicked: {
            minuteCounter = minute
            secondCounter = second
            time.text= (minuteCounter<10?"0"+minuteCounter:minuteCounter) + " : " + (secondCounter<10?"0"+secondCounter:secondCounter)
            progress.value = 0
            timeCounting.running = false
            startBtn.text="شروع"
        }

        contentItem: Text {
            text: parent.text
            font: parent.font
            opacity: enabled ? 1.0 : 0.3
            color: parent.down ? "#cccccc" : "#ffffff"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
        background: Rectangle {
            color: "#ff8a00"
            implicitWidth: 100
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            radius: functions.getWidthSize(50,window)
        }
    }

    Dialog {
        id:timePicker
        modal: true
        width: functions.getWidthSize(450,window)
        height: functions.getHeightSize(400,window)
        x: -parent.x + (parent.parent==null?0:(parent.parent.width- width)/2)
        y: -parent.y + (parent.parent==null?0:(parent.parent.height- height)/2)
        Tumbler{
            id:secondTumbler
            model:60
            width: functions.getWidthSize(135,window)
            height: functions.getHeightSize(220,window)
            anchors.left: parent.horizontalCenter
            anchors.leftMargin: functions.getWidthSize(20,window)
            anchors.top:parent.top
            anchors.topMargin: functions.getHeightSize(40,window)
            background: Item {
                Text {
                    id: name
                    text: qsTr("ثانیه")
                    font{family: adabFont.name;pixelSize: functions.getFontSize(20,window)}
                    anchors.top:parent.top
                    anchors.topMargin: functions.getHeightSize(-30,window)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle {
                    opacity: parent.parent.enabled ? 0.2 : 0.1
                    border.color: "#000000"
                    width: parent.width
                    height: 1
                    anchors.top: parent.top
                }

                Rectangle {
                    opacity: parent.parent.enabled ? 0.2 : 0.1
                    border.color: "#000000"
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                }
            }

            delegate: Text {
                text: modelData < 10 ? "0"+modelData:modelData
                font{family:  digitFont.name;pixelSize: functions.getFontSize(40,window)}

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 1.0 - Math.abs(Tumbler.displacement) / 2.4 /*/ (parent.visibleItemCount /0.5)*/
            }
        }
        Tumbler{
            id:minuteTumbler
            model:100
            width: functions.getWidthSize(135,window)
            height: functions.getHeightSize(220,window)
            anchors.right: parent.horizontalCenter
            anchors.rightMargin: functions.getWidthSize(20,window)
            anchors.top:parent.top
            anchors.topMargin: functions.getHeightSize(40,window)
            background: Item {
                Text {
                    id: name2
                    text: qsTr("دقیقه")
                    font{family: adabFont.name;pixelSize: functions.getFontSize(20,window)}
                    anchors.top:parent.top
                    anchors.topMargin: functions.getHeightSize(-30,window)
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Rectangle {
                    opacity: parent.parent.enabled ? 0.2 : 0.1
                    border.color: "#000000"
                    width: parent.width
                    height: 1
                    anchors.top: parent.top
                }

                Rectangle {
                    opacity: parent.parent.enabled ? 0.2 : 0.1
                    border.color: "#000000"
                    width: parent.width
                    height: 1
                    anchors.bottom: parent.bottom
                }
            }

            delegate: Text {
                text: modelData < 10 ? "0"+modelData:modelData
                font{family:  digitFont.name;pixelSize: functions.getFontSize(40,window)}

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                opacity: 1.0 - Math.abs(Tumbler.displacement) / 2.4 /*/ (parent.visibleItemCount /0.5)*/
            }
        }

        Button{
            text:"انتخاب"
            font{family: adabFont.name;pixelSize: functions.getFontSize(40,window)}
            highlighted: true
            width: functions.getWidthSize(200,window)
            height: functions.getHeightSize(50,window)
            Material.background: Material.Yellow
            anchors.top: secondTumbler.bottom
            anchors.topMargin: functions.getHeightSize(30,window)
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                minute = minuteTumbler.currentIndex
                second = secondTumbler.currentIndex
                time.text= (minute<10?"0"+minute:minute) + " : " + (second<10?"0"+second:second)
                timePicker.close()
            }
        }

    }
}
