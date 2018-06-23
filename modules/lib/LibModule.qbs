/*****************************************************************************
 Базовый модуль, используется для описания и подключения сторонних библиотек.

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
    property stringList checkingHeaders: []

    property var probe: {
        return function() {
            if (!enabled)
                return;

            if (useSystem
                && checkingHeaders !== undefined
                && systemIncludePaths !== undefined) {
                for (var i = 0; i < checkingHeaders.length; ++i) {
                    var notFound = true;
                    for (var j = 0; j < systemIncludePaths.length; ++j) {
                        var headerPath = systemIncludePaths[j] + "/" + checkingHeaders[i];
                        if (File.exists(headerPath)) {
                            notFound = false;
                            break;
                        }
                    }
                    if (notFound === true) {
                        var msg = "Module {0}: header file '{1}' not found in system paths. " +
                                  "Possibly library is not installed.";
                        throw new Error(msg.format(name, checkingHeaders[i]));
                    }
                }
            }
            else {
                var msg = "Module {0}: directory '{1}' not found. " +
                          "Possibly incorrect assigned version ({2}).";
                if (!File.exists(includePath))
                    throw new Error(msg.format(name, includePath, version));

                if (!File.exists(libraryPath))
                    throw new Error(msg.format(name, libraryPath, version));

                if (checkingHeaders !== undefined)
                    for (var i = 0; i < checkingHeaders.length; ++i) {
                        var headerPath = includePath + "/" + checkingHeaders[i];
                        if (!File.exists(headerPath)) {
                            msg = "Module {0}: header file '{1}' not found. " +
                                  "Possibly library is not installed.";
                            throw new Error(msg.format(name, headerPath));
                        }
                    }
            }
        };
    }

    property var staticLibrariesPaths: {
        return function(product) {
            var paths = [];
            if (enabled)
                paths = QbsUtl.staticLibrariesPaths(product, libraryPath, staticLibraries);
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
