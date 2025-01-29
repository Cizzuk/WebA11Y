browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.type == "content") {
        browser.runtime.sendNativeMessage("com.tsg0o0.safariweba11y.Extension", function(response) {
            const Data = JSON.parse(response);
            sendResponse(Data);
            return;
        });
    }
    return true;
});
