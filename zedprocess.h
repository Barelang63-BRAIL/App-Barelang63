#ifndef ZEDPROCESS_H
#define ZEDPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "imageprovider.h"
#include "tcphandler.h"
class ZedProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

    Q_PROPERTY(int ballHmin READ ballHmin WRITE setBallHmin NOTIFY ballHminChanged)
    Q_PROPERTY(int ballHmax READ ballHmax WRITE setBallHmax NOTIFY ballHmaxChanged)
    Q_PROPERTY(int ballSmin READ ballSmin WRITE setBallSmin NOTIFY ballSminChanged)
    Q_PROPERTY(int ballSmax READ ballSmax WRITE setBallSmax NOTIFY ballSmaxChanged)
    Q_PROPERTY(int ballVmin READ ballVmin WRITE setBallVmin NOTIFY ballVminChanged)
    Q_PROPERTY(int ballVmax READ ballVmax WRITE setBallVmax NOTIFY ballVmaxChanged)
    Q_PROPERTY(bool useMagenta READ useMagenta WRITE setUseMagenta NOTIFY useMagentaChanged)


public:
    explicit ZedProcess(TcpHandler *tcp_, ImageProvider *zedProvider_);
    void parseMsg();


    const QImage &image() const;
    void setImage(const QImage &newImage);

    int ballHmin() const;

    int ballHmax() const;

    int ballSmin() const;

    int ballSmax() const;

    int ballVmin() const;


    int ballVmax() const;

    bool useMagenta() const;

public slots:
    void requestConfig();
    void sendConfig();
    void saveConfig();
    void record();
    void play();

    void setBallHmin(int newBallHmin);
    void setBallHmax(int newBallHmax);
    void setBallSmin(int newBallSmin);
    void setBallSmax(int newBallSmax);
    void setBallVmin(int newBallVmin);
    void setBallVmax(int newBallVmax);
    void setUseMagenta(bool newUseMagenta);

signals:
    void configUpdated();

    void imageChanged();
    void ballHminChanged();

    void ballHmaxChanged();

    void ballSminChanged();

    void ballSmaxChanged();

    void ballVminChanged();

    void ballVmaxChanged();

    void useMagentaChanged();

private:
    TcpHandler *tcp;
    ImageProvider *zedProvider;

    std::vector<int *> ballVec;

    QImage m_image;
    int m_ballHmin;
    int m_ballHmax;
    int m_ballSmin;
    int m_ballSmax;
    int m_ballVmin;
    int m_ballVmax;
    bool m_useMagenta;
};

#endif // ZEDPROCESS_H
