#include "tcphandler.h"
#include <QDebug>

TcpHandler::TcpHandler()
{
    server = new QTcpServer();
    socket = new QTcpSocket();

    if(not server->listen(QHostAddress::Any, 4747))
    {
        qDebug() << "Failed start server" << server->errorString();
    }
    qDebug() <<"Server Started";
    QObject::connect(server, SIGNAL(newConnection()), this, SLOT(connectToServer()));

}

void TcpHandler::send(const QJsonObject &json)
{
    QJsonDocument doc(json);
    QByteArray data = doc.toJson(QJsonDocument::Compact);
    socket->write(data);
    socket->flush();
}

void TcpHandler::readMsg()
{
    QByteArray data =  socket->readAll();
    //    qDebug() <<data;
    this->parseConcatenatedJson(data);
//    if(not parsedJson.isEmpty())
//        setJsonMsg(parsedJson);

    //    qDebug()<< m_jsonMsg;

}


void TcpHandler::connectToServer()
{
    socket = server->nextPendingConnection();
    QObject::connect(socket, &QTcpSocket::readyRead, this, &TcpHandler::readMsg);

}

const QJsonObject &TcpHandler::jsonMsg() const
{
    return m_jsonMsg;
}

void TcpHandler::setJsonMsg(const QJsonObject &newJsonMsg)
{
    if (m_jsonMsg == newJsonMsg)
        return;
    m_jsonMsg = newJsonMsg;
    emit jsonMsgChanged();
}

QJsonObject TcpHandler::mergeJsonObjects(const QJsonObject& obj1, const QJsonObject& obj2) {
    QJsonObject mergedObject = obj1;
    for (const QString& key : obj2.keys()) {
        mergedObject[key] = obj2.value(key);
    }
    return mergedObject;
}

void TcpHandler::parseConcatenatedJson(const QString &concatenatedJson)
{

//    QJsonObject mergedJsonObject;
    static QString tmp;
    tmp.append(concatenatedJson);
    int currentIndex = tmp.indexOf('{');
    while (currentIndex != -1) {
        int endIndex = tmp.indexOf('}', currentIndex);
        if (endIndex == -1) {
//            qWarning() << "Invalid JSON format: Missing closing brace.";
            break;
        }
        QString currentJsonString = tmp.mid(currentIndex, endIndex - currentIndex + 1);
        QJsonDocument jsonDoc = QJsonDocument::fromJson(currentJsonString.toUtf8());
        if (!jsonDoc.isNull() && jsonDoc.isObject()) {
            QJsonObject jsonObject = jsonDoc.object();
            setJsonMsg(jsonObject);
//            mergedJsonObject = mergeJsonObjects(mergedJsonObject, jsonObject);
        } else {
            qWarning() << "Failed to parse JSON object:" << currentJsonString;
        }
        tmp.remove(currentIndex, endIndex + 1);

        currentIndex = tmp.indexOf('{');
    }
}
