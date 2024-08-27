/*****************************************************************************
  В модуле определены пути до библиотеки caffe

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    version: "1.0.x"
    prefix: "/opt/caffe"
    checkingHeaders: ["caffe/caffe.hpp"]
}
