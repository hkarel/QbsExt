/*****************************************************************************
 Базовый модуль, используется для описания и подключения сторонних библиотек

*****************************************************************************/

import qbs
import qbs.File
import QbsUtl

Module {
    property string prefix
    property string version: ""

    property bool enabled: true
    property bool useSystem: false

    property string includeSuffix: "/include"
    property string libSuffix: "/lib"

    property path includePath: (useSystem || !enabled)
                               ? undefined
                               : prefix + (version.length ? "/" + version : "") + includeSuffix

    property path libraryPath: (useSystem || !enabled)
                               ? undefined
                               : prefix + (version.length ? "/" + version : "") + libSuffix

    property var dynamicLibraries: []
    property var staticLibraries: []

    property pathList systemIncludePaths: [
        "/usr/include",
        "/usr/include/x86_64-linux-gnu",
        "/usr/local/include",
    ]
    property var checkingHeaders: []

    property var probe: {
        return function(productName)
        {
            if (!this.enabled)
                return;

            var msg;
            var err = new Error;
            err.productName = productName;

            if (this.useSystem
                && this.checkingHeaders !== undefined
                && this.systemIncludePaths !== undefined) {
                for (var i = 0; i < this.checkingHeaders.length; ++i) {
                    var notFound = true;
                    for (var j = 0; j < this.systemIncludePaths.length; ++j) {
                        var headerPath = this.systemIncludePaths[j] + "/" + this.checkingHeaders[i];
                        if (File.exists(headerPath)) {
                            notFound = false;
                            break;
                        }
                    }
                    if (notFound === true) {
                        msg = "Invalid dependency module '{0}'; " +
                              "Header file {1} not found in system paths; " +
                              "Possibly library is not installed";
                        err.message = msg.format(this.name, this.checkingHeaders[i]);
                        throw err;
                    }
                }
            }
            else {
                msg = "Invalid dependency module '{0}'; Directory not found: {1}; " +
                      "Possibly incorrect assigned library version: {2}";
                if (!File.exists(this.includePath)) {
                    err.message = msg.format(this.name, this.includePath, this.version);
                    throw err;
                }
                if (!File.exists(this.libraryPath)) {
                    err.message = msg.format(this.name, this.libraryPath, this.version);
                    throw err;
                }

                if (this.checkingHeaders !== undefined)
                    for (var i = 0; i < this.checkingHeaders.length; ++i) {
                        var headerPath = this.includePath + "/" + this.checkingHeaders[i];
                        if (!File.exists(headerPath)) {
                            msg = "Invalid dependency module '{0}'; " +
                                  "Header file not found: {1}; " +
                                  "Possibly library is not installed";
                            err.message = msg.format(this.name, headerPath);
                            throw err;
                        }
                    }
            }
        };
    }

    property var staticLibrariesPaths: {
        return function(product)
        {
            var paths = [];
            if (this.enabled)
                paths = QbsUtl.staticLibrariesPaths(product, this.libraryPath, this.staticLibraries);
            return paths;
        };
    }

    PropertyOptions {
        name: "prefix"
        description: "Первичный путь до библиотеки"
    }
    PropertyOptions {
        name: "version"
        description: "Версия библиотеки, учавствует в формировании пути до библиотеки"
    }
    PropertyOptions {
        name: "includeSuffix"
        description: "Используется при формировании пути до header-файлов библиотеки"
    }
    PropertyOptions {
        name: "libSuffix"
        description: "Используется при формировании пути до бинарных файлов библиотеки"
    }
    PropertyOptions {
        name: "useSystem"
        description: "Признак использования системной библиотеки"
    }
    PropertyOptions {
        name: "dynamicLibraries"
        description: "Список динамических бинарных файлов библиотеки"
    }
    PropertyOptions {
        name: "staticLibraries"
        description: "Список статических бинарных файлов библиотеки"
    }
    PropertyOptions {
        name: "systemIncludePaths"
        description: "Список системных путей где могут быть расположены \
                      header-файлы библиотеки. Список используется для проверки \
                      наличия библиотеки в системе"
    }
    PropertyOptions {
        name: "checkingHeaders"
        description: "Список header-файлов, которые используются для проверки \
                      установлена ли библиотека"
    }
}
