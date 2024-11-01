#ifndef STMPROCESS_H
#define STMPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "tcphandler.h"
class StmProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double input_x READ input_x WRITE setInput_x NOTIFY input_xChanged)
    Q_PROPERTY(double input_y READ input_y WRITE setInput_y NOTIFY input_yChanged)
    Q_PROPERTY(double input_a READ input_a WRITE setInput_a NOTIFY input_aChanged)

    Q_PROPERTY(double x_pos READ x_pos WRITE setX_pos NOTIFY x_posChanged)
    Q_PROPERTY(double y_pos READ y_pos WRITE setY_pos NOTIFY y_posChanged)
    Q_PROPERTY(double a_pos READ a_pos WRITE setA_pos NOTIFY a_posChanged)

    Q_PROPERTY(double wheel1 READ wheel1 WRITE setWheel1 NOTIFY wheel1Changed)
    Q_PROPERTY(double wheel2 READ wheel2 WRITE setWheel2 NOTIFY wheel2Changed)
    Q_PROPERTY(double wheel3 READ wheel3 WRITE setWheel3 NOTIFY wheel3Changed)


public:
    StmProcess(TcpHandler *tcp_);
    TcpHandler *tcp;

    double input_x() const;
    double input_y() const;
    double input_a() const;

    void parseMsg();



    double x_pos() const;
    void setX_pos(double newX_pos);

    double y_pos() const;
    void setY_pos(double newY_pos);

    double a_pos() const;
    void setA_pos(double newA_pos);



    double wheel1() const;
    void setWheel1(double newWheel1);

    double wheel2() const;
    void setWheel2(double newWheel2);

    double wheel3() const;
    void setWheel3(double newWheel3);

public slots:
    void sendData();
    void setInput_x(double newInput_x);
    void setInput_y(double newInput_y);
    void setInput_a(double newInput_a);
    void setOpened(bool opened);


signals:
    void input_xChanged();
    void input_yChanged();
    void input_aChanged();

    void x_posChanged();

    void y_posChanged();

    void a_posChanged();


    void wheel1Changed();

    void wheel2Changed();

    void wheel3Changed();

private:
    QTimer *timer;
    double m_input_x;
    double m_input_y;
    double m_input_a;
    double m_x_pos;
    double m_y_pos;
    double m_a_pos;

    double m_wheel1;
    double m_wheel2;
    double m_wheel3;
};

#endif // STMPROCESS_H
