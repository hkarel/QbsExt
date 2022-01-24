/*****************************************************************************
  В модуле определены пути до библиотеки Daheng/Galaxy

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: galaxy
    version: "1.x.x"
    prefix: "/opt/galaxy"
    includeSuffix: "/inc"
    libSuffix: "/lib/x86"
    Properties {
       condition: (qbs.architecture === "x86_64")
       libSuffix: "/lib/x86_64"
    }
    checkingHeaders:  ["GxIAPI.h"]
    dynamicLibraries: ["gxiapi"]
}
