var tsg0o0_weba11y_loadedFlag = false;
var tsg0o0_weba11y_styleE = document.createElement('style');
var tsg0o0_weba11y_cssCode = '';

var tsg0o0_weba11y_boldText = "false";
var tsg0o0_weba11y_buttonShape = "false";
var tsg0o0_weba11y_fontChange = "false";
var tsg0o0_weba11y_fontFamily = "sans-serif";

browser.runtime.onMessage.addListener(handleMessage);
function handleMessage(request, sender, sendResponse) {
    console.log(request["data"]);
    
}

browser.runtime.sendMessage({
    type: "content"
},
    function(response) {
    tsg0o0_weba11y_boldText = response.boldText;
    tsg0o0_weba11y_buttonShape = response.buttonShape;
    tsg0o0_weba11y_fontChange = response.fontChange;
    if (response.fontFamily != "sans-serif") {
        tsg0o0_weba11y_fontFamily = response.fontFamily + ", sans-serif";
    }else{
        tsg0o0_weba11y_fontFamily = response.fontFamily;
    }
    
    console.log("WebA11Y: Loaded");
    
    tsg0o0_weba11y_start();
});

window.onload = function() {
    tsg0o0_weba11y_start();
}

function tsg0o0_weba11y_start() {
    if (tsg0o0_weba11y_loadedFlag == true) {
        tsg0o0_weba11y_doA11Y();
    }else{
        tsg0o0_weba11y_loadedFlag = true;
    }
}

function tsg0o0_weba11y_doA11Y() {
    
    if (tsg0o0_weba11y_boldText == "true") {
        tsg0o0_weba11y_cssCode += '* { font-weight: bold !important; }';
    }
    if (tsg0o0_weba11y_buttonShape == "true") {
        tsg0o0_weba11y_cssCode += 'a, button { text-decoration: underline !important; }';
    }
    if (tsg0o0_weba11y_fontChange == "true") {
        tsg0o0_weba11y_cssCode += '* { font-family: ' + tsg0o0_weba11y_fontFamily + ' !important; }';
    }
    
    tsg0o0_weba11y_styleE.appendChild(document.createTextNode(tsg0o0_weba11y_cssCode));
    document.body.appendChild(tsg0o0_weba11y_styleE);
}
