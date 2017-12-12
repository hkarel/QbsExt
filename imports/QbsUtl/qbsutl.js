var File = require("qbs.File");
var TextFile = require("qbs.TextFile");
var Process = require("qbs.Process");
var ModUtils = require("qbs.ModUtils");

// Расширяет наименование статических библиотек полным путем до них
function staticLibrariesPaths(product, path, libraries)
{
    if (path === undefined)
        return [];

    var libs = [];
    var staticLibraryPrefix = product.cpp.staticLibraryPrefix;
    var staticLibrarySuffix = product.cpp.staticLibrarySuffix;

    for (var i in libraries)
        libs.push(path + "/" + staticLibraryPrefix + libraries[i] + staticLibrarySuffix);
    return libs;
}

function concatPaths()
{
//    var paths = [];
//    for (var i = 0; i < arguments.length; ++i) {
//        if (arguments[i] === undefined)
//            continue;
//        else if (arguments[i] instanceof Array)
//            paths = paths.concat(arguments[i]);
//        else
//            paths.push(arguments[i]);
//    }
//    return paths;

    return ModUtils.concatAll.apply(null, arguments);
}

// Расширяет тип String функцией форматирования.
// Источник: http://www.helpful-stuff.ru/2013/08/method-string-format-javascript.html
// Использование: "Test formattind {0}, {1}".format(123, "string")
String.prototype.format = function () {
    var args = arguments;
    return this.replace(/\{\{|\}\}|\{(\d+)\}/g, function (m, n) {
        if (m === "{{") { return "{"; }
        if (m === "}}") { return "}"; }
        return args[n];
    });
};

// Функция возвращает информацию о версии проекта в виде массива из четырех эле-
// ментов. В качестве входящего параметра используется полное имя файла с версией.
// Информация о версии должна быть записана в виде: 'major.minor.patch'.
// Результирующий массив имеет следующие элементы:
// 0 - версия проекта в формате major.minor.patch
// 1 - major версия
// 2 - minor версия
// 3 - patch (версия исправлений)
function getVersions(filePath)
{
    //var filePath = project.sourceDirectory + "/VERSION";
    if (!File.exists(filePath))
        throw new Error(("File '{0}' not found").format(filePath));

    var file = new TextFile(filePath, TextFile.ReadOnly);
    try {
        var verStr = file.readLine().trim();
        var regex = /^\d+\.\d+\.\d+$/
        var r = verStr.match(regex);
        if (r === null) {
            var msg =  "Incorrect version format. Must be: 'major.minor.patch'. See file {0}";
            throw new Error(msg.format(filePath));
        }
        var verParts = verStr.split('.').map(function(item){return parseInt(item, 10);});
        return [verStr, verParts[0], verParts[1], verParts[2]];
    }
    finally {
        file.close();
    }
}

// Функция возвращает ревизию проекта, которая представляет из себя идентификатор
// текущего хеш-коммита из GIT.
// gitDirectory - корневая директория git-репозитория
function gitRevision(gitDirectory)
{
    var revision = "";
    var process = new Process();
    try {
        process.setWorkingDirectory(gitDirectory);
        if (process.exec("git", ["log", "-1", "--pretty=%h"], false) === 0)
            revision = process.readLine().trim();
        return revision;
    }
    finally {
        process.close();
    }
}
