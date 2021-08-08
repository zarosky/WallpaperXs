#ifndef APPHANDLER_H
#define APPHANDLER_H

#include <QObject>
#include <QString>
#include <QQmlListProperty>
#include "appinfo.h"

class AppHandler: public QObject {
	Q_OBJECT
	Q_PROPERTY(QQmlListProperty<AppInfo> appsinfo READ appsinfo)

public:
	AppHandler();
	~AppHandler() = default;
	QList<AppInfo*> getApps();
	QQmlListProperty<AppInfo> appsinfo();

public slots:
signals:
protected:
	QList<AppInfo*> _appinfos;
private:
	void loadAppsFromDir(const QString& path);
	void loadAppsInfo();
	static void append_appinfo(QQmlListProperty<AppInfo> *list, AppInfo *appinfo);
	static AppInfo* at_appinfo(QQmlListProperty<AppInfo> *list, int at);
	static int count_appinfo(QQmlListProperty<AppInfo> *list);
};
#endif
