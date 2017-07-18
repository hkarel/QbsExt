/*****************************************************************************
 Базовый модуль, используется для описания и подключения сторонних библиотек.

*****************************************************************************/

import qbs
import qbs.File
import QbsUtl

Module {
    property string prefix
    property string version
    property bool enabled: true

    // Признак использования системной библиотеки
    property bool useSystem: false

    property string includeSuffix: "/include"
    property string libSuffix: "/lib"

    property path includePath: (useSystem || !enabled) ? undefined : prefix + "/" + version + includeSuffix
    property path libraryPath: (useSystem || !enabled) ? undefined : prefix + "/" + version + libSuffix

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
}
