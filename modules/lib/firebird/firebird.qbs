/*****************************************************************************
  В модуле определены пути и режим подключения к серверу БД FireBird

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    prefix: "/opt/firebird"
    property bool embedded: false

    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/firebird"
        libSuffix: ""
    }

    checkingHeaders: ["ibase.h"]
    dynamicLibraries: {
        var lib = ["fbclient"];
        if (embedded)
            lib = ["fbembed"];
        return lib;
    }

    PropertyOptions {
        name: "embedded"
        description: "Использовать встроенный сервер вместо клиента"
    }
}
