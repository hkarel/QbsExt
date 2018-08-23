/*****************************************************************************
  В модуле определены пути до библиотеки openblas

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: openblas
    prefix: "/opt/openblas"
    version: "0.2.x"
    checkingHeaders: ["cblas.h"]
    staticLibraries: ["openblas"]
}
