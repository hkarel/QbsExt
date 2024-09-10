/*****************************************************************************
  В модуле определены пути до библиотеки Guardant

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "3.x"
    prefix: "/opt/guardant"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/guardant"
    }
    checkingHeaders: {
        return (version[0] >= '3') ? ["grdlic.h"] : ["grdapi.h"];
    }
    dynamicLibraries: {
        return (version[0] >= '3') ? ["grdlic"] : ["grdapi"];
    }
    staticLibraries: {
        return (version[0] >= '3') ? ["grdlic"] : ["grdapi"];
    }
}
