/*****************************************************************************
  Модуль генератора flex

*****************************************************************************/

import qbs
import qbs.File
import qbs.ModUtils

Module {
    id: flex

    // Input
    property string prefix: undefined
    property bool   reentrant: false
    property string generatedFilesSubDir: "flex.gen"

    // Output
    property string generatedFilesDir: {
        return product.buildDirectory + "/" + generatedFilesSubDir;
    }

    PropertyOptions {
        name: "prefix"
        description: "Использовать prefix вместо 'yy' при генерации функций"
    }
    PropertyOptions {
        name: "reentrant"
        description: "Генерировать реентерабельный C сканер (см. документацию flex)"
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
        if (!File.exists("/usr/bin/flex"))
            throw new Error("Flex generator not found. Possibly need \
                             to install packet 'flex'");
    }

    FileTagger {
        patterns: "*.ll"
        fileTags: ["flex"]
    }

    Rule {
        inputs: ["flex"]

        Artifact {
            filePath: product.flex.generatedFilesDir + "/" + input.baseName + ".cpp"
            fileTags: ["cpp"]
        }

        prepare: {
            var generatedFilesDir = product.flex.generatedFilesDir;
            var flexPrefix = ModUtils.moduleProperty(input, "prefix");
            var flexReentrant = ModUtils.moduleProperty(input, "reentrant");

            var args = [];
            if (flexReentrant)
                args.push("--reentrant");

            if (flexPrefix !== undefined) {
                args.push("-P");
                args.push(flexPrefix);
            }

            args.push("-o");
            args.push(generatedFilesDir + "/" + input.baseName + ".cpp");
            args.push(input.filePath);

            File.makePath(generatedFilesDir);

            //console.info("flex: " + args)

            var cmd = new Command("/usr/bin/flex", args);
            cmd.description = "flex code generation";
            cmd.highlight = "codegen";
            return cmd;
        }
    }
}
