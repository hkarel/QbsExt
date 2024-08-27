/*****************************************************************************
  В модуле определены пути до библиотеки cuDNN

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "8.x.x"
    prefix: "/opt/cudnn"
    checkingHeaders:  ["cudnn.h"]
    dynamicLibraries: ["cudnn"]
}
