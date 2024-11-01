#include "zedprocess.h"
#include <QJsonArray>

ZedProcess::ZedProcess(TcpHandler *tcp_, ImageProvider *zedProvider_): tcp(tcp_), zedProvider(zedProvider_)
{

    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &ZedProcess::parseMsg);
    QObject::connect(this, &ZedProcess::ballHmaxChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::ballHminChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::ballSmaxChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::ballSminChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::ballVmaxChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::ballVminChanged, this, &ZedProcess::sendConfig);
    QObject::connect(this, &ZedProcess::useMagentaChanged, this, &ZedProcess::sendConfig);


    ballVec.reserve(6);
    ballVec.push_back(&m_ballHmin);
    ballVec.push_back(&m_ballHmax);
    ballVec.push_back(&m_ballSmin);
    ballVec.push_back(&m_ballSmax);
    ballVec.push_back(&m_ballVmin);
    ballVec.push_back(&m_ballVmax);

}


void ZedProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "zed")
        {
            auto const encoded =  obj["pixels"].toString().toLatin1();
            QImage image_tmp;
            image_tmp.loadFromData(QByteArray::fromBase64(encoded), "PNG");
            zedProvider->setImage(image_tmp);

        }

    if(obj.contains("topic"))
        if(obj["topic"].toString() == "zedConfig")
        {
            auto arrBall = obj["ball"].toArray();


            if(arrBall.size() == 6){
                setBallHmin(arrBall.at(0).toInt());
                setBallHmax(arrBall.at(1).toInt());
                setBallSmin(arrBall.at(2).toInt());
                setBallSmax(arrBall.at(3).toInt());
                setBallVmin(arrBall.at(4).toInt());
                setBallVmax(arrBall.at(5).toInt());

                setUseMagenta(obj["mgnt"].toBool());

                emit configUpdated();
            }

    }
}

const QImage &ZedProcess::image() const
{
    return m_image;
}

void ZedProcess::setImage(const QImage &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}

int ZedProcess::ballHmin() const
{
    return m_ballHmin;
}

void ZedProcess::setBallHmin(int newBallHmin)
{
    if (m_ballHmin == newBallHmin)
        return;
    m_ballHmin = newBallHmin;
    emit ballHminChanged();
}

int ZedProcess::ballHmax() const
{
    return m_ballHmax;
}

void ZedProcess::setBallHmax(int newBallHmax)
{
    if (m_ballHmax == newBallHmax)
        return;
    m_ballHmax = newBallHmax;
    emit ballHmaxChanged();
}

int ZedProcess::ballSmin() const
{
    return m_ballSmin;
}

void ZedProcess::setBallSmin(int newBallSmin)
{
    if (m_ballSmin == newBallSmin)
        return;
    m_ballSmin = newBallSmin;
    emit ballSminChanged();
}

int ZedProcess::ballSmax() const
{
    return m_ballSmax;
}

void ZedProcess::setBallSmax(int newBallSmax)
{
    if (m_ballSmax == newBallSmax)
        return;
    m_ballSmax = newBallSmax;
    emit ballSmaxChanged();
}

int ZedProcess::ballVmin() const
{
    return m_ballVmin;
}

void ZedProcess::setBallVmin(int newBallVmin)
{
    if (m_ballVmin == newBallVmin)
        return;
    m_ballVmin = newBallVmin;
    emit ballVminChanged();
}

int ZedProcess::ballVmax() const
{
    return m_ballVmax;
}

void ZedProcess::setBallVmax(int newBallVmax)
{
    if (m_ballVmax == newBallVmax)
        return;
    m_ballVmax = newBallVmax;
    emit ballVmaxChanged();
}

void ZedProcess::requestConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "reqZedConfig";
    tcp->send(jsonObject);
}


void ZedProcess::sendConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "zedConfig";

    QJsonArray ballArray;
    for (auto b : ballVec)
        ballArray.append(*b);
    jsonObject["ball"] = ballArray;
    jsonObject["mgnt"] = useMagenta();

    this->tcp->send(jsonObject);

}

void ZedProcess::saveConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "saveZedConfig";
    this->tcp->send(jsonObject);
}

void ZedProcess::record()
{
    static bool rec = false;
    QJsonObject jsonObject;
    jsonObject["topic"] = "recordZed";
    rec = !rec;
    jsonObject["record"] = rec;
    this->tcp->send(jsonObject);
}

void ZedProcess::play()
{
    static bool play = false;
    QJsonObject jsonObject;
    jsonObject["topic"] = "playZed";
    play = !play;
    jsonObject["play"] = play;
    this->tcp->send(jsonObject);
}

bool ZedProcess::useMagenta() const
{
    return m_useMagenta;
}

void ZedProcess::setUseMagenta(bool newUseMagenta)
{
    if (m_useMagenta == newUseMagenta)
        return;
    m_useMagenta = newUseMagenta;
    emit useMagentaChanged();
}
