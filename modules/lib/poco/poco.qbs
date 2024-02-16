/*****************************************************************************
  В модуле определены пути до библиотеки poco

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: poco
    version: "1.13.x"
    prefix: "/opt/poco"
    checkingHeaders: ["Poco/Version.h"]
}
