#ifndef TCPHANDLER_H
#define TCPHANDLER_H

#include <QObject>
#include <QTcpSocket>
#include <QTcpServer>
#include <QTimer>
#include <QJsonObject>
#include <QJsonDocument>
#include <QMap>
class TcpHandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QJsonObject jsonMsg READ jsonMsg WRITE setJsonMsg NOTIFY jsonMsgChanged)

public:
    TcpHandler();
    void send(const QJsonObject &json);
    void read();

    const QString &message() const;

    const QJsonObject &jsonMsg() const;
    void setJsonMsg(const QJsonObject &newJsonMsg);
private:
    QJsonObject mergeJsonObjects(const QJsonObject& obj1, const QJsonObject& obj2);
    void parseConcatenatedJson(const QString &concatenatedJson);
private:
    QTcpSocket *socket;
    QTcpServer *server;
    QTimer *timer;

    QJsonObject m_jsonMsg;

public slots:
    void readMsg();
    void connectToServer();
signals:
    void jsonMsgChanged();
};

#endif // TCPHANDLER_H
