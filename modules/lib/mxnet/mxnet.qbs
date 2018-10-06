/*****************************************************************************
  В модуле определены пути до библиотеки mxnet

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: mxnet
    version: "1.3.x"
    prefix: "/opt/mxnet"
    checkingHeaders: ["mxnet/base.h"]
}
