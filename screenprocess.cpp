#include "screenprocess.h"
#include <QDebug>
ScreenProcess::ScreenProcess()
{

}

void ScreenProcess::runProcess(int index, QString mode)
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "runProcess";
    jsonObject["target"] = index;
    jsonObject["mode"] = mode;
    tcp->send(jsonObject);
}

void ScreenProcess::setPageActive(int page)
{
    QJsonObject jsonObject;
    jsonObject["page"] = page;
    tcp->send(jsonObject);
}

