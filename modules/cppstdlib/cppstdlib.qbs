/*****************************************************************************
  Модуль используется для получения пути до библиотеки libstdc++
  для с++ компилятора указанного в параметре cpp.compilerPath
*****************************************************************************/

import qbs
import qbs.Process

Module {
    Probe {
        id: libstdProbe
        property string path: ""
        readonly property string cppCompilerPath: cpp.compilerPath
        configure: {
            var process = new Process();
            try {
                if (process.exec(cppCompilerPath, ["--print-file-name=libstdc++.a"], false) === 0) {
                    path = process.readLine().trim();
                    path = path.replace("/libstdc++.a", "");
                }
            }
            finally {
                process.close();
            }
            //console.info("=== cppLibstdPath ===");
            //console.info(path);
        }
    }
    property string path: libstdProbe.path
}
