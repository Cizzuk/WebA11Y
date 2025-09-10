'use strict';

browser.runtime.onMessage.addListener((request, sender) => { insertCSS(sender.tab.id); });
browser.tabs.onActivated.addListener((tabData) => { insertCSS(tabData.tabId); });
browser.tabs.onUpdated.addListener((tabId, changeInfo) => {
    if (changeInfo.status === 'complete' || changeInfo.url) {
        insertCSS(tabId);
    }
});

function insertCSS(tabId) {
    browser.runtime.sendNativeMessage("com.tsg0o0.safariweba11y.Extension", function(response) {
        const resData = JSON.parse(response);
        if (resData.type != "run" || !resData.style) {
            console.log("[WebA11Y] Canceled");
            return;
        }
        
        console.log("[WebA11Y] Trying to insert CSS:", resData.style);
        browser.scripting.insertCSS({
            target: {
                tabId: tabId,
            },
            origin: "author",
            css: resData.style,
        }).catch((err) => {
            console.error("[WebA11Y] Error inserting CSS:", err);
        });
        
        return;
    });
}
