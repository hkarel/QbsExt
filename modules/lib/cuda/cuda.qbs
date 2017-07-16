/*****************************************************************************
  В модуле определены пути до библиотеки CUDA

*****************************************************************************/

import qbs
import qbs.File
import QbsUtl

Module {
    id: cuda

    property string prefix: "/usr/local"
    property string version: "8.x"

    property path includePath: prefix + "/cuda-" + version + "/include"
    property path libraryPath: prefix + "/cuda-" + version + "/lib64"

    property var probe: {
        return function() {
            var msg = "Module {0}: directory '{1}' not found. Possibly incorrect assigned version ({2}).";
            if (!File.exists(includePath))
                throw msg.format(name, includePath, version);

            if (!File.exists(libraryPath))
                throw msg.format(name, libraryPath, version);
        };
    }
}
