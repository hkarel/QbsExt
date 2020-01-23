/*****************************************************************************
  В модуле определены пути до библиотеки TensorRt

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: tensorrt
    version: "7.0.0.x"
    prefix: "/opt/tensorrt"
    checkingHeaders: ["NvInfer.h"]
}
