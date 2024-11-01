#include "asyncImageProvider.h"

OmniImageProvider::OmniImageProvider() : QQuickImageProvider(QQuickImageProvider::Image, QQmlImageProviderBase::ForceAsynchronousImageLoading)
{

}

QImage OmniImageProvider::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    Q_UNUSED(id);
        Q_UNUSED(requestedSize);
    qDebug() <<"size : " << *size << "   imgSize : " << m_image.size();

        if (size)
            *size = m_image.size();

        return m_image;
}
void OmniImageProvider::setImage(const QImage &image)
{
    m_image = image;
}
