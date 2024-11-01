#include "omniprocess.h"
#include <QJsonArray>
OmniProcess::OmniProcess(TcpHandler *tcp_, ImageProvider *omniProvider_ ) : tcp(tcp_), omniProvider(omniProvider_)
{
    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &OmniProcess::parseMsg);

    this->greenVec.reserve(6);
    this->orangeVec.reserve(6);
    this->yellowVec.reserve(6);
    this->whiteVec.reserve(6);
    this->blackVec.reserve(6);

    this->greenVec.push_back(&m_greenHmin);
    this->greenVec.push_back(&m_greenHmax);
    this->greenVec.push_back(&m_greenSmin);
    this->greenVec.push_back(&m_greenSmax);
    this->greenVec.push_back(&m_greenVmin);
    this->greenVec.push_back(&m_greenVmax);

    this->orangeVec.push_back(&m_orangeHmin);
    this->orangeVec.push_back(&m_orangeHmax);
    this->orangeVec.push_back(&m_orangeSmin);
    this->orangeVec.push_back(&m_orangeSmax);
    this->orangeVec.push_back(&m_orangeVmin);
    this->orangeVec.push_back(&m_orangeVmax);

    this->yellowVec.push_back(&m_yellowHmin);
    this->yellowVec.push_back(&m_yellowHmax);
    this->yellowVec.push_back(&m_yellowSmin);
    this->yellowVec.push_back(&m_yellowSmax);
    this->yellowVec.push_back(&m_yellowVmin);
    this->yellowVec.push_back(&m_yellowVmax);

    this->whiteVec.push_back(&m_whiteHmin);
    this->whiteVec.push_back(&m_whiteHmax);
    this->whiteVec.push_back(&m_whiteSmin);
    this->whiteVec.push_back(&m_whiteSmax);
    this->whiteVec.push_back(&m_whiteVmin);
    this->whiteVec.push_back(&m_whiteVmax);

    this->blackVec.push_back(&m_blackHmin);
    this->blackVec.push_back(&m_blackHmax);
    this->blackVec.push_back(&m_blackSmin);
    this->blackVec.push_back(&m_blackSmax);
    this->blackVec.push_back(&m_blackVmin);
    this->blackVec.push_back(&m_blackVmax);




    connect(this, &OmniProcess::greenHminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::greenSminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::greenVminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::greenHmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::greenSmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::greenVmaxChanged, this, &OmniProcess::sendConfig);

    connect(this, &OmniProcess::orangeHminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::orangeSminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::orangeVminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::orangeHmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::orangeSmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::orangeVmaxChanged, this, &OmniProcess::sendConfig);

    connect(this, &OmniProcess::yellowHminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::yellowSminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::yellowVminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::yellowHmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::yellowSmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::yellowVmaxChanged, this, &OmniProcess::sendConfig);

    connect(this, &OmniProcess::whiteHminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::whiteSminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::whiteVminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::whiteHmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::whiteSmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::whiteVmaxChanged, this, &OmniProcess::sendConfig);

    connect(this, &OmniProcess::blackHminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::blackSminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::blackVminChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::blackHmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::blackSmaxChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::blackVmaxChanged, this, &OmniProcess::sendConfig);

    connect(this, &OmniProcess::brightnessChanged, this, &OmniProcess::sendConfig);
    connect(this, &OmniProcess::saturationChanged, this, &OmniProcess::sendConfig);




}

void OmniProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "omni")
        {
            auto const encoded =  obj["pixels"].toString().toLatin1();
            QImage image_tmp;
            image_tmp.loadFromData(QByteArray::fromBase64(encoded), "PNG");
            omniProvider->setImage(image_tmp);

        }
    if(obj.contains("topic"))
        if(obj["topic"].toString() == "omniConfig")
        {
            auto arrGreen = obj["green"].toArray();
            auto arrOrange = obj["orange"].toArray();
            auto arrWhite = obj["white"].toArray();
            auto arrYellow = obj["yellow"].toArray();
            auto arrBlack = obj["black"].toArray();

            setBrightness(obj["brightness"].toDouble());
            setSaturation(obj["saturation"].toDouble());

            if(arrGreen.size() == 6){
                setGreenHmin(arrGreen.at(0).toInt());
                setGreenHmax(arrGreen.at(1).toInt());
                setGreenSmin(arrGreen.at(2).toInt());
                setGreenSmax(arrGreen.at(3).toInt());
                setGreenVmin(arrGreen.at(4).toInt());
                setGreenVmax(arrGreen.at(5).toInt());
            }

            if(arrOrange.size() == 6){
                setOrangeHmin(arrOrange.at(0).toInt());
                setOrangeHmax(arrOrange.at(1).toInt());
                setOrangeSmin(arrOrange.at(2).toInt());
                setOrangeSmax(arrOrange.at(3).toInt());
                setOrangeVmin(arrOrange.at(4).toInt());
                setOrangeVmax(arrOrange.at(5).toInt());
            }

            if(arrWhite.size() == 6){
                setWhiteHmin(arrWhite.at(0).toInt());
                setWhiteHmax(arrWhite.at(1).toInt());
                setWhiteSmin(arrWhite.at(2).toInt());
                setWhiteSmax(arrWhite.at(3).toInt());
                setWhiteVmin(arrWhite.at(4).toInt());
                setWhiteVmax(arrWhite.at(5).toInt());
            }

            if(arrYellow.size() == 6){
                setYellowHmin(arrYellow.at(0).toInt());
                setYellowHmax(arrYellow.at(1).toInt());
                setYellowSmin(arrYellow.at(2).toInt());
                setYellowSmax(arrYellow.at(3).toInt());
                setYellowVmin(arrYellow.at(4).toInt());
                setYellowVmax(arrYellow.at(5).toInt());
            }

            if(arrBlack.size() == 6){
                setBlackHmin(arrBlack.at(0).toInt());
                setBlackHmax(arrBlack.at(1).toInt());
                setBlackSmin(arrBlack.at(2).toInt());
                setBlackSmax(arrBlack.at(3).toInt());
                setBlackVmin(arrBlack.at(4).toInt());
                setBlackVmax(arrBlack.at(5).toInt());
            }


            emit configUpdated();

        }
}

const QImage &OmniProcess::image() const
{
    return m_image;
}

void OmniProcess::setImage(const QImage &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}

int OmniProcess::greenHmin() const
{
    return m_greenHmin;
}

void OmniProcess::setGreenHmin(int newGreenHmin)
{
    if (m_greenHmin == newGreenHmin)
        return;
    m_greenHmin = newGreenHmin;
    emit greenHminChanged();
}

int OmniProcess::greenHmax() const
{
    return m_greenHmax;
}

void OmniProcess::setGreenHmax(int newGreenHmax)
{
    if (m_greenHmax == newGreenHmax)
        return;
    m_greenHmax = newGreenHmax;
    emit greenHmaxChanged();
}

int OmniProcess::greenSmin() const
{
    return m_greenSmin;
}

void OmniProcess::setGreenSmin(int newGreenSmin)
{
    if (m_greenSmin == newGreenSmin)
        return;
    m_greenSmin = newGreenSmin;
    emit greenSminChanged();
}

int OmniProcess::greenSmax() const
{
    return m_greenSmax;
}

void OmniProcess::setGreenSmax(int newGreenSmax)
{
    if (m_greenSmax == newGreenSmax)
        return;
    m_greenSmax = newGreenSmax;
    emit greenSmaxChanged();
}

int OmniProcess::greenVmin() const
{
    return m_greenVmin;
}

void OmniProcess::setGreenVmin(int newGreenVmin)
{
    if (m_greenVmin == newGreenVmin)
        return;
    m_greenVmin = newGreenVmin;
    emit greenVminChanged();
}

int OmniProcess::greenVmax() const
{
    return m_greenVmax;
}

void OmniProcess::setGreenVmax(int newGreenVmax)
{
    if (m_greenVmax == newGreenVmax)
        return;
    m_greenVmax = newGreenVmax;
    emit greenVmaxChanged();
}

int OmniProcess::orangeHmin() const
{
    return m_orangeHmin;
}

void OmniProcess::setOrangeHmin(int newOrangeHmin)
{
    if (m_orangeHmin == newOrangeHmin)
        return;
    m_orangeHmin = newOrangeHmin;
    emit orangeHminChanged();
}

int OmniProcess::orangeHmax() const
{
    return m_orangeHmax;
}

void OmniProcess::setOrangeHmax(int newOrangeHmax)
{
    if (m_orangeHmax == newOrangeHmax)
        return;
    m_orangeHmax = newOrangeHmax;
    emit orangeHmaxChanged();
}

int OmniProcess::orangeSmin() const
{
    return m_orangeSmin;
}

