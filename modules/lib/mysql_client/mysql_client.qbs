/*****************************************************************************
  В модуле определены пути до библиотеки mysql_client

*****************************************************************************/

import qbs
import '../LibModule.qbs' as LibModule

LibModule {
    id: mysql_client
    prefix: "/opt/mysql-connector-c"
    version: "6.0.x";
}
