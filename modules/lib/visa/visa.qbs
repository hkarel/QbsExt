/*****************************************************************************
  В модуле определены пути до библиотеки VISA National Instruments.
  Испульзуется для обмена SCPI командами с GPIB устройствами.

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: rsvisa
    version: "7.x"
    prefix: "/opt/visa"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/rsvisa"
    }
    checkingHeaders:  ["visa.h"]
    dynamicLibraries: ["visa"]
}
