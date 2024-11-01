#ifndef SCREENPROCESS_H
#define SCREENPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "tcphandler.h"

class ScreenProcess : public QObject
{
    Q_OBJECT
public:
    ScreenProcess();
    TcpHandler *tcp;


public slots:
    void runProcess(int index, QString mode);
    void setPageActive(int page);
};

#endif // SCREENPROCESS_H
