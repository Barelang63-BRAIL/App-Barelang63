#include "basestationprocess.h"

BasestationProcess::BasestationProcess(TcpHandler *tcp_):tcp(tcp_)
{
    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &BasestationProcess::parseMsg);
}

void BasestationProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "arduino")
        {

        }
}
