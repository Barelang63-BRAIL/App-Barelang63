#ifndef OMNIPROCESS_H
#define OMNIPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "imageprovider.h"
#include "tcphandler.h"
class OmniProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

    Q_PROPERTY(int greenHmin READ greenHmin WRITE setGreenHmin NOTIFY greenHminChanged)
    Q_PROPERTY(int greenHmax READ greenHmax WRITE setGreenHmax NOTIFY greenHmaxChanged)
    Q_PROPERTY(int greenSmin READ greenSmin WRITE setGreenSmin NOTIFY greenSminChanged)
    Q_PROPERTY(int greenSmax READ greenSmax WRITE setGreenSmax NOTIFY greenSmaxChanged)
    Q_PROPERTY(int greenVmin READ greenVmin WRITE setGreenVmin NOTIFY greenVminChanged)
    Q_PROPERTY(int greenVmax READ greenVmax WRITE setGreenVmax NOTIFY greenVmaxChanged)

    Q_PROPERTY(int orangeHmin READ orangeHmin WRITE setOrangeHmin NOTIFY orangeHminChanged)
    Q_PROPERTY(int orangeHmax READ orangeHmax WRITE setOrangeHmax NOTIFY orangeHmaxChanged)
    Q_PROPERTY(int orangeSmin READ orangeSmin WRITE setOrangeSmin NOTIFY orangeSminChanged)
    Q_PROPERTY(int orangeSmax READ orangeSmax WRITE setOrangeSmax NOTIFY orangeSmaxChanged)
    Q_PROPERTY(int orangeVmin READ orangeVmin WRITE setOrangeVmin NOTIFY orangeVminChanged)
    Q_PROPERTY(int orangeVmax READ orangeVmax WRITE setOrangeVmax NOTIFY orangeVmaxChanged)

    Q_PROPERTY(int whiteHmin READ whiteHmin WRITE setWhiteHmin NOTIFY whiteHminChanged)
    Q_PROPERTY(int whiteHmax READ whiteHmax WRITE setWhiteHmax NOTIFY whiteHmaxChanged)
    Q_PROPERTY(int whiteSmin READ whiteSmin WRITE setWhiteSmin NOTIFY whiteSminChanged)
    Q_PROPERTY(int whiteSmax READ whiteSmax WRITE setWhiteSmax NOTIFY whiteSmaxChanged)
    Q_PROPERTY(int whiteVmin READ whiteVmin WRITE setWhiteVmin NOTIFY whiteVminChanged)
    Q_PROPERTY(int whiteVmax READ whiteVmax WRITE setWhiteVmax NOTIFY whiteVmaxChanged)

    Q_PROPERTY(int yellowHmin READ yellowHmin WRITE setYellowHmin NOTIFY yellowHminChanged)
    Q_PROPERTY(int yellowHmax READ yellowHmax WRITE setYellowHmax NOTIFY yellowHmaxChanged)
    Q_PROPERTY(int yellowSmin READ yellowSmin WRITE setYellowSmin NOTIFY yellowSminChanged)
    Q_PROPERTY(int yellowSmax READ yellowSmax WRITE setYellowSmax NOTIFY yellowSmaxChanged)
    Q_PROPERTY(int yellowVmin READ yellowVmin WRITE setYellowVmin NOTIFY yellowVminChanged)
    Q_PROPERTY(int yellowVmax READ yellowVmax WRITE setYellowVmax NOTIFY yellowVmaxChanged)

    Q_PROPERTY(int blackHmin READ blackHmin WRITE setBlackHmin NOTIFY blackHminChanged)
    Q_PROPERTY(int blackHmax READ blackHmax WRITE setBlackHmax NOTIFY blackHmaxChanged)
    Q_PROPERTY(int blackSmin READ blackSmin WRITE setBlackSmin NOTIFY blackSminChanged)
    Q_PROPERTY(int blackSmax READ blackSmax WRITE setBlackSmax NOTIFY blackSmaxChanged)
    Q_PROPERTY(int blackVmin READ blackVmin WRITE setBlackVmin NOTIFY blackVminChanged)
    Q_PROPERTY(int blackVmax READ blackVmax WRITE setBlackVmax NOTIFY blackVmaxChanged)

    Q_PROPERTY(double brightness READ brightness WRITE setBrightness NOTIFY brightnessChanged)
    Q_PROPERTY(double saturation READ saturation WRITE setSaturation NOTIFY saturationChanged)




