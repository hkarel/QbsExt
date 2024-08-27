/*****************************************************************************
  В модуле определены пути до библиотеки HikVision

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "6.1.x.x"
    prefix: "/opt/hikvision"
    checkingHeaders: [
        "HCNetSDK.h",
    ]
}