void OmniProcess::setOrangeSmin(int newOrangeSmin)
{
    if (m_orangeSmin == newOrangeSmin)
        return;
    m_orangeSmin = newOrangeSmin;
    emit orangeSminChanged();
}

int OmniProcess::orangeSmax() const
{
    return m_orangeSmax;
}

void OmniProcess::setOrangeSmax(int newOrangeSmax)
{
    if (m_orangeSmax == newOrangeSmax)
        return;
    m_orangeSmax = newOrangeSmax;
    emit orangeSmaxChanged();
}

int OmniProcess::orangeVmin() const
{
    return m_orangeVmin;
}

void OmniProcess::setOrangeVmin(int newOrangeVmin)
{
    if (m_orangeVmin == newOrangeVmin)
        return;
    m_orangeVmin = newOrangeVmin;
    emit orangeVminChanged();
}

int OmniProcess::orangeVmax() const
{
    return m_orangeVmax;
}

void OmniProcess::setOrangeVmax(int newOrangeVmax)
{
    if (m_orangeVmax == newOrangeVmax)
        return;
    m_orangeVmax = newOrangeVmax;
    emit orangeVmaxChanged();
}

int OmniProcess::whiteHmin() const
{
    return m_whiteHmin;
}

void OmniProcess::setWhiteHmin(int newWhiteHmin)
{
    if (m_whiteHmin == newWhiteHmin)
        return;
    m_whiteHmin = newWhiteHmin;
    emit whiteHminChanged();
}

int OmniProcess::whiteHmax() const
{
    return m_whiteHmax;
}

void OmniProcess::setWhiteHmax(int newWhiteHmax)
{
    if (m_whiteHmax == newWhiteHmax)
        return;
    m_whiteHmax = newWhiteHmax;
    emit whiteHmaxChanged();
}

int OmniProcess::whiteSmin() const
{
    return m_whiteSmin;
}

void OmniProcess::setWhiteSmin(int newWhiteSmin)
{
    if (m_whiteSmin == newWhiteSmin)
        return;
    m_whiteSmin = newWhiteSmin;
    emit whiteSminChanged();
}

int OmniProcess::whiteSmax() const
{
    return m_whiteSmax;
}

void OmniProcess::setWhiteSmax(int newWhiteSmax)
{
    if (m_whiteSmax == newWhiteSmax)
        return;
    m_whiteSmax = newWhiteSmax;
    emit whiteSmaxChanged();
}

int OmniProcess::whiteVmin() const
{
    return m_whiteVmin;
}

void OmniProcess::setWhiteVmin(int newWhiteVmin)
{
    if (m_whiteVmin == newWhiteVmin)
        return;
    m_whiteVmin = newWhiteVmin;
    emit whiteVminChanged();
}

int OmniProcess::whiteVmax() const
{
    return m_whiteVmax;
}

void OmniProcess::setWhiteVmax(int newWhiteVmax)
{
    if (m_whiteVmax == newWhiteVmax)
        return;
    m_whiteVmax = newWhiteVmax;
    emit whiteVmaxChanged();
}

int OmniProcess::yellowHmin() const
{
    return m_yellowHmin;
}

void OmniProcess::setYellowHmin(int newYellowHmin)
{
    if (m_yellowHmin == newYellowHmin)
        return;
    m_yellowHmin = newYellowHmin;
    emit yellowHminChanged();
}

int OmniProcess::yellowHmax() const
{
    return m_yellowHmax;
}

void OmniProcess::setYellowHmax(int newYellowHmax)
{
    if (m_yellowHmax == newYellowHmax)
        return;
    m_yellowHmax = newYellowHmax;
    emit yellowHmaxChanged();
}

int OmniProcess::yellowSmin() const
{
    return m_yellowSmin;
}

void OmniProcess::setYellowSmin(int newYellowSmin)
{
    if (m_yellowSmin == newYellowSmin)
        return;
    m_yellowSmin = newYellowSmin;
    emit yellowSminChanged();
}

int OmniProcess::yellowSmax() const
{
    return m_yellowSmax;
}

void OmniProcess::setYellowSmax(int newYellowSmax)
{
    if (m_yellowSmax == newYellowSmax)
        return;
    m_yellowSmax = newYellowSmax;
    emit yellowSmaxChanged();
}

int OmniProcess::yellowVmin() const
{
    return m_yellowVmin;
}

