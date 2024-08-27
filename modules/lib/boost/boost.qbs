/*****************************************************************************
  В модуле определены пути до библиотеки boost

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "1.55.x"
    prefix: "/opt/boost"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/boost"
        includeSuffix: ""
        libSuffix: ""
    }
}
