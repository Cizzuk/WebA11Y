'use strict';

browser.runtime.onMessage.addListener((request, sender) => { insertCSS(sender.tab.id); });
browser.tabs.onActivated.addListener((tabData) => { insertCSS(tabData.tabId); });
browser.tabs.onUpdated.addListener((tabId, changeInfo) => {
    if (changeInfo.status === 'complete' || changeInfo.url) {
        insertCSS(tabId);
    }
});

const insertCSS = (tabId) => {
    browser.runtime.sendNativeMessage("com.tsg0o0.safariweba11y.Extension", function(response) {
        const resData = JSON.parse(response);
        if (resData.type != "run" || !resData.style) {
            console.log(tabId, "Canceled");
            return;
        }
        
        console.log(tabId, "Trying to insert CSS:", resData.style);
        browser.scripting.insertCSS({
            target: {
                tabId: tabId,
            },
            origin: "USER",
            css: resData.style,
        })
        .then(() => {
            console.log(tabId, "CSS inserted successfully");
        })
        .catch((err) => {
            console.error(tabId, "Error inserting CSS:", err);
        });
        
        return;
    });
};
