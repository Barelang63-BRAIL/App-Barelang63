#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H


#include <QQuickImageProvider>
#include <QImage>

class ImageProvider : public QQuickImageProvider
{
    Q_PROPERTY(QImage image READ image WRITE setImage NOTIFY imageChanged)

public:

    ImageProvider();
    QImage requestImage(const QString &id, QSize *size, const QSize& requestedSize) override;

    const QImage &image() const;
    void setImage(const QImage &newImage);
signals:
    void imageChanged();

private:
    QImage m_image;
};

#endif // IMAGEPROVIDER_H
