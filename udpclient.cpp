#include "udpclient.h"

udpclient::udpclient(QObject *parent)
    : QObject{parent}
{
    port = 2333;
    udpSocket = new QUdpSocket();
    udpSocket->bind(QHostAddress::AnyIPv4, port, QUdpSocket::ShareAddress);
    udpSocket->joinMulticastGroup(QHostAddress("239.255.43.21"));
//        udpSocket->setSocketOption(QAbstractSocket::MulticastLoopbackOption, 1); // 1 to enable loopback
//        timer = new QTimer();
//    connect(timer, SIGNAL(timeout()), this, SLOT(send()));
//    timer->start(10);


    connect(udpSocket, SIGNAL(readyRead()), this, SLOT(processPendingDatagrams()));
    setMessage("tes");

    jsonObject["name"] = "John";
        jsonObject["age"] = 30;
        jsonObject["city"] = "New York";
}

void udpclient::send(){
    static int x = 0;
    x++;
     QJsonDocument jsonDoc(jsonObject);
    QByteArray datagram = jsonDoc.toJson(QJsonDocument::Compact);
       udpSocket->writeDatagram(datagram.data(), datagram.size(), QHostAddress("239.255.43.21"), port);
       setMessage(QString::number(x));

}
void udpclient::processPendingDatagrams()
{
    while(udpSocket->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(udpSocket->pendingDatagramSize());
        QHostAddress sender;
        quint16 sender_port;
        udpSocket->readDatagram(datagram.data(), datagram.size(), &sender, &sender_port);
        qDebug() << "Received datagram:" << datagram << "from" << sender.toString() << ":" << sender_port;
        setMessage(datagram);
    }
}

const QString &udpclient::message() const
{
    return m_message;
}

void udpclient::setMessage(const QString &newMessage)
{
    if (m_message == newMessage)
        return;
    m_message = newMessage;
    emit messageChanged();
}
