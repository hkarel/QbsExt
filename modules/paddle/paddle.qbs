/*****************************************************************************
  Модуль подключения paddle-framework

*****************************************************************************/

import qbs
import qbs.File
import QbsUtl

Module {
    id: paddle
    Depends { name: "cpp" }

    property string prefix: "/opt/paddle"
    property string version: "2.1"

    property pathList includePaths: [
        prefix + "/" + version + "/paddle/include",
        prefix + "/" + version + "/third_party/install",
        prefix + "/" + version + "/third_party/install/glog/include"
    ]

    property string glogLibPath:   prefix + "/" + version + "/third_party/install/glog/lib"
    property string mkldnnLibPath: prefix + "/" + version + "/third_party/install/mkldnn/lib"
    property string mklmlLibPath:  prefix + "/" + version + "/third_party/install/mklml/lib"
    property string paddleLibPath: prefix + "/" + version + "/paddle/lib"

    property pathList libraryPaths: [
        glogLibPath,
        mklmlLibPath,
        mkldnnLibPath,
        paddleLibPath
    ]

    property var dynamicLibraries: [
        "glog",
        "iomp5",
        "dnnl",
        //"mklml_intel",
        "paddle_inference",
    ]

    property var staticLibraries: [
        prefix + "/" + version + "/third_party/install/gflags/lib/libgflags.a",
        prefix + "/" + version + "/third_party/install/protobuf/lib/libprotobuf.a",
        prefix + "/" + version + "/third_party/install/cryptopp/lib/libcryptopp.a",
        prefix + "/" + version + "/third_party/install/xxhash/lib/libxxhash.a",
    ]

    property var probe: {
        return function(productName) {
            var msg = "Invalid dependency module '{0}'. {1} not found: {2}" +
                      ". Possibly incorrect assigned library version: {3}";
            var err = new Error;
            err.productName = productName;

            var paddleDir = prefix + "/" + version;
            if (!File.exists(paddleDir)) {
                err.message = msg.format(name, "Directory", paddleDir, version);
                throw err;
            }
        };
    }
}
