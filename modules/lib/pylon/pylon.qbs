/*****************************************************************************
  В модуле определены пути до библиотеки BASLER/Pylon

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "6.0.x"
    prefix: "/opt/pylon"
    libSuffix: "/lib"
    //Properties {
    //    condition: (qbs.architecture === "x86_64")
    //    libSuffix: "/lib64"
    //}
    checkingHeaders: ["pylon/PylonBase.h"]
}
