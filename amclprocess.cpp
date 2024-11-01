#include "amclprocess.h"

AmclProcess::AmclProcess(TcpHandler *tcp_, ImageProvider *omniProvider_ ) : tcp(tcp_), omniProvider(omniProvider_)
{

    QObject::connect(tcp, &TcpHandler::jsonMsgChanged, this, &AmclProcess::parseMsg);

}

void AmclProcess::parseMsg()
{
    auto &obj = tcp->jsonMsg();
    if(obj.contains("page"))
        if(obj["page"].toString() == "amcl")
        {
            auto const encoded =  obj["pixels"].toString().toLatin1();
            QImage image_tmp;
            image_tmp.loadFromData(QByteArray::fromBase64(encoded), "PNG");
            omniProvider->setImage(image_tmp);

        }
}

const QImage &AmclProcess::image() const
{
    return m_image;
}

void AmclProcess::setImage(const QImage &newImage)
{
    if (m_image == newImage)
        return;
    m_image = newImage;
    emit imageChanged();
}
