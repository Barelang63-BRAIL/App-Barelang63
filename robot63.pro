# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.zall.Robot63
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = ""

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

# RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    amclprocess.cpp \
arduinoprocess.cpp \
basestationprocess.cpp \
    imageprovider.cpp \
    omniprocess.cpp \
programrunning.cpp \
    receivereditor.cpp \
screenprocess.cpp \
stmprocess.cpp \
strategyprocess.cpp \
tcphandler.cpp \
    zedprocess.cpp


android {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

# set application icons for win and macx
win32 {
    RC_FILE += win/app_icon.rc
}
macx {
    ICON = macx/app_icon.icns
}

HEADERS += \
    amclprocess.h \
    arduinoprocess.h \
    basestationprocess.h \
    imageprovider.h \
    omniprocess.h \
    programrunning.h \
    receivereditor.h \
    screenprocess.h \
    stmprocess.h \
    strategyprocess.h \
    tcphandler.h \
    zedprocess.h


DISTFILES += \
    qml/control/Bar.qml \
    qml/control/CheckBoxCustom.qml \
    qml/control/RadioButtonCustom.qml \
    qml/control/RangeSliderCustom.qml \
    qml/control/RoundMouseArea.qml \
    qml/control/SliderCustom.qml \
    qml/control/StartButton.qml \
    qml/control/StartOptionComp.qml \
    qml/control/TopBarButton.qml \
    qml/page/AmclPage.qml \
    qml/page/ArduinoPage.qml \
    qml/page/BasestationPage.qml \
    qml/page/OmniPage.qml \
    qml/page/RotationPage.qml \
    qml/page/StmPage.qml \
    qml/page/RobotPage.qml \
    qml/page/ZedPage.qml \
    qml/page/arduino/DribblerComp.qml \
    qml/page/arduino/GrabberComp.qml \
    qml/page/arduino/KickComp.qml \
    qml/page/arduino/KiperFrameComp.qml \
    qml/page/robot/FieldComp.qml \
    qml/page/robot/FieldReceiverEditor.qml \
    qml/page/robot/PlayerDelegate.qml \
    qml/page/stm/JoyButtonComp.qml \
    qml/page/stm/OmniWheel.qml \
    qml/page/stm/StmPosition.qml \
    qml/page/stm/Wheel.qml
