/*****************************************************************************
  В модуле определены пути до библиотеки Sodium

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: sodium
    version: "1.0.x"
    prefix: "/opt/sodium"
    checkingHeaders: ["sodium.h"]
}
