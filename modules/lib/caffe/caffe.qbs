/*****************************************************************************
  В модуле определены пути до библиотеки caffe

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: caffe
    prefix: "/opt/caffe"
    version: "1.0.x"
}
