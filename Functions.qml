import QtQuick 2.0

QtObject {
    id: functions

    function getFontSize(size,window){
        return Math.floor(getWidthSize(size,window)*1);
    }

    function getHeightMargin(window){
        var heightRatio = 667/window.height;
        var widthRatio = 375/window.width;

        if(heightRatio<widthRatio)
            return (window.height - 667 / widthRatio) /2
        return 0;
    }

    function getWidthMargin(window){
        var heightRatio = 667/window.height;
        var widthRatio = 375/window.width;

        if(heightRatio>widthRatio)
            return (window.width - 375 / heightRatio) /2
        return 0;
    }

    function getHeightSize(size,window){
        return (size / (667 / (window.height-getHeightMargin(window)*2)))
    }

    function getWidthSize(size,window){
        return (size / (375 / (window.width-getWidthMargin(window)*2)))
    }
}