public:
    OmniProcess(TcpHandler *tcp_, ImageProvider *omniProvider_);
    void parseMsg();


    const QImage &image() const;
    int greenHmin() const;
    void setImage(const QImage &newImage);
    int greenHmax() const;
    int greenSmin() const;
    int greenSmax() const;
    int greenVmin() const;
    int greenVmax() const;
    int orangeHmin() const;
    int orangeHmax() const;
    int orangeSmin() const;
    int orangeSmax() const;
    int orangeVmin() const;
    int orangeVmax() const;
    int whiteHmin() const;
    int whiteHmax() const;
    int whiteSmin() const;
    int whiteSmax() const;
    int whiteVmin() const;
    int whiteVmax() const;
    int yellowHmin() const;
    int yellowHmax() const;
    int yellowSmin() const;
    int yellowSmax() const;
    int yellowVmin() const;
    int yellowVmax() const;
    int blackHmin() const;
    int blackHmax() const;
    int blackSmin() const;
    int blackSmax() const;
    int blackVmin() const;
    int blackVmax() const;

    double brightness() const;

    double saturation() const;

public slots:
    void setGreenHmin(int newGreenHmin);
    void setGreenHmax(int newGreenHmax);
    void setGreenSmin(int newGreenSmin);
    void setGreenSmax(int newGreenSmax);
    void setGreenVmin(int newGreenVmin);
    void setGreenVmax(int newGreenVmax);
    void setOrangeHmin(int newOrangeHmin);
    void setOrangeHmax(int newOrangeHmax);
    void setOrangeSmin(int newOrangeSmin);
    void setOrangeSmax(int newOrangeSmax);
    void setOrangeVmin(int newOrangeVmin);
    void setOrangeVmax(int newOrangeVmax);
    void setWhiteHmin(int newWhiteHmin);
    void setWhiteHmax(int newWhiteHmax);
    void setWhiteSmin(int newWhiteSmin);
    void setWhiteSmax(int newWhiteSmax);
    void setWhiteVmin(int newWhiteVmin);
    void setWhiteVmax(int newWhiteVmax);
    void setYellowHmin(int newYellowHmin);
    void setYellowHmax(int newYellowHmax);
    void setYellowSmin(int newYellowSmin);
    void setYellowSmax(int newYellowSmax);
    void setYellowVmin(int newYellowVmin);
    void setYellowVmax(int newYellowVmax);
    void setBlackHmin(int newBlackHmin);
    void setBlackHmax(int newBlackHmax);
    void setBlackSmin(int newBlackSmin);
    void setBlackSmax(int newBlackSmax);
    void setBlackVmin(int newBlackVmin);
    void setBlackVmax(int newBlackVmax);

    void setBrightness(double newBrightness);
    void setSaturation(double newSaturation);


    void requestConfig();
    void sendConfig();
    void saveConfig();
    void record();
    void play();

signals:
    void configUpdated();
    void imageChanged();

    void greenHminChanged();

    void greenHmaxChanged();

    void greenSminChanged();

    void greenSmaxChanged();

    void greenVminChanged();

    void greenVmaxChanged();

    void orangeHminChanged();

    void orangeHmaxChanged();

    void orangeSminChanged();

    void orangeSmaxChanged();

    void orangeVminChanged();

    void orangeVmaxChanged();

    void whiteHminChanged();

    void whiteHmaxChanged();

    void whiteSminChanged();

    void whiteSmaxChanged();

    void whiteVminChanged();

    void whiteVmaxChanged();

    void yellowHminChanged();

    void yellowHmaxChanged();

    void yellowSminChanged();

    void yellowSmaxChanged();

    void yellowVminChanged();

    void yellowVmaxChanged();

    void blackHminChanged();

    void blackHmaxChanged();

    void blackSminChanged();

    void blackSmaxChanged();

    void blackVminChanged();

    void blackVmaxChanged();

    void brightnessChanged();


    void saturationChanged();

private:
    TcpHandler *tcp;
    ImageProvider *omniProvider;
    std::vector<int *> greenVec, orangeVec, yellowVec, whiteVec, blackVec;

    QImage m_image;

    int m_greenHmin;
    int m_greenHmax;
    int m_greenSmin;
    int m_greenSmax;
    int m_greenVmin;
    int m_greenVmax;
    int m_orangeHmin;
    int m_orangeHmax;
    int m_orangeSmin;
    int m_orangeSmax;
    int m_orangeVmin;
    int m_orangeVmax;
    int m_whiteHmin;
    int m_whiteHmax;
    int m_whiteSmin;
    int m_whiteSmax;
    int m_whiteVmin;
    int m_whiteVmax;
    int m_yellowHmin;
    int m_yellowHmax;
    int m_yellowSmin;
    int m_yellowSmax;
    int m_yellowVmin;
    int m_yellowVmax;
    int m_blackHmin;
    int m_blackHmax;
    int m_blackSmin;
    int m_blackSmax;
    int m_blackVmin;
    int m_blackVmax;
    double m_brightness;
    double m_saturation;
};

#endif // OMNIPROCESS_H
