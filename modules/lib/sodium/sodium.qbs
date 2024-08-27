/*****************************************************************************
  В модуле определены пути до библиотеки Sodium

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "1.0.x"
    prefix: "/opt/sodium"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/sodium"
    }
    checkingHeaders:  ["sodium.h"]
    dynamicLibraries: ["sodium"]
    staticLibraries:  ["sodium"]
}
