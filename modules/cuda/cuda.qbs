/*****************************************************************************
  Модуль подключения cuda-компилятора

*****************************************************************************/

import qbs
import qbs.File
import qbs.FileInfo
import qbs.ModUtils
import qbs.Utilities

Module {
    id: cuda
    Depends { name: "cpp" }

    property bool   enabled: true
    property string prefix: "/usr/local"
    property string version: "8.x"
    property string gpuArchitecture: ""

    property path includePath: enabled ? prefix + "/cuda-" + version + "/include" : undefined
    property path libraryPath: enabled ? prefix + "/cuda-" + version + "/lib64" : undefined
    property path nvccPath:    enabled ? prefix + "/cuda-" + version + "/bin/nvcc" : undefined

    property var dynamicLibraries: []

    property var probe: {
        return function(productName) {
            if (!enabled)
                return

            var msg = "Invalid dependency module '{0}'; {1} not found: {2}; " +
                      "Possibly incorrect assigned library version: {3}";
            var err = new Error;
            err.productName = productName;

            if (!File.exists(includePath)) {
                err.message = msg.format(name, "Directory", includePath, version);
                throw err;
            }

            if (!File.exists(libraryPath)) {
                err.message = msg.format(name, "Directory", libraryPath, version);
                throw err;
            }

            if (!File.exists(nvccPath)) {
                err.message = msg.format(name, "File", nvccPath, version);
                throw err;
            }

            if (gpuArchitecture.length === 0) {
                msg = "Invalid dependency module '{0}'; Undefined parameter: gpuArchitecture";
                err.message = msg.format(productName. name)
                throw err;
            }
        };
    }

    PropertyOptions {
        name: "gpuArchitecture"
        allowedValues: ['sm_20','sm_21','sm_30','sm_32','sm_35','sm_37',
                        'sm_50','sm_52','sm_53','sm_60','sm_61','sm_62']
        description: "Архитектура GPU процессора"
    }

    FileTagger {
        patterns: "*.cu"
        fileTags: ["cuda"]
    }

    Rule {
        condition: enabled
        id: cudaCompiler
        inputs: ["cuda"]
        auxiliaryInputs: ["hpp"]

        Artifact {
            fileTags: ["obj"]
            filePath: FileInfo.joinPaths(".obj", Utilities.getHash(input.baseDir), input.fileName + ".o")
        }

        prepare: {
            var gccArgs = [];

            var positionIndependentCode = input.cpp.positionIndependentCode;
            if (positionIndependentCode)
                gccArgs.push('-fPIC');

            if (input.cpp.debugInformation)
                gccArgs.push('-g');

            var opt = input.cpp.optimization
            if (opt === 'fast')
                gccArgs.push('-O2');
            if (opt === 'small')
                gccArgs.push('-Os');
            if (opt === 'none')
                gccArgs.push('-O0');

            var warnings = input.cpp.warningLevel
            if (warnings === 'none')
                gccArgs.push('-w');
            if (warnings === 'all') {
                gccArgs.push('-Wall');
                gccArgs.push('-Wextra');
            }

            gccArgs.push('-Wno-unused-parameter');
            gccArgs.push('-Wno-sign-compare');

            var includePaths = input.cpp.includePaths;
            if (includePaths) {
                gccArgs = gccArgs.concat([].uniqueConcat(includePaths).map(function(path) {
                    return input.cpp.includeFlag + path;
                }));
            }

            var systemIncludePaths = input.cpp.systemIncludePaths;
            if (systemIncludePaths) {
                gccArgs = gccArgs.concat([].uniqueConcat(systemIncludePaths).map(function(path) {
                    return input.cpp.systemIncludeFlag + path;
                }));
            }

            //console.info("=== gccAargs ===");
            //console.info(gccAargs.join(','));
            //console.info("=== product.moduleName ===");
            //console.info(product.moduleName);
            //console.info("=== product.cuda.gpuArchitecture ===");
            //console.info(product.cuda.gpuArchitecture);

            //var args = ['-v'];
            var args = [];
            args.push('-std=c++11');

            //var gpuArchitecture = ModUtils.moduleProperty(product, "gpuArchitecture");
            var gpuArchitecture = product.cuda.gpuArchitecture;
            args.push("--gpu-architecture", gpuArchitecture);

            var cppCompilerDir = FileInfo.path(input.cpp.compilerPath);
            args.push("--compiler-bindir", cppCompilerDir);

            // -Xcompiler
            args.push("--compiler-options", gccArgs.join(','));

            args.push("-o", output.filePath);
            args.push("-c", input.filePath);

            //console.info(args.join(' '));

            var cudaCompilerPath = product.cuda.nvccPath;
            var cmd = new Command(cudaCompilerPath, args);
            cmd.description = 'cuda compiling ' + input.fileName;
            cmd.highlight = "compiler";
            return cmd;
        }
    }
}
