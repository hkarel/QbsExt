/*****************************************************************************
  В модуле определены пути до библиотеки OnnxRuntime.
  Используется для работы с onnx-моделями на CPU.

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: onnxruntime
    version: "1.x.x"
    prefix: "/opt/onnxruntime"
    checkingHeaders:  ["onnxruntime/core/session/onnxruntime_cxx_api.h"]
    dynamicLibraries: ["onnxruntime"]
}
