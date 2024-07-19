export const BASE_ACCEPT_HEADERS = {
    '*': '*/*',
    any: '*/*',
    text: 'text/plain',
    html: 'text/html',
    xml: 'application/xml, text/xml',
    json: 'application/json, text/javascript'
};
export function findResponseTypeHeader(responseType) {
    const acceptHeaders = Object.assign({}, window.mrujs.mimeTypes);
    if (responseType == null) {
        return acceptHeaders.any;
    }
    responseType = responseType.trim();
    if (Object.keys(acceptHeaders).includes(responseType)) {
        return acceptHeaders[responseType];
    }
    return responseType;
}
//# sourceMappingURL=headers.js.map