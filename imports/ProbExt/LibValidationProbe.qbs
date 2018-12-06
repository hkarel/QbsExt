/*****************************************************************************
  Проба выполняет проверку библиотеки на соответствие требуемым параметрам

*****************************************************************************/

Probe {
    // Input
    property var checkingLibs: []

    readonly property string productName: product.name
    configure: {
        for (var i in checkingLibs)
            checkingLibs[i].probe(productName);
    }
}
