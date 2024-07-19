import { stopEverything } from './utils/events';
export const Utils = {
    getMetaContent,
    getCookieValue,
    preventInsignificantClick
};
function isInsignificantClick(event) {
    return (((event.target != null) && event.target.isContentEditable) ||
        event.defaultPrevented ||
        event.button > 0 || // Only left clicks!
        event.altKey ||
        event.ctrlKey ||
        event.metaKey ||
        event.shiftKey);
}
function isSignificantClick(event) {
    return !isInsignificantClick(event);
}
function preventInsignificantClick(event) {
    if (isSignificantClick(event))
        return;
    stopEverything(event);
}
function getCookieValue(cookieName) {
    if (cookieName != null) {
        const cookies = document.cookie.trim() !== '' ? document.cookie.split('; ') : [];
        const cookie = cookies.find((cookie) => cookie.startsWith(cookieName));
        if (cookie != null) {
            const value = cookie.split('=').slice(1).join('=');
            return (value.trim() !== '' ? decodeURIComponent(value) : null);
        }
    }
    return null;
}
function getMetaContent(str) {
    var _a;
    const element = document.querySelector(`meta[name="${str}"]`);
    return (_a = element === null || element === void 0 ? void 0 : element.content) !== null && _a !== void 0 ? _a : null;
}
//# sourceMappingURL=utils.js.map