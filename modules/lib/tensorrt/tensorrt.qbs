/*****************************************************************************
  В модуле определены пути до библиотеки TensorRt

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "8.x.x.x"
    prefix: "/opt/tensorrt"
    checkingHeaders: ["NvInfer.h"]
}
