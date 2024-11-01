#ifndef ARDUINOPROCESS_H
#define ARDUINOPROCESS_H


#include <QObject>
#include <QJsonObject>

#include "tcphandler.h"
class ArduinoProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int leftPotentio READ leftPotentio WRITE setLeftPotentio NOTIFY leftPotentioChanged)
    Q_PROPERTY(int rightPotentio READ rightPotentio WRITE setRightPotentio NOTIFY rightPotentioChanged)


public:
    ArduinoProcess(TcpHandler *tcp_);
    void parseMsg();

public:

    int leftPotentio() const;
    void setLeftPotentio(int newLeftPotentio);

    int rightPotentio() const;
    void setRightPotentio(int newRightPotentio);

public slots:
    void sendJsonDribbler();
    void setDribblerOnOff(bool onoff);
    void setLeftDribbler(int val);
    void setRightDribbler(int val);
    void setKick(bool high, int pwm);
    void setFrame(bool left, bool right, bool up);

signals:
    void leftPotentioChanged();
    void rightPotentioChanged();

private:
    int m_leftPotentio;
    int m_rightPotentio;
    QJsonObject jsonDribbler;
    QTimer *dribblerTimer;
    TcpHandler *tcp;

};

#endif // ARDUINOPROCESS_H
