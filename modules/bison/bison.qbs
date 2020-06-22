/*****************************************************************************
  Модуль генератора bison

*****************************************************************************/

import qbs
import qbs.File
import qbs.ModUtils

Module {
    id: bison

    // Input
    property string prefix: undefined
    property string generatedFilesSubDir: "bison.gen"

    // Output
    property string generatedFilesDir: {
        return product.buildDirectory + "/" + generatedFilesSubDir;
    }

    PropertyOptions {
        name: "prefix"
        description: "Добавляет prefix при генерации внешних символов"
    }
    PropertyOptions {
        name: "generatedFilesSubDir"
        description: "Наименование суб-директории в которой будут размещены \
                      сгенерированные файлы"
    }
    PropertyOptions {
        name: "generatedFilesDir"
        description: "Директория в которой будут размещены сгенерированные файлы"
    }

    validate: {
        if (!File.exists("/usr/bin/bison"))
            throw new Error("Bison generator not found. Possibly need \
                             to install packet 'bison'");
    }

    FileTagger {
        patterns: "*.yy"
        fileTags: ["bison"]
    }

    Rule {
        inputs: ["bison"]
        outputFileTags: ["cpp", "hpp", "bison_output" ]
        outputArtifacts: {
            var generatedFilesDir = product.bison.generatedFilesDir;
            return [{
                filePath: generatedFilesDir + "/" + input.baseName + ".hpp",
                fileTags: ["hpp"],
            },{
                filePath: generatedFilesDir + "/" + input.baseName + ".cpp",
                fileTags: ["cpp"],
            },{
                filePath: generatedFilesDir + "/" + input.baseName + ".output",
                fileTags: ["bison_output"],
            }];
        }
        prepare: {
            var generatedFilesDir = product.bison.generatedFilesDir;
            var bisonPrefix = ModUtils.moduleProperty(input, "prefix");

            var args = ["-d", "-v", "-t"];
            if (bisonPrefix !== undefined) {
                args.push("-p");
                args.push(bisonPrefix);
            }

            args.push("-o");
            args.push(generatedFilesDir + "/" + input.baseName + ".cpp");
            args.push(input.filePath);

            File.makePath(generatedFilesDir);

            var cmd = new Command("/usr/bin/bison", args);
            cmd.workingDirectory = generatedFilesDir;
            cmd.description = "bison code generation";
            cmd.highlight = "codegen";
            return cmd;
        }
    }
}
