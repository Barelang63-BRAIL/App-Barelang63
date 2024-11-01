#ifndef PROGRAMRUNNING_H
#define PROGRAMRUNNING_H

#include <QObject>
#include <QJsonObject>
#include <QJsonArray>

#include "tcphandler.h"
class ProgramRunning : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool stm READ stm WRITE setStm NOTIFY stmChanged)
    Q_PROPERTY(bool arduino READ arduino WRITE setArduino NOTIFY arduinoChanged)
    Q_PROPERTY(bool basestation READ basestation WRITE setBasestation NOTIFY basestationChanged)
    Q_PROPERTY(bool strategy READ strategy WRITE setStrategy NOTIFY strategyChanged)
    Q_PROPERTY(bool omni READ omni WRITE setOmni NOTIFY omniChanged)
    Q_PROPERTY(bool amcl READ amcl WRITE setAmcl NOTIFY amclChanged)
    Q_PROPERTY(bool zed READ zed WRITE setZed NOTIFY zedChanged)
    Q_PROPERTY(bool heartBeat READ heartBeat WRITE setHeartBeat NOTIFY heartBeatChanged)
    Q_PROPERTY(bool razor READ razor WRITE setRazor NOTIFY razorChanged)



public:
    explicit ProgramRunning(TcpHandler* tcp_,QObject *parent = nullptr);
    void parseMsg();


    bool stm() const;
    void setStm(bool newStm);

    bool arduino() const;
    void setArduino(bool newArduino);

    bool basestation() const;
    void setBasestation(bool newBasestation);

    bool strategy() const;
    void setStrategy(bool newStrategy);

    bool omni() const;
    void setOmni(bool newOmni);

    bool amcl() const;
    void setAmcl(bool newAmcl);

    bool zed() const;
    void setZed(bool newZed);

    bool heartBeat() const;
    void setHeartBeat(bool newHeartBeat);

    bool razor() const;
    void setRazor(bool newRazor);

private:
    TcpHandler *tcp;

    bool m_stm;

    bool m_arduino;

    bool m_basestation;

    bool m_strategy;

    bool m_omni;

    bool m_amcl;

    bool m_zed;

    bool m_heartBeat;

    bool m_razor;

signals:

    void stmChanged();
    void arduinoChanged();
    void basestationChanged();
    void strategyChanged();
    void omniChanged();
    void amclChanged();
    void zedChanged();
    void heartBeatChanged();
    void razorChanged();
};

#endif // PROGRAMRUNNING_H
