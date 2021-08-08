#ifndef APPINFO_H
#define APPINFO_H

#include <QObject>
#include <QString>
#include <QMap>

class AppInfo: public QObject {
	Q_OBJECT

public:
	~AppInfo() = default;
	AppInfo(const QString& infos = "");
	Q_INVOKABLE QString getProp(const QString& key);
protected:
	QMap<QString, QString> _appinfo;	
};

#endif
