#ifndef BASESTATIONPROCESS_H
#define BASESTATIONPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "tcphandler.h"
class BasestationProcess : public QObject
{
    Q_OBJECT
public:
    BasestationProcess(TcpHandler *tcp);
    void parseMsg();

private:
    TcpHandler *tcp;

};

#endif // BASESTATIONPROCESS_H
