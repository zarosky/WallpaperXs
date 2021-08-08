#include <QString>
#include <QStringList>
#include <QFile>
#include <QDir>
#include <QTextStream>
#include <QDebug>
#include <QQmlListProperty>

#include "apphandler.h"
#include "appinfo.h"

#define APP_SYS_PATH "/usr/share/applications/"
#define APP_USR_PATH "/home/phablet/.local/share/applications/"

AppHandler::AppHandler() {
	loadAppsInfo();
}

QList<AppInfo*> AppHandler::getApps()
{
	return _appinfos;
}
QQmlListProperty<AppInfo> AppHandler::appsinfo()
{
	return QQmlListProperty<AppInfo>(this, 0, &AppHandler::count_appinfo, &AppHandler::at_appinfo);
}
void AppHandler::loadAppsInfo()
{
	loadAppsFromDir(APP_SYS_PATH);
	loadAppsFromDir(APP_USR_PATH);
}
void AppHandler::loadAppsFromDir(const QString& path)
{
	QDir dir(path);
	QStringList nameFilters;
	nameFilters << "*.desktop";
	QStringList fileList = dir.entryList(nameFilters, QDir::Files);
	foreach (const QString &fileName, fileList) {	
		QFile file(dir.filePath(fileName));
		file.open(QIODevice::ReadOnly | QIODevice::Text);
		QTextStream filestream(&file);
		filestream.setCodec("UTF-8");
		_appinfos.append(new AppInfo(filestream.readAll()));
	}
	qDebug() << _appinfos.size() << " desktop file read from " << path;
}
void AppHandler::append_appinfo(QQmlListProperty<AppInfo> *list, AppInfo *appinfo)
{
	AppHandler *appinfoBoard = qobject_cast<AppHandler*>(list->object);
	if(appinfo)
		appinfoBoard->_appinfos.append(appinfo);
}
AppInfo* AppHandler::at_appinfo(QQmlListProperty<AppInfo> *list, int index) {
	AppHandler *apphandler = qobject_cast<AppHandler*>(list->object);
	return apphandler->_appinfos.at(index);
}
int AppHandler::count_appinfo(QQmlListProperty<AppInfo> *list) {
	AppHandler *apphandler = qobject_cast<AppHandler*>(list->object);
	return apphandler->_appinfos.size();
}
