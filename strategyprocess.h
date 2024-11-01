#ifndef STRATEGYPROCESS_H
#define STRATEGYPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "tcphandler.h"
class StrategyProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int robot_id READ robot_id WRITE setRobot_id NOTIFY robot_idChanged)
    Q_PROPERTY(bool robot_running READ robot_running WRITE setRobot_running NOTIFY robot_runningChanged)
    Q_PROPERTY(double robot_x READ robot_x WRITE setRobot_x NOTIFY robot_xChanged)
    Q_PROPERTY(double robot_y READ robot_y WRITE setRobot_y NOTIFY robot_yChanged)
    Q_PROPERTY(double robot_a READ robot_a WRITE setRobot_a NOTIFY robot_aChanged)
    Q_PROPERTY(double ball_x READ ball_x WRITE setBall_x NOTIFY ball_xChanged)
    Q_PROPERTY(double ball_y READ ball_y WRITE setBall_y NOTIFY ball_yChanged)
    Q_PROPERTY(bool ball_visible READ ball_visible WRITE setBall_visible NOTIFY ball_visibleChanged)

public:
    explicit StrategyProcess(TcpHandler *tcp_, QObject *parent = nullptr);
    void parseMsg();

    double robot_a() const;
    void setRobot_a(double newRobot_a);

    double robot_x() const;
    void setRobot_x(double newRobot_x);

    double robot_y() const;
    void setRobot_y(double newRobot_y);

    double ball_x() const;
    void setBall_x(double newBall_x);

    double ball_y() const;
    void setBall_y(double newBall_y);


    bool ball_visible() const;
    void setBall_visible(bool newBall_visible);

    int robot_id() const;
    void setRobot_id(int newRobot_id);

    bool robot_running() const;
    void setRobot_running(bool newRobot_running);

signals:

    void robot_aChanged();

    void robot_xChanged();

    void robot_yChanged();

    void ball_xChanged();

    void ball_yChanged();


    void ball_visibleChanged();

    void robot_idChanged();

    void robot_runningChanged();

private:
    TcpHandler *tcp;

    double m_robot_a;
    double m_robot_x;
    double m_robot_y;
    double m_ball_x;
    double m_ball_y;
    bool m_ball_visible;
    int m_robot_id;
    bool m_robot_running;
};

#endif // STRATEGYPROCESS_H
