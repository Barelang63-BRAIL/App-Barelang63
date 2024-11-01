#include "strategyprocess.h"
#include <QtMath>

StrategyProcess::StrategyProcess(TcpHandler* tcp_, QObject *parent) : QObject{parent},
     tcp(tcp_)
{
    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &StrategyProcess::parseMsg);

}

void StrategyProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "strategy")
        {
            setRobot_id(obj["rId"].toInt());
            setRobot_running(obj["rRun"].toBool());
            setRobot_x(obj["rX"].toString().toDouble() * 100);// toDouble());
            setRobot_y(obj["rY"].toString().toDouble() * 100);
            setRobot_a(QString::number((obj["rA"].toString().toDouble()), 'f', 2).toDouble());

            setBall_x(obj["bX"].toString().toDouble() * 100);
            setBall_y(obj["bY"].toString().toDouble() * 100);
            setBall_visible(obj["bVisible"].toBool());
        }
}

double StrategyProcess::robot_a() const
{
    return m_robot_a;
}

void StrategyProcess::setRobot_a(double newRobot_a)
{
    if (qFuzzyCompare(m_robot_a, newRobot_a))
        return;
    m_robot_a = newRobot_a;
    emit robot_aChanged();
}

double StrategyProcess::robot_x() const
{
    return m_robot_x;
}

void StrategyProcess::setRobot_x(double newRobot_x)
{
    if (qFuzzyCompare(m_robot_x, newRobot_x))
        return;
    m_robot_x = newRobot_x;
    emit robot_xChanged();
}

double StrategyProcess::robot_y() const
{
    return m_robot_y;
}

void StrategyProcess::setRobot_y(double newRobot_y)
{
    if (qFuzzyCompare(m_robot_y, newRobot_y))
        return;
    m_robot_y = newRobot_y;
    emit robot_yChanged();
}

double StrategyProcess::ball_x() const
{
    return m_ball_x;
}

void StrategyProcess::setBall_x(double newBall_x)
{
    if (qFuzzyCompare(m_ball_x, newBall_x))
        return;
    m_ball_x = newBall_x;
    emit ball_xChanged();
}

double StrategyProcess::ball_y() const
{
    return m_ball_y;
}

void StrategyProcess::setBall_y(double newBall_y)
{
    if (qFuzzyCompare(m_ball_y, newBall_y))
        return;
    m_ball_y = newBall_y;
    emit ball_yChanged();
}


bool StrategyProcess::ball_visible() const
{
    return m_ball_visible;
}

void StrategyProcess::setBall_visible(bool newBall_visible)
{
    if (m_ball_visible == newBall_visible)
        return;
    m_ball_visible = newBall_visible;
    emit ball_visibleChanged();
}

int StrategyProcess::robot_id() const
{
    return m_robot_id;
}

void StrategyProcess::setRobot_id(int newRobot_id)
{
    if (m_robot_id == newRobot_id)
        return;
    m_robot_id = newRobot_id;
    emit robot_idChanged();
}

bool StrategyProcess::robot_running() const
{
    return m_robot_running;
}

void StrategyProcess::setRobot_running(bool newRobot_running)
{
    if (m_robot_running == newRobot_running)
        return;
    m_robot_running = newRobot_running;
    emit robot_runningChanged();
}
