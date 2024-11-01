#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QHostAddress>
#include <QDebug>
// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>

//#include "udpclient.h"
#include "tcphandler.h"
#include "screenprocess.h"
#include "stmprocess.h"
#include "arduinoprocess.h"
#include "strategyprocess.h"
#include "programrunning.h"
#include "omniprocess.h"
#include "zedprocess.h"
#include "imageprovider.h"
#include "amclprocess.h"


#define ADB_LOCALHOST_IP "127.0.0.1"

TcpHandler *tcpHandler;
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    FelgoApplication felgo;

    // Use platform-specific fonts instead of Felgo's default font
    felgo.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    // Set an optional license key from project file
    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));


    tcpHandler = new TcpHandler();
    ScreenProcess screenProcess;
    screenProcess.tcp = tcpHandler;
    StmProcess stmProcess(tcpHandler);
    ArduinoProcess arduinoProcess(tcpHandler);
    StrategyProcess strategyProcess(tcpHandler);
    ProgramRunning programProcess(tcpHandler);
    ImageProvider omniImgProvider;
    OmniProcess omniProcess(tcpHandler, &omniImgProvider);
    ImageProvider zedImgProvider;
    ZedProcess zedProcess(tcpHandler, &zedImgProvider);
    ImageProvider amclImgProvider;
    AmclProcess amclProcess(tcpHandler, &amclImgProvider);


    engine.addImageProvider("omni", &omniImgProvider);
    engine.addImageProvider("zed", &zedImgProvider);
    engine.addImageProvider("amcl", &amclImgProvider);
    engine.rootContext()->setContextProperty("screenProcessObject", &screenProcess); // the object will be available in QML with name "screenProcessObject"
    engine.rootContext()->setContextProperty("stmProcessObject", &stmProcess);
    engine.rootContext()->setContextProperty("arduinoProcessObject", &arduinoProcess);
    engine.rootContext()->setContextProperty("strategyProcessObject", &strategyProcess);
    engine.rootContext()->setContextProperty("programProcessObject", &programProcess);
    engine.rootContext()->setContextProperty("omniProcessObject", &omniProcess);
    engine.rootContext()->setContextProperty("zedProcessObject", &zedProcess);
    engine.rootContext()->setContextProperty("amclProcessObject", &amclProcess);








    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
    //felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));




    engine.load(QUrl(felgo.mainQmlFileName()));




    // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
    //FelgoLiveClient client (&engine);

    return app.exec();
}
