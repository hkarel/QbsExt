/*****************************************************************************
  В модуле определены пути до библиотеки FaceSDK

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    prefix: "/opt/facesdk"
    version: "1.10.x"
    Properties {
        condition: qbs.targetOS.contains("windows")
                   && qbs.toolchain && qbs.toolchain.contains("mingw")
        prefix: "c:/opt/facesdk"
    }
}
