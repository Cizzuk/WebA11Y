"use strict";

let completedFlags = {};
let boldText = false;
let buttonShape = false;
let fontChange = false;
let fontFamily = "sans-serif";

browser.runtime.sendMessage({ type: "content" },
    function(response) {
        boldText = response.boldText;
        buttonShape = response.buttonShape;
        fontChange = response.fontChange;
    
        if (response.fontFamily != "sans-serif") {
            fontFamily = response.fontFamily + ", sans-serif";
        } else {
            fontFamily = response.fontFamily;
        }
        
        console.log("WebA11Y: Loaded");
        complete("response");
    }
);

document.addEventListener('DOMContentLoaded', function() {
    complete("interactive");
});

function complete(flag) {
    completedFlags[flag] = true;
    console.log(completedFlags);
    if (completedFlags["response"] && completedFlags["interactive"]) {
        // After receiving settings and loading the page
        doA11Y();
    }
}

function doA11Y() {
    let customStyle = "";
    let styleElement = document.createElement("style");
    
    if (boldText == true) {
        customStyle += "* { font-weight: bold !important; }";
    }
    if (buttonShape == true) {
        customStyle += "a, button { text-decoration: underline !important; }";
    }
    if (fontChange == true) {
        customStyle += "* { font-family: " + fontFamily + " !important; }";
    }
    
    styleElement.appendChild(document.createTextNode(customStyle));
    document.body.appendChild(styleElement);
}
