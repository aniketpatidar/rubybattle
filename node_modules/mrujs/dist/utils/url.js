export function expandUrl(locateable) {
    return new URL(locateable.toString(), document.baseURI);
}
export function getAnchor(url) {
    let anchorMatch;
    if (url.hash != null && url.hash !== '') {
        return url.hash.slice(1);
    }
    else if ((anchorMatch = url.href.match(/#(.*)$/)) != null) {
        return anchorMatch[1];
    }
    else {
        return '';
    }
}
export function urlsAreEqual(left, right) {
    return expandUrl(left).href === expandUrl(right).href;
}
export function mergeHeaders(...sources) {
    const main = {};
    for (const source of sources) {
        for (const [header, value] of source) {
            main[header] = value;
        }
    }
    return new Headers(main);
}
//# sourceMappingURL=url.js.map