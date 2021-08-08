#include "appinfo.h"
#include <QDebug>

AppInfo::AppInfo(const QString& infos)
{
	foreach (const QString& line , infos.split("\n")) {
		if(line != "") {
			QStringList keyvalue = line.split("="); 
			_appinfo.insert(keyvalue.first(),(keyvalue.size() > 1) ? keyvalue.at(1):"");
		}
	}
	//qDebug() << "keys:" <<_appinfo.keys() << "values" << _appinfo.values();
	
}
QString AppInfo::getProp(const QString& key)
{
	return _appinfo.value(key);
}
