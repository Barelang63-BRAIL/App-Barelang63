#include "stmprocess.h"

StmProcess::StmProcess(TcpHandler *tcp_):tcp(tcp_)
{
    timer = new QTimer;
    QObject::connect(timer, &QTimer::timeout, this, &StmProcess::sendData);

    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &StmProcess::parseMsg);

}

void StmProcess::sendData()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "twist";
    jsonObject["x"] = m_input_x;
    jsonObject["y"] = m_input_y;
    jsonObject["a"] = m_input_a;
    tcp->send(jsonObject);
}

double StmProcess::input_x() const
{
    return m_input_x;
}

void StmProcess::setInput_x(double newInput_x)
{
    if (qFuzzyCompare(m_input_x, newInput_x))
        return;
    m_input_x = newInput_x;
    emit input_xChanged();
}

double StmProcess::input_y() const
{
    return m_input_y;
}

void StmProcess::setInput_y(double newInput_y)
{
    if (qFuzzyCompare(m_input_y, newInput_y))
        return;
    m_input_y = newInput_y;
    emit input_yChanged();
}

double StmProcess::input_a() const
{
    return m_input_a;
}

void StmProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "stm")
        {
            setX_pos(obj["x"].toString().toDouble());
            setY_pos(obj["y"].toString().toDouble());
            setA_pos(obj["a"].toString().toDouble());

            setWheel1(obj["w1"].toString().toDouble());
            setWheel2( obj["w2"].toString().toDouble());
            setWheel3( obj["w3"].toString().toDouble());

        }
}

void StmProcess::setInput_a(double newInput_a)
{
    if (qFuzzyCompare(m_input_a, newInput_a))
        return;
    m_input_a = newInput_a;
    emit input_aChanged();
}

void StmProcess::setOpened(bool opened)
{
    if(opened)
    {
        timer->start(60);
        return;
    }

    m_input_a = m_input_x = m_input_y = 0;
    sendData();
    timer->stop();

}

double StmProcess::x_pos() const
{
    return m_x_pos;
}

void StmProcess::setX_pos(double newX_pos)
{
    if (qFuzzyCompare(m_x_pos, newX_pos))
        return;
    m_x_pos = newX_pos;
    emit x_posChanged();
}

double StmProcess::y_pos() const
{
    return m_y_pos;
}

void StmProcess::setY_pos(double newY_pos)
{
    if (qFuzzyCompare(m_y_pos, newY_pos))
        return;
    m_y_pos = newY_pos;
    emit y_posChanged();
}

double StmProcess::a_pos() const
{
    return m_a_pos;
}

void StmProcess::setA_pos(double newA_pos)
{
    if (qFuzzyCompare(m_a_pos, newA_pos))
        return;
    m_a_pos = newA_pos;
    emit a_posChanged();
}


double StmProcess::wheel1() const
{
    return m_wheel1;
}

void StmProcess::setWheel1(double newWheel1)
{
    if (qFuzzyCompare(m_wheel1, newWheel1))
        return;
    m_wheel1 = newWheel1;
    emit wheel1Changed();
}

double StmProcess::wheel2() const
{
    return m_wheel2;
}

void StmProcess::setWheel2(double newWheel2)
{
    if (qFuzzyCompare(m_wheel2, newWheel2))
        return;
    m_wheel2 = newWheel2;
    emit wheel2Changed();
}

double StmProcess::wheel3() const
{
    return m_wheel3;
}

void StmProcess::setWheel3(double newWheel3)
{
    if (qFuzzyCompare(m_wheel3, newWheel3))
        return;
    m_wheel3 = newWheel3;
    emit wheel3Changed();
}
