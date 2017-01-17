var File = loadExtension("qbs.File");
var Process = loadExtension("qbs.Process");

function ar(toolchainPathPrefix)
{
    return File.exists(toolchainPathPrefix + "/gcc-ar") ? "gcc-ar" : "ar";
}

// Функция возвращает директорию расположения библиотеки libstdc++
// для с++ компилятора указанного в параметре cppCompilerPath.
function compilerLibraryPath(cppCompilerPath)
{
    var libPath = "";
    var process = new Process();
    if (process.exec(cppCompilerPath, ["--print-file-name=libstdc++.a"], false) === 0)
        libPath = process.readLine().trim();
    return libPath.replace("/libstdc++.a", "");
}
