#-------------------------------------------------
#
# Project created by QtCreator 2019-03-28T08:45:32
#
#-------------------------------------------------

QT += core gui widgets network charts

TARGET = qv2ray
TEMPLATE = app

# Now read build number file.
_BUILD_NUMBER=$$cat(Build.Counter)
VERSION = 2.0.1.$$_BUILD_NUMBER

no_increase_build_number {
    message("Build.Counter will not be increased")
} else {
    _BUILD_NUMBER = $$num_add($$_BUILD_NUMBER, 1)
    write_file("Build.Counter", _BUILD_NUMBER)
}

# Unix (Actually Linux only) prefix config.
isEmpty(PREFIX) {
    PREFIX=/usr/local
}
message("Qv2ray installation PREFIX="$$PREFIX)

DEFINES += QT_DEPRECATED_WARNINGS QV2RAY_VERSION_STRING=\"\\\"v$${VERSION}\\\"\" QAPPLICATION_CLASS=QApplication

# Don't merge those configs with below.
CONFIG += enable_decoder_qr_code enable_encoder_qr_code qt c++11 openssl-linked

include(3rdparty/qzxing/src/QZXing-components.pri)
include(3rdparty/SingleApplication/singleapplication.pri)
include(3rdparty/QNodeEditor/QNodeEditor.pri)
include(3rdparty/x2struct/x2struct.pri)

# Main config
CONFIG += lrelease embed_translations

# Win32 support.
win32:CONFIG += win
win64:CONFIG += win

defineTest(Qv2rayAddFile) {
    ext = $$take_last(ARGS)
    filename = $${take_first(ARGS)}.$${ext}
    qmake_debug: message("Qv2rayAddFile: filename: $$filename")
    !exists($$filename) {
        error("File: \"$$filename\" is not found, Qv2ray build preparation cannot continue")
    }
    equals(ext, "cpp") {
        qmake_debug: message(Adding source $$filename)
        SOURCES += $$filename
    } else {
        equals(ext, "hpp") {
            qmake_debug: message(Adding header $$filename)
            HEADERS += $$filename
        } else {
            equals(ext, "ui") {
                qmake_debug: message(Adding form $$filename)
                FORMS += $$filename
            } else {
                error("Unknown extension: $${ext}")
            }
        }
    }

    export(SOURCES)
    export(HEADERS)
    export(FORMS)
}

