#include "arduinoprocess.h"

ArduinoProcess::ArduinoProcess(TcpHandler *tcp_): tcp(tcp_)
{
    dribblerTimer = new QTimer;
    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &ArduinoProcess::parseMsg);
    jsonDribbler["topic"] = "Dribbler";
    jsonDribbler["lDribbler"] = 0;
    jsonDribbler["rDribbler"] = 0;

    QObject::connect(dribblerTimer, &QTimer::timeout, this, &ArduinoProcess::sendJsonDribbler);


}

void ArduinoProcess::sendJsonDribbler(){
    tcp->send(jsonDribbler);
}
void ArduinoProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "arduino")
        {
            setLeftPotentio(obj["lPotentio"].toInt());
            setRightPotentio(obj["rPotentio"].toInt());
        }
}

void ArduinoProcess::setDribblerOnOff(bool onoff)
{
    if(not onoff)
    {
        setLeftDribbler(0);
        setRightDribbler(0);
        dribblerTimer->stop();
        return;
    }

    dribblerTimer->start(50);

}

void ArduinoProcess::setLeftDribbler(int val)
{
    jsonDribbler["lDribbler"] = val;
}

void ArduinoProcess::setRightDribbler(int val)
{
    jsonDribbler["rDribbler"] = val;
}

void ArduinoProcess::setKick(bool high, int pwm)
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "kick";
    jsonObject["high"] = high;
    jsonObject["pwm"] = pwm;
    tcp->send(jsonObject);
}

void ArduinoProcess::setFrame(bool left, bool right, bool up)
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "frame";
    jsonObject["l"] = left;
    jsonObject["r"] = right;
    jsonObject["u"] = up;
    tcp->send(jsonObject);
}

int ArduinoProcess::leftPotentio() const
{
    return m_leftPotentio;
}

void ArduinoProcess::setLeftPotentio(int newLeftPotentio)
{
    if (m_leftPotentio == newLeftPotentio)
        return;
    m_leftPotentio = newLeftPotentio;
    emit leftPotentioChanged();
}

int ArduinoProcess::rightPotentio() const
{
    return m_rightPotentio;
}

void ArduinoProcess::setRightPotentio(int newRightPotentio)
{
    if (m_rightPotentio == newRightPotentio)
        return;
    m_rightPotentio = newRightPotentio;
    emit rightPotentioChanged();
}
