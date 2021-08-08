import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Terminalaccess 1.0
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 0.1
import "components"

Page {
    id: wallpapersPage

        header: state == "default" ? defaultHeader : searchPageHeader
        state: "default"

    PageHeader {
        id: defaultHeader
            title: "Highest Rated"

            StyleHints {
               foregroundColor: UbuntuColors.black
               backgroundColor: UbuntuColors.indianred
               dividerColor: "#90ee90"
             }

    }

    PageHeader {
        id: searchPageHeader
        visible: wallpapersPage.state == "search"
        title: i18n.tr("Search")
        leadingActionBar {
            actions: [
                Action {
                    id: closePageAction
                    text: i18n.tr("Close")
                    iconName: "back"
                    onTriggered: {
                        wallpapersPage.state = "default"
                        jsonwallpaper.query = "$[*]"

                    }
                }

            ]
        }/*
            trailingActionBar {
                actions: [
                    Action {
                        iconName: "filter"
                        text: "filter"
                    }
               ]
               numberOfSlots: 1
            }
        */
        contents: Rectangle {
            color: "#fff"
            anchors {
                left: parent.left
                right: parent.right
                verticalCenter: parent.verticalCenter
            }
            TextField {
                id: searchField
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                primaryItem: Icon {
                    anchors.leftMargin: units.gu(0.2)
                    height: parent.height*0.5
                    width: height
                    name: "find"
                }
                hasClearButton: true
                inputMethodHints: Qt.ImhNoPredictiveText
                onVisibleChanged: {
                    if (visible) {
                        forceActiveFocus()
                    }
                }
                onTextChanged: {
                    if (searchField.text == ""){
                        jsonwallpaper.source = "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=highest_rated&page="+pageWall+"&info_level=1"
                    }else{
                        jsonwallpaper.source = "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=search&page="+pageWall+"&term="+searchField.text+""
                    }
                }
            }
        }
    }

    property int pageWall: 1

    Rectangle {
        id:main
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: wallpapersPage.header.bottom
        }
        color: "#111111"


    ActivityIndicator {
        id: activity
        running: true
        anchors.centerIn: parent
    }

    GridView {
        id: gview
        anchors.fill: parent
        anchors {
            rightMargin: units.gu(1)
            leftMargin: units.gu(1)
            topMargin: units.gu(2)

        }
        cellHeight: iconbasesize+units.gu(15)
        property real iconbasesize: units.gu(12)
        cellWidth: Math.floor(width/Math.floor(width/iconbasesize))

        focus: true
        model: jsonwallpaper.model


            JSONListModel {
                id: jsonwallpaper
                source: "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=highest_rated&page="+pageWall+"&info_level=1"
                query: "$[*]"
            }

        onMovementEnded: {
            if (atYEnd) {
                gview.model.clear()
                pageWall = pageWall + 1
            }
            if (wallpapersPage.state == "search")
            {
                jsonwallpaper.source = "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=search&page="+pageWall+"&term="+searchField.text+""
            }
            else
            {
                jsonwallpaper.source = "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=highest_rated&page="+pageWall+"&info_level=1"
            }
        }

        //tamaño de las celdas donde estan las preview

        delegate: Rectangle {
                    width: gview.cellWidth
                    height: gview.iconbasesize
                    color: "transparent"

                    Item {
                        width: units.gu(13)
                        height: units.gu(25)
                            anchors.horizontalCenter: parent.horizontalCenter

                        Image {
                            id: imgIcons
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: parent.height
                            source: Qt.resolvedUrl(model.url_thumb)
                            visible: false
                            fillMode: Image.PreserveAspectCrop
                        }

                        UbuntuShape {
                            source: imgIcons
                            width: parent.width
                            height: parent.height
                            radius : "medium"
                            sourceFillMode: UbuntuShape.PreserveAspectCrop
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                pageStack.push(Qt.resolvedUrl("WallpaperView.qml"), {"idWallpaper": model.id});
                            }
                        }
                        Component.onCompleted: {
                            activity.running = false
                        }
                    } // Item
            }// delegate Rectangle

        }





    } //rectangle
} //page

