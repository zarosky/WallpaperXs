import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.2
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Terminalaccess 1.0
import "components"

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'WallPaper-X'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    theme.name: "Ubuntu.Components.Themes.SuruDark"

Component {
    id: diag
 Dialog {
    id: popup
    title: "Authentification needed"
    TextField {
        id:inp
        placeholderText: "Enter password (by defaut : phablet)"
        echoMode: TextInput.Password
    }
    Button {
        text:"ok"
        onClicked: {Terminalaccess.inputLine(inp.text, false);PopupUtils.close(popup)}
    }
}
}

PageStack {
        anchors.fill: parent
  id: pageStack

        Component.onCompleted: push(homePage);

    Page {
        id: homePage
        anchors.fill: parent

        header: state == "default" ? defaultHeader : searchPageHeader
        state: "default"

        PageHeader {
            id: defaultHeader
            visible: homePage.state == "default"

            title: "WallPaper-X"

            StyleHints {
               foregroundColor: UbuntuColors.black
               backgroundColor: UbuntuColors.indianred
               dividerColor: "#000000"
             }

            trailingActionBar.actions: [
                Action {
                    iconName: "search"
                    text: i18n.tr("Wallpapers")
                    onTriggered: {
                        pageStack.push(Qt.resolvedUrl("Wallpaper.qml"));
                    }
                }
            ]

            leadingActionBar {
               actions: [
                   Action {
                       iconName: "info"
                       text: "about"
                       onTriggered: {
                            pageStack.push(Qt.resolvedUrl("About.qml"));
                       }
                   }/*,
                   Action {
                       iconName: "search"
                       text: "search"
                       onTriggered: {
                           homePage.state = "search"
                       }
                   }*/
              ]
              numberOfSlots: 2
           }

        }

    PageHeader {
        id: searchPageHeader
        visible: homePage.state == "search"
        title: i18n.tr("Search")
        leadingActionBar {
            actions: [
                Action {
                    id: closePageAction
                    text: i18n.tr("Close")
                    iconName: "back"
                    onTriggered: {
                        homePage.state = "default"
                    }
                }

            ]
        }
            trailingActionBar {
                actions: [
                    Action {
                        iconName: "filter"
                        text: "filter"
                    }
               ]
               numberOfSlots: 1
            }


    }


            ListItem.Header {
                anchors.top: grido.bottom
                id: headerPopularWallpaper
                text: "<font color=\"#ffffff\">"+i18n.tr("Newest")+"</font>"

            }



    ListView {
        id: wallpaper
        model: jsonwallpaper.model
        anchors { left: parent.left; right: parent.right; top: headerPopularWallpaper.bottom; }
        leftMargin: units.gu(1)
        rightMargin: units.gu(1)
        clip: true
        height: units.gu(30)
        visible: count > 0
        spacing: units.gu(1)
        orientation: ListView.Horizontal
        delegate: UbuntuShape {
            anchors.verticalCenter: parent.verticalCenter
            height: units.gu(30)
            width: units.gu(18)
            sourceFillMode: UbuntuShape.PreserveAspectCrop
            source: Image {
                id: screenshotWallpaper
                    Component.onCompleted: if(index == 0) {
                        secondcarrousel.source = Qt.resolvedUrl(model.url_thumb);
                    }
                source: Qt.resolvedUrl(model.url_thumb)
                smooth: true
                antialiasing: true
            }

            AbstractButton {
                id: wallpaperButton
                anchors.fill: parent
                onClicked: pageStack.push(Qt.resolvedUrl("WallpaperView.qml"), {"idWallpaper": model.id});
            }
        }

                        Component.onCompleted: {
                            activity.running = false
                        }
    }

            JSONListModel {
                id: jsonwallpaper
                source: "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=newest&page=1&info_level=2"
                query: "$[*]"
            }


            ListItem.Header {
                id: headerNewWallpaper
                text: "<font color=\"#ffffff\">"+i18n.tr("Random")+"</font>"
                anchors { top: wallpaper.bottom; }
            }



  ListView {
        id: wallpaperView
        model: jsonwallpaperx.model
        anchors { left: parent.left; right: parent.right; top: headerNewWallpaper.bottom; }
        leftMargin: units.gu(1)
        rightMargin: units.gu(1)
        clip: true
        height: units.gu(28)
        visible: count > 0
        spacing: units.gu(1)
        orientation: ListView.Horizontal
        delegate: UbuntuShape {
            anchors.verticalCenter: parent.verticalCenter
            height:units.gu(28)
            width: units.gu(17)
            sourceFillMode: UbuntuShape.PreserveAspectCrop
            source: Image {
                id: screenshotWallpaper
                    Component.onCompleted: if(index == 0) {
                        firstcarrousel.source = Qt.resolvedUrl(model.url_thumb);
                    }
                source: Qt.resolvedUrl(model.url_thumb)
                smooth: true
                antialiasing: true
            }

            AbstractButton {
                id: wallpaperButton
                anchors.fill: parent
                onClicked: pageStack.push(Qt.resolvedUrl("WallpaperView.qml"), {"idWallpaper": model.id});
            }
        }


   }
            JSONListModel {
                id: jsonwallpaperx
                source: "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=random&page=1&info_level=2"
                query: "$..[:30]"
            }

            Grid {
            id: grido
            anchors.top: defaultHeader.bottom; anchors.horizontalCenter: defaultHeader.horizontalCenter;

            spacing: 7
            columns: 4

            Button {
              text: "#popular"


              color: "#dc143c"

              onClicked: {
                      pageStack.push(Qt.resolvedUrl("popular.qml"));
              }
              }

           Button {
              text: "#favorites"


              color: "#b0c4de"

              onClicked: {
                      pageStack.push(Qt.resolvedUrl("favorites.qml"));
              }
              }

           Button {
              text: "#views"


              color: "#ffd700"

              onClicked: {
                      pageStack.push(Qt.resolvedUrl("views.qml"));
              }
              }

           Button {
              text: "#rated"


              color: "#90ee90"

              onClicked: {
                      pageStack.push(Qt.resolvedUrl("rated.qml"));
              }
              }

        }


Connections {
    target: Terminalaccess
    //onNewOutputLineAvailable: {textoutput.append(Terminalaccess.getNewOutput())}
    //onNewErrorLineAvailable: {textoutput.append(Terminalaccess.getNewError())}
    onNeedSudoPassword: {PopupUtils.open(diag)}
    //onFinished: {Terminalaccess.run("sudo -S ls /")}
}
    }
/*
    Component.onCompleted: {
    Terminalaccess.run("sudo -S whoami")
    //returntext.text = Terminalaccess.outputUntilEnd()
    }
*/
}
}
