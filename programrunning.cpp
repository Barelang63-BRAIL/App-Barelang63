#include "programrunning.h"

ProgramRunning::ProgramRunning(TcpHandler*tcp_, QObject *parent)
    : QObject{parent}, tcp(tcp_)
{
    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &ProgramRunning::parseMsg);

}

void ProgramRunning::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("topic"))
        if(obj["topic"].toString() == "runningProgram")
        {
            QJsonArray arr = obj["prog"].toArray();
            setZed(arr.at(0).toBool());
            setAmcl(arr.at(1).toBool());
            setArduino(arr.at(2).toBool());
            setOmni(arr.at(3).toBool());
            setBasestation(arr.at(4).toBool());
            setStrategy(arr.at(5).toBool());
            setStm(arr.at(6).toBool());
            setHeartBeat(arr.at(7).toBool());
            setRazor(arr.at(8).toBool());
        }
}

bool ProgramRunning::stm() const
{
    return m_stm;
}

void ProgramRunning::setStm(bool newStm)
{
    if (m_stm == newStm)
        return;
    m_stm = newStm;
    emit stmChanged();
}

bool ProgramRunning::arduino() const
{
    return m_arduino;
}

void ProgramRunning::setArduino(bool newArduino)
{
    if (m_arduino == newArduino)
        return;
    m_arduino = newArduino;
    emit arduinoChanged();
}

bool ProgramRunning::basestation() const
{
    return m_basestation;
}

void ProgramRunning::setBasestation(bool newBasestation)
{
    if (m_basestation == newBasestation)
        return;
    m_basestation = newBasestation;
    emit basestationChanged();
}

bool ProgramRunning::strategy() const
{
    return m_strategy;
}

void ProgramRunning::setStrategy(bool newStrategy)
{
    if (m_strategy == newStrategy)
        return;
    m_strategy = newStrategy;
    emit strategyChanged();
}

bool ProgramRunning::omni() const
{
    return m_omni;
}

void ProgramRunning::setOmni(bool newOmni)
{
    if (m_omni == newOmni)
        return;
    m_omni = newOmni;
    emit omniChanged();
}

bool ProgramRunning::amcl() const
{
    return m_amcl;
}

void ProgramRunning::setAmcl(bool newAmcl)
{
    if (m_amcl == newAmcl)
        return;
    m_amcl = newAmcl;
    emit amclChanged();
}

bool ProgramRunning::zed() const
{
    return m_zed;
}

void ProgramRunning::setZed(bool newZed)
{
    if (m_zed == newZed)
        return;
    m_zed = newZed;
    emit zedChanged();
}

bool ProgramRunning::heartBeat() const
{
    return m_heartBeat;
}

void ProgramRunning::setHeartBeat(bool newHeartBeat)
{
    if (m_heartBeat == newHeartBeat)
        return;
    m_heartBeat = newHeartBeat;
    emit heartBeatChanged();
}

bool ProgramRunning::razor() const
{
    return m_razor;
}

void ProgramRunning::setRazor(bool newRazor)
{
    if (m_razor == newRazor)
        return;
    m_razor = newRazor;
    emit razorChanged();
}
