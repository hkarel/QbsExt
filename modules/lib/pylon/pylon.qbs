/*****************************************************************************
  В модуле определены пути до библиотеки BASLER/Pylon.

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: pylon
    version: "5.0.x"
    prefix: "/opt/pylon"
    libSuffix: "/lib64"
}
