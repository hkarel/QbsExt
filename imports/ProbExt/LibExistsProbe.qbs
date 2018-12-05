/*****************************************************************************
  Проба используется для отключения продукта если требуемой библиотеки
  нет в системе
*****************************************************************************/

Probe {
    // Input
    property var checkingLibs: []

    // Output
    property bool value: true

    readonly property string productName: product.name
    configure: {
        try {
            for (var i in checkingLibs)
                checkingLibs[i].probe(productName);
        }
        catch (err) {
            value = false;
            var msg = "Warning: Product '{0}' is disabled; {1}";
            console.info(msg.format(err.productName, err.message));
        }
    }
}
