/*****************************************************************************
  В модуле определены пути до библиотеки CUDA

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: cuda
    version: "cuda-11.x"
    prefix: "/usr/local"
    libSuffix: "/lib64"
    checkingHeaders:  ["cuda.h"]
}
