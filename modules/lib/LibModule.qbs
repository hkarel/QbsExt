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

    property path includePath: (useSystem || !enabled) ? undefined : prefix + "/" + version + includeSuffix
    property path libraryPath: (useSystem || !enabled) ? undefined : prefix + "/" + version + libSuffix

    property var dynamicLibraries: []
    property var staticLibraries: []

    property var probe: {
        return function() {
            if (useSystem || !enabled)
                return;
            var msg = "Module {0}: directory '{1}' not found. Possibly incorrect assigned version ({2}).";
            if (!File.exists(includePath))
                throw new Error(msg.format(name, includePath, version));

            if (!File.exists(libraryPath))
                throw new Error(msg.format(name, libraryPath, version));
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

}