void OmniProcess::setYellowVmin(int newYellowVmin)
{
    if (m_yellowVmin == newYellowVmin)
        return;
    m_yellowVmin = newYellowVmin;
    emit yellowVminChanged();
}

int OmniProcess::yellowVmax() const
{
    return m_yellowVmax;
}

void OmniProcess::setYellowVmax(int newYellowVmax)
{
    if (m_yellowVmax == newYellowVmax)
        return;
    m_yellowVmax = newYellowVmax;
    emit yellowVmaxChanged();
}

int OmniProcess::blackHmin() const
{
    return m_blackHmin;
}

void OmniProcess::setBlackHmin(int newBlackHmin)
{
    if (m_blackHmin == newBlackHmin)
        return;
    m_blackHmin = newBlackHmin;
    emit blackHminChanged();
}

int OmniProcess::blackHmax() const
{
    return m_blackHmax;
}

void OmniProcess::setBlackHmax(int newBlackHmax)
{
    if (m_blackHmax == newBlackHmax)
        return;
    m_blackHmax = newBlackHmax;
    emit blackHmaxChanged();
}

int OmniProcess::blackSmin() const
{
    return m_blackSmin;
}

void OmniProcess::setBlackSmin(int newBlackSmin)
{
    if (m_blackSmin == newBlackSmin)
        return;
    m_blackSmin = newBlackSmin;
    emit blackSminChanged();
}

int OmniProcess::blackSmax() const
{
    return m_blackSmax;
}

void OmniProcess::setBlackSmax(int newBlackSmax)
{
    if (m_blackSmax == newBlackSmax)
        return;
    m_blackSmax = newBlackSmax;
    emit blackSmaxChanged();
}

int OmniProcess::blackVmin() const
{
    return m_blackVmin;
}

void OmniProcess::setBlackVmin(int newBlackVmin)
{
    if (m_blackVmin == newBlackVmin)
        return;
    m_blackVmin = newBlackVmin;
    emit blackVminChanged();
}

int OmniProcess::blackVmax() const
{
    return m_blackVmax;
}

void OmniProcess::setBlackVmax(int newBlackVmax)
{
    if (m_blackVmax == newBlackVmax)
        return;
    m_blackVmax = newBlackVmax;
    emit blackVmaxChanged();
}

void OmniProcess::requestConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "reqOmniConfig";
    tcp->send(jsonObject);
}

void OmniProcess::sendConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "omniConfig";

    QJsonArray greenArray;
    for (auto g : greenVec)
        greenArray.append(*g);
    jsonObject["green"] = greenArray;

    QJsonArray orangeArray;
    for (auto o : orangeVec)
        orangeArray.append(*o);
    jsonObject["orange"] = orangeArray;

    QJsonArray whiteArray;
    for (auto w : whiteVec)
        whiteArray.append(*w);
    jsonObject["white"] = whiteArray;

    QJsonArray yellowArray;
    for (auto y : yellowVec)
        yellowArray.append(*y);
    jsonObject["yellow"] = yellowArray;

    QJsonArray blackArray;
    for (auto b : blackVec)
        blackArray.append(*b);
    jsonObject["black"] = blackArray;

    jsonObject["brightness"] = m_brightness;
    jsonObject["saturation"] = m_saturation;

    this->tcp->send(jsonObject);

}

void OmniProcess::saveConfig()
{
    QJsonObject jsonObject;
    jsonObject["topic"] = "saveOmniConfig";
    this->tcp->send(jsonObject);
}

void OmniProcess::record()
{
    static bool rec = false;
    QJsonObject jsonObject;
    jsonObject["topic"] = "recordOmni";
    rec = !rec;
    jsonObject["record"] = rec;
    this->tcp->send(jsonObject);
}

void OmniProcess::play()
{
    static bool play = false;
    QJsonObject jsonObject;
    jsonObject["topic"] = "playOmni";
    play = !play;
    jsonObject["play"] = play;
    this->tcp->send(jsonObject);
}

double OmniProcess::brightness() const
{
    return m_brightness;
}

void OmniProcess::setBrightness(double newBrightness)
{
    if (qFuzzyCompare(m_brightness, newBrightness))
        return;
    m_brightness = newBrightness;
    emit brightnessChanged();
}


double OmniProcess::saturation() const
{
    return m_saturation;
}

void OmniProcess::setSaturation(double newSaturation)
{
    if (qFuzzyCompare(m_saturation, newSaturation))
        return;
    m_saturation = newSaturation;
    emit saturationChanged();
}
