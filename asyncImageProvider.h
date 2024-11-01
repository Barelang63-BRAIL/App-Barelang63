#ifndef OMNIIMAGEPROVIDER_H
#define OMNIIMAGEPROVIDER_H

#include <QObject>
#include <QQuickImageProvider>

class OmniImageProvider : public QQuickImageProvider
{

public:
    explicit OmniImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override;

    void setImage(const QImage &image);

private:
    QImage m_image;

signals:

};

#endif // OMNIIMAGEPROVIDER_H
