let _safariweba11y_data = {};
browser.runtime.sendMessage({ type: "content" }, function(response) {
    if (response.type != "run" || !response.style) {
        return;
    }
    
    _safariweba11y_data["style"] = response.style;
    _safariweba11y_complete("response");
});

document.addEventListener('DOMContentLoaded', function() {
    _safariweba11y_complete("interactive");
});

function _safariweba11y_complete(flag) {
    _safariweba11y_data[flag] = true;
    if (_safariweba11y_data["response"] && _safariweba11y_data["interactive"] && !_safariweba11y_data["done"]) {
        let customStyle = _safariweba11y_data["style"];
        try {
            let styleSheet = document.styleSheets.item(0);
            styleSheet.insertRule(customStyle, styleSheet.cssRules.length);
        } catch {
            let styleElement = document.createElement("style")
            styleElement.appendChild(document.createTextNode(customStyle));
            document.body.appendChild(styleElement);
        }
        _safariweba11y_data["done"] = true;
    }
}
