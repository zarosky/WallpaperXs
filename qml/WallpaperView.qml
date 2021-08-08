import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3
import Terminalaccess 1.0
import MySettings 1.0
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 0.1
import "components"

Page {
    id: iconsViewPage

        header: state == "default" ? defaultHeader : searchPageHeader
        state: "default"
        
        PageHeader {
            id: defaultHeader                
            title: "Apply Wallpaper"

            StyleHints {
               foregroundColor: UbuntuColors.black
               backgroundColor: UbuntuColors.indianred
               dividerColor: UbuntuColors.orange
             }
                

        }
        

    property string idWallpaper:"";
    
    Rectangle {
        id:main
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: iconsViewPage.header.bottom
        }
        color: "#111111"

        Flickable {
            id: flickable
            anchors.fill: parent
            contentHeight: wallpaperListView.height
            flickableDirection: Flickable.VerticalFlick
            clip: true
                

ListView {
        id: wallpaperListView
        anchors.fill: parent
        model: jsonwallpaper.model
            
            JSONListModel {
                id: jsonwallpaper
                source: "https://wall.alphacoders.com/api2.0/get.php?auth=2795f44dad7746122baaa83d01db8541&method=wallpaper_info&id="+idWallpaper
                query: "$[*]"
            }  
    
            delegate: Column {
                id: iconsViewColumn
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }

                Rectangle {
                    id: headerpicture
                    width: parent.width;
                    height: units.gu(46)
                    color: "#111111"

                    Image {
                        id : picturebackgroundtop;
                        anchors { left: parent.left; right: parent.right }
                        source:  Qt.resolvedUrl(model.url_thumb)
                        width: units.gu(20);
                        height: units.gu(59)
                        fillMode: Image.PreserveAspectCrop

                    }

                    Image {
                        id : productImage;
                        fillMode: Image.PreserveAspectCrop
                        visible: false // Do not forget to make original pic insisible
                    }


                    Rectangle {
                        id: mask
                        anchors.right: parent.right; anchors.verticalCenter: picturebackgroundtop.bottom; anchors.rightMargin: 0;
                        width: units.gu(10)
                        height: units.gu(8)
                        color: "#ff4500"
                        radius: 20
                        clip: true
                        visible: true

                        Icon {
                            id: chooseIcon
                            name: "import-image"
                            anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter; anchors.rightMargin: 2;
                            width: units.gu(5)
                            height: units.gu(5)
                            color: "#000000"

                        }



                       Component {
                            id: waitDialog
                            Dialog {
                                id: waitDialogue

                                text: i18n.tr("Wait please")
                                    
                                ProgressBar {
                                    indeterminate: true
                                }

                            }
                        }                        
                        
                       Component {
                            id: confirmDialog
                            Dialog {
                                id: confirmDialogue

                                title: i18n.tr("Apply Wallpaper")
                                text: i18n.tr("Do you want to apply the wallpaper now?")

                                Button{
                                    text: i18n.tr("Cancel")
                                    onClicked: PopupUtils.close(confirmDialogue);
                                }

                                Button{
                                    text: i18n.tr("Apply Wallpaper")
                                    color: theme.palette.normal.negative
                                    onClicked: {
                                        Terminalaccess.run("wget -N -P /home/phablet/Pictures/ "+model.url_image)
                                        Terminalaccess.outputUntilEnd()
                                        MySettings.setBackgroundFile("File:///home/phablet/Pictures/"+model.id+"."+model.file_type)
                                        PopupUtils.close(confirmDialogue);
                                    }
                                }
                            }
                        }
                        MouseArea {
                            anchors.fill: mask
                            onClicked: {
                                PopupUtils.open(confirmDialog);
                            }
                        }
                    }
                    
                    Column {
                        id: detailsItem
                        anchors.left: parent.left; anchors.verticalCenter: mask.bottom; anchors.rightMargin: 20;

                    Text {
                        text: model.name
                        color: "#FFFFFF"
                        font.pointSize: units.gu(1.5)
                    }

                    Text {
                        text: i18n.tr("by")+" "+model.user_name
                        color: "#AEA79F"
                    }

                    Text {
                        text: "<font color=\"#ffffff\">"+i18n.tr("categories")+": </font>"+model.category
                        color: "#AEA79F"
                    }
                }
                    

}
                
            } //Column
}

        } //flickable
    } //rectangle
} //page
