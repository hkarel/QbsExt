/*****************************************************************************
  Проба возвращает информацию о наименовании и версии Linux-дистрибутива.

*****************************************************************************/

import qbs
import qbs.File
import qbs.TextFile

Probe {
    //id: osProbe
    property string osName: undefined
    property string osVersion: undefined

    configure: {
        if (qbs.hostOS.containsAny(["linux", "unix"])) {
            var confFile = "/etc/os-release"
            if (File.exists(confFile)) {
                var file = new TextFile(confFile, TextFile.ReadOnly);
                try {
                    var regex1 = /^ID=(.*)$/
                    var regex2 = /^VERSION_ID="?([^"]*)"?$/
                    while (true) {
                        var line = file.readLine();
                        if (!line)
                            break;

                        var rmatch;
                        if (osName === undefined) {
                            rmatch = line.match(regex1);
                            if (rmatch !== null)
                                osName = rmatch[1];
                        }
                        if (osVersion === undefined) {
                            rmatch = line.match(regex2);
                            if (rmatch !== null)
                                osVersion = rmatch[1];
                        }
                    }
                }
                finally {
                    file.close();
                }
            }
        }
        else {
            osName = qbs.hostOS[0];
            osVersion = qbs.hostOSVersion;
        }

        if (osName === undefined)
            throw new Error("OS name is undefined");
        if (osVersion === undefined)
            throw new Error("OS version is undefined");

        //console.info("=== osName ===");
        //console.info(osName);
        //console.info("=== osVersion ===");
        //console.info(osVersion);
    }
}
