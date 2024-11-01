#ifndef UDPCLIENT_H
#define UDPCLIENT_H

#include <QObject>
#include <QUdpSocket>
#include <felgoapplication.h>
#include <QTimer>

#include <QJsonObject>
#include <QJsonDocument>
class udpclient : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)
public:
    explicit udpclient(QObject *parent = nullptr);

    const QString &message() const;
    void setMessage(const QString &newMessage);

private:
    QUdpSocket *udpSocket;
    qint16 port;
    QString u_name;
    QString u_ipAddr;

    QTimer *timer;
    QJsonObject jsonObject;



    QString m_message;

private slots:
    void send();
    void processPendingDatagrams();

signals:

    void messageChanged();
};

#endif // UDPCLIENT_H
