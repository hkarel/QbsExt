/*****************************************************************************
  В модуле определены пути до библиотеки Guardant

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: guardant
    version: "2.x"
    prefix: "/opt/guardant"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/guardant"
    }
    checkingHeaders:  ["grdapi.h"]
    dynamicLibraries: ["grdapi"]
    staticLibraries:  ["grdapi"]
}
