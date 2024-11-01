#ifndef AMCLPROCESS_H
#define AMCLPROCESS_H

#include <QObject>
#include <QJsonObject>

#include "imageprovider.h"
#include "tcphandler.h"

class AmclProcess : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

public:
    explicit AmclProcess(TcpHandler *tcp_, ImageProvider *omniProvider_);
    void parseMsg();



    const QImage &image() const;
    void setImage(const QImage &newImage);

signals:

    void imageChanged();

private:
    TcpHandler *tcp;
    ImageProvider *omniProvider;

    QImage m_image;
};

#endif // AMCLPROCESS_H
