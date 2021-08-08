import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Components.ListItems 1.3 as ListItem
import Ubuntu.Components.Popups 1.0

Page {
    id: about

    header: PageHeader {
        title: i18n.tr("About");
   }


// ABOUT PAGE
    Rectangle {
        id:rect1
        anchors {
            fill: parent
            topMargin: units.gu(6)
        }
        color: "#111111"
Item {
      width: parent.width
      height: parent.height

    Column {
        anchors {
            left: parent.left
            right: parent.right
        }

        Item {
            width: parent.width
            height: units.gu(5)
            Label {
                text: "WallpaperXs"
                anchors.centerIn: parent
                fontSize: "x-large"
            }
        }

        Item {
            width: parent.width
            height: units.gu(14)

            UbuntuShape {
                radius: "medium"
                source: Image {
                    source: Qt.resolvedUrl("../assets/logo.png");
                }
                height: units.gu(12); width: height;
                anchors.centerIn: parent;


            } // shape
        }/// item

        Item {
            width: parent.width
            height: units.gu(4)
            Label {
                text: "Version 1.0.0"
                fontSize: "large"
                anchors.centerIn: parent

            }
        }

        Item {
            width: parent.width
            height: units.gu(2)
        }

        Item {
            width: parent.width
            height: thi.height + units.gu(2)
            Label {
                id: thi
                text: "This is a fork of<br />Custom Phablet Tools<br />Crédits of<br />Custom phablet tools<br />@Sconio<br />Jimmy Lejeune<br />@Yann<br />@Kazord<br />@Yohann<br />"
                anchors.centerIn: parent
                wrapMode: TextEdit.WrapAtWordBoundaryOrAnywhere
                horizontalAlignment: Text.AlignHCenter
                width: parent.width - units.gu(12)

}


    }
}
}
// ABOUT PAGE






}
}
