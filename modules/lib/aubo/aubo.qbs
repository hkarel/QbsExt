/*****************************************************************************
  В модуле определены пути до библиотеки SDK AUBO

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "0.23.x"
    prefix: "/opt/aubo"
    checkingHeaders: [
        "AuboRobotMetaType.h",
        "robotiomatetype.h",
        "serviceinterface.h",
    ]
}