defineTest(Qv2rayAddSource) {
    # Module Compnent Filename extlist
    module = $$take_first(ARGS)
    component = $$take_first(ARGS)
    filename = $$take_first(ARGS)
    extlist = $$ARGS
    FILEPATH = "$$PWD/src/$${module}"
    qmake_debug: message(Qv2rayAddSource: Adding \"$${filename}\" of module \"$${module}\" and component \"$${component}\" to the project)
    equals(component, "_") {
        qmake_debug: message("Qv2rayAddSource: Component is empty, ignore")
        FILEPATH += "/$${filename}"
        FILEPATH=$$join(FILEPATH)
    } else {
        FILEPATH += "/$${component}/$${filename}"
        FILEPATH=$$join(FILEPATH)
    }
    qmake_debug: message("Qv2rayAddSource: filepath: $${FILEPATH}, extlist: $${extlist}")
    for(iterate, extlist) {
        Qv2rayAddFile($$FILEPATH, $$iterate)
    }
    export(SOURCES)
    export(HEADERS)
    export(FORMS)
}

Qv2rayAddSource(base, _, GlobalInstances, cpp, hpp)
Qv2rayAddSource(base, _, JsonHelpers, hpp)
Qv2rayAddSource(base, _, Qv2rayBase, hpp)
Qv2rayAddSource(base, _, Qv2rayFeatures, hpp)
Qv2rayAddSource(base, _, Qv2rayLog, cpp, hpp)
Qv2rayAddSource(common, _, CommandArgs, cpp, hpp)
Qv2rayAddSource(common, _, HTTPRequestHelper, cpp, hpp)
Qv2rayAddSource(common, _, LogHighlighter, cpp, hpp)
Qv2rayAddSource(common, _, QJsonModel, cpp, hpp)
Qv2rayAddSource(common, _, QvHelpers, cpp, hpp)
Qv2rayAddSource(common, models, CoreObjectModels, hpp)
Qv2rayAddSource(common, models, QvConfigModel, hpp)
Qv2rayAddSource(common, models, QvSafeType, hpp)
Qv2rayAddSource(common, models, RuntimeConfig, hpp)
Qv2rayAddSource(components, autolaunch, QvAutoLaunch, cpp, hpp)
Qv2rayAddSource(components, pac, QvGFWPACConverter, cpp)
Qv2rayAddSource(components, pac, QvPACHandler, cpp, hpp)
Qv2rayAddSource(components, plugins/toolbar, QvToolbar, cpp, hpp)
#Qv2rayAddSource(components, plugins/toolbar, QvToolbar_linux, cpp)
#Qv2rayAddSource(components, plugins/toolbar, QvToolbar_win, cpp)
Qv2rayAddSource(components, proxy, QvProxyConfigurator, cpp, hpp)
Qv2rayAddSource(components, tcping, QvTCPing, cpp, hpp)
Qv2rayAddSource(core, config, ConfigBackend, cpp)
Qv2rayAddSource(core, config, ConfigUpgrade, cpp)
Qv2rayAddSource(core, connection, ConnectionConfig_Convertion, cpp)
Qv2rayAddSource(core, connection, ConnectionConfig_Generation, cpp)
Qv2rayAddSource(core, connection, ConnectionConfigOperations, cpp, hpp)
Qv2rayAddSource(core, _, CoreUtils, cpp, hpp)
Qv2rayAddSource(core, kernel, QvKernelInteractions, cpp, hpp)
Qv2rayAddSource(ui, editors, w_InboundEditor, cpp, hpp, ui)
Qv2rayAddSource(ui, editors, w_JsonEditor, cpp, hpp, ui)
Qv2rayAddSource(ui, editors, w_OutboundEditor, cpp, hpp, ui)
Qv2rayAddSource(ui, editors, w_RoutesEditor, cpp, hpp, ui)
Qv2rayAddSource(ui, editors, w_RoutesEditor_extra, cpp)
Qv2rayAddSource(ui, nodemodels, InboundNodeModel, cpp, hpp)
Qv2rayAddSource(ui, nodemodels, OutboundNodeModel, cpp, hpp)
Qv2rayAddSource(ui, nodemodels, RuleNodeModel, cpp, hpp)
Qv2rayAddSource(ui, nodemodels, NodeModelsBase, hpp)
Qv2rayAddSource(ui, _, w_ExportConfig, cpp, hpp, ui)
Qv2rayAddSource(ui, _, w_ImportConfig, cpp, hpp, ui)
Qv2rayAddSource(ui, _, w_MainWindow, cpp, hpp, ui)
Qv2rayAddSource(ui, _, w_MainWindow_extra, cpp)
Qv2rayAddSource(ui, _, w_PreferencesWindow, cpp, hpp, ui)
Qv2rayAddSource(ui, _, w_ScreenShot_Core, cpp, hpp, ui)
Qv2rayAddSource(ui, _, w_SubscriptionManager, cpp, hpp, ui)

SOURCES += $$PWD/src/main.cpp
#SOURCES += $$PWD/src/main.cpp
RESOURCES += \
        resources.qrc

# Fine......
message(" ")
message("Qv2ray Version: $${VERSION}")
message("|-------------------------------------------------|")
message("| Qv2ray, A Cross Platform v2ray Qt GUI Client.   |")
message("| Licenced under GPLv3                            |")
message("|                                                 |")
message("| You may only use this program to the extent     |")
message("| permitted by local law.                         |")
message("|                                                 |")
message("| See: https://www.gnu.org/licenses/gpl-3.0.html  |")
message("|-------------------------------------------------|")
message(" ")

# Qv2ray manual build info
_QV2RAY_BUILD_INFO_STR_=$$getenv(_QV2RAY_BUILD_INFO_)
_QV2RAY_BUILD_EXTRA_INFO_STR_=$$getenv(_QV2RAY_BUILD_EXTRA_INFO_)

isEmpty(_QV2RAY_BUILD_INFO_STR_) {
    _QV2RAY_BUILD_INFO_STR_ = "Qv2ray from manual build"
}

isEmpty(_QV2RAY_BUILD_EXTRA_INFO_STR_) {
    _QV2RAY_BUILD_EXTRA_INFO_STR_ = "Qv2ray $$VERSION"
}

message(Qv2ray build info: $$_QV2RAY_BUILD_INFO_STR_)
message(Qv2ray build extra info: $$_QV2RAY_BUILD_EXTRA_INFO_STR_)
# \"\\\"v$${VERSION}\\\"\"
DEFINES += _QV2RAY_BUILD_INFO_STR_=\"\\\"$${_QV2RAY_BUILD_INFO_STR_}\\\"\" \
           _QV2RAY_BUILD_EXTRA_INFO_STR_=\"\\\"$${_QV2RAY_BUILD_EXTRA_INFO_STR_}\\\"\"

message(" ")

RC_ICONS += ./assets/icons/qv2ray.ico
ICON = ./assets/icons/qv2ray.icns

with_new_backend {
    !exists($$PWD/libs/libqvb/build/libqvb.h) {
        message(" ")
        message("Cannot continue: ")
        message("  --> Qv2ray is configured to use custom backend, but: ")
        message("      libs/libqvb/build/libqvb.h is missing. ")
        error("! ABORTING THE BUILD !")
        message(" ")
    }

    message("Qv2ray will use custom API backend.")
    message("  --> Adding libqvb header.")
    HEADERS += libs/libqvb/build/libqvb.h

    # ==-- OS Specific configurations for libqvb --==
    win {
        message("  --> Linking libqvb static library, for Windows platform.")
        LIBS += -L$$PWD/libs/ -lqvb-win64
    }
    unix:!macx {
        message("  --> Linking libqvb static library, for Linux platform.")
        LIBS += -L$$PWD/libs/ -lqvb-linux64
    }
    macx {
        message("  --> Linking libqvb static library and Security framework, for macOS platform.")
        LIBS += -L$$PWD/libs/ -lqvb-darwin
        LIBS += -framework Security
    }
} else {
    DEFINES += WITH_LIB_GRPCPP
    message("Qv2ray will use libgRPC as API backend")

    # ------------------------------------------ Begin checking gRPC and protobuf headers.
    !exists($$PWD/libs/gen/v2ray_api_commands.grpc.pb.h) || !exists($$PWD/libs/gen/v2ray_api_commands.grpc.pb.cc) || !exists($$PWD/libs/gen/v2ray_api_commands.pb.h) || !exists($$PWD/libs/gen/v2ray_api_commands.pb.cc) {
        message(" ")
        message("-----------------------------------------------")
        message("Cannot continue: ")
        message("  --> Qv2ray is not properly configured yet: ")
        message("      gRPC and protobuf headers for v2ray API is missing.")
        message("  --> Please run gen_grpc.sh gen_grpc.bat or deps_macOS.sh located in tools/")
        message("  --> Or consider reading the build wiki: https://github.com/Qv2ray/Qv2ray/wiki/Manually-Build-Qv2ray")
        message("-----------------------------------------------")
        message(" ")
        warning("IF YOU THINK IT'S A MISTAKE, PLEASE OPEN AN ISSUE")
        error("! ABORTING THE BUILD !")
        message(" ")
    }

    SOURCES += libs/gen/v2ray_api_commands.pb.cc \
               libs/gen/v2ray_api_commands.grpc.pb.cc

    HEADERS += libs/gen/v2ray_api_commands.pb.h \
               libs/gen/v2ray_api_commands.grpc.pb.h

    # ==-- OS Specific configurations for libgRPC and libprotobuf --==
    win {
        # A hack for protobuf header.
        message("  --> Applying a hack for protobuf header")
        DEFINES += _WIN32_WINNT=0x600

        message("  --> Linking against gRPC and protobuf library.")
        DEPENDPATH  += $$PWD/libs/gRPC-win32/include
        INCLUDEPATH += $$PWD/libs/gRPC-win32/include
        LIBS += -L$$PWD/libs/gRPC-win32/lib/ \
                -llibprotobuf.dll \
                -llibgrpc++.dll
    }
    unix {
        # For gRPC and protobuf in linux and macOS
        message("  --> Linking against gRPC and protobuf library.")
        LIBS += -L/usr/local/lib -lgrpc++ -lprotobuf -lgrpc
    }
    macx {
        message("  --> Linking libgpr and libupb.")
        LIBS += -lgpr -lupb
    }
}

message(" ")
# ------------------------------------------ Begin to detect language files.
message("Looking for language support.")
QM_FILES_RESOURCE_PREFIX = "translations"
for(var, $$list($$files("translations/*.ts", true))) {
    LOCALE_FILENAME = $$basename(var)
    message("  --> Found:" $$LOCALE_FILENAME)
    !equals(LOCALE_FILENAME, "en_US.ts") {
        # ONLY USED IN LRELEASE CONTEXT
        # en_US is not EXTRA...
        EXTRA_TRANSLATIONS += translations/$$LOCALE_FILENAME
    }
}
message("Qv2ray will build with" $${replace(EXTRA_TRANSLATIONS, "translations/", "")})
TRANSLATIONS += translations/en_US.ts

message(" ")
QMAKE_CXXFLAGS += -Wno-missing-field-initializers -Wno-unused-parameter -Wno-unused-variable

message("Adding QHttpServer Support")
message("  --> Adding qhttpserver")
HEADERS += \
    $$PWD/3rdparty/qhttpserver/src/qhttpconnection.h \
    $$PWD/3rdparty/qhttpserver/src/qhttprequest.h \
    $$PWD/3rdparty/qhttpserver/src/qhttpresponse.h \
    $$PWD/3rdparty/qhttpserver/src/qhttpserver.h \
    $$PWD/3rdparty/qhttpserver/src/qhttpserverapi.h \
    $$PWD/3rdparty/qhttpserver/src/qhttpserverfwd.h
SOURCES += \
    $$PWD/3rdparty/qhttpserver/src/qhttpconnection.cpp \
    $$PWD/3rdparty/qhttpserver/src/qhttprequest.cpp \
    $$PWD/3rdparty/qhttpserver/src/qhttpresponse.cpp \
    $$PWD/3rdparty/qhttpserver/src/qhttpserver.cpp

INCLUDEPATH += 3rdparty/qhttpserver/src/

message("  --> Adding http parser")
HEADERS += 3rdparty/qhttpserver/http-parser/http_parser.h
SOURCES += 3rdparty/qhttpserver/http-parser/http_parser.c
INCLUDEPATH += 3rdparty/qhttpserver/http-parser/

message(" ")
win {
    message("Configuring for win32 environment")
    DEFINES += QHTTPSERVER_EXPORT
    message("  --> Setting up target descriptions")
    QMAKE_TARGET_DESCRIPTION = "Qv2ray, a cross-platform v2ray GUI client."
    QMAKE_TARGET_PRODUCT = "Qv2ray"

    message("  --> Adding Taskbar Toolbox CPP files.")
    Qv2rayAddSource(components, plugins/toolbar, QvToolbar_win, cpp)
    
    message("  --> Linking against winHTTP and winSock2.")
    LIBS += -lwinhttp -lwininet -lws2_32
}

macx {
    # For Linux and macOS
    message("Configuring for macOS specific environment")
    LIBS += -framework Carbon -framework Cocoa
}

# Reuse unix for macx as well
unix {
    # For Linux and macOS
    message("Configuring for unix-like environment")
    # macOS homebrew include path
    message("  --> Adding local include folder to search path")
    INCLUDEPATH += /usr/local/include/

    message("  --> Adding Plasma Toolbox CPP files.")
    Qv2rayAddSource(components, plugins/toolbar, QvToolbar_linux, cpp)

    message("  --> Generating desktop dependency.")
    desktop.files += ./assets/qv2ray.desktop
    desktop.path = $$PREFIX/share/applications/

    message("  --> Generating icons dependency.")
    icon.files += ./assets/icons/qv2ray.png
    icon.path = $$PREFIX/share/icons/hicolor/256x256/apps/

    target.path = $$PREFIX/bin/
    INSTALLS += target desktop icon
}

with_metainfo {
    message("  --> Generating metainfo dependency.")
    appdataXml.files += ./assets/qv2ray.metainfo.xml
    appdataXml.path = $$PREFIX/share/metainfo/
    INSTALLS += appdataXml
    DEFINES += WITH_FLATHUB_CONFIG_PATH
}

message(" ")
message("This Qv2ray build contains: ")
message("  --> $${size(SOURCES)} source files")
message("  --> $${size(HEADERS)} header files")
message("  --> $${size(FORMS)} ui files")
message("  --> $${size(TRANSLATIONS)} translation files")
message("  --> $${size(EXTRA_TRANSLATIONS)} extra translation files")
message(" ")
message("Done configuring Qv2ray project. Build output will be at:" $$OUT_PWD)
message("Type `make` or `mingw32-make` to start building Qv2ray")
