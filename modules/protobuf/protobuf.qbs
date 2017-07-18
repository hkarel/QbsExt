import qbs
import qbs.File
import qbs.FileInfo
import qbs.ModUtils

Module {
    id: protobuf
    Depends { name: "cpp" }

    property string generatedFilesSubDir: ""
    property string generatedFilesDir: {
        return product.buildDirectory + "/" + generatedFilesSubDir;
    }

    PropertyOptions {
        name: "generatedFilesSubDir"
        description: "Наименование суб-директории в которой будут размещены \
                      сгенерированные файлы"
    }

    validate: {
        if (!File.exists("/usr/bin/protoc"))
            throw new Error("Protobuf compiler not found. Possibly need \
                             to install packet 'protobuf-compiler'");
    }

    FileTagger {
        patterns: "*.proto"
        fileTags: ["protobuf"]
    }

    Rule {
        inputs: ["protobuf"]
        outputFileTags: ["cpp", "hpp"]
        outputArtifacts: {
            //var generatedFilesDir = ModUtils.moduleProperty(product, "generatedFilesDir");
            var generatedFilesDir = product.protobuf.generatedFilesDir;
            return [{
                filePath: generatedFilesDir + "/" + input.baseName + ".pb.h",
                fileTags: ["hpp"],
            },{
                filePath: generatedFilesDir + "/" + input.baseName + ".pb.cc",
                fileTags: ["cpp"],
            }];
        }
        prepare: {
            //var generatedFilesDir = ModUtils.moduleProperty(product, "generatedFilesDir");
            var generatedFilesDir = product.protobuf.generatedFilesDir;
            var cmd = new Command("/usr/bin/protoc", ["--cpp_out", generatedFilesDir, input.fileName]);
            cmd.workingDirectory = FileInfo.path(input.filePath);
            cmd.description = "protobuf code generation";
            cmd.highlight = "codegen";
            return cmd;
        }
    }
}
