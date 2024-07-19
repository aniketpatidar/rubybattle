import { expandUrl } from '../utils/url';
// Shamelessly stolen from Turbo.
// https://github.com/hotwired/turbo/blob/main/src/http/fetch_response.ts
export class FetchResponse {
    constructor(response) {
        this.response = response;
    }
    get succeeded() {
        return this.response.ok;
    }
    get failed() {
        return !this.succeeded;
    }
    get clientError() {
        return this.statusCode >= 400 && this.statusCode <= 499;
    }
    get serverError() {
        return this.statusCode >= 500 && this.statusCode <= 599;
    }
    get redirected() {
        return this.response.redirected;
    }
    get location() {
        return expandUrl(this.response.url);
    }
    get isHtml() {
        var _a;
        return Boolean((_a = this.contentType) === null || _a === void 0 ? void 0 : _a.match(/^(?:text\/([^\s;,]+\b)?html|application\/xhtml\+xml)\b/));
    }
    get statusCode() {
        return this.response.status;
    }
    get contentType() {
        return this.getHeader('Content-Type');
    }
    get responseText() {
        if (this.__responseText__ != null)
            return this.__responseText__;
        return (this.__responseText__ = this.response.text());
    }
    get responseHtml() {
        if (this.isHtml) {
            if (this.__responseHtml__ != null)
                return this.__responseHtml__;
            return (this.__responseHtml__ = this.responseText);
        }
        return Promise.reject(this.response);
    }
    get responseJson() {
        if (this.isJson) {
            if (this.__responseJson__ != null)
                return this.__responseJson__;
            return (this.__responseJson__ = this.response.json());
        }
        return Promise.reject(this.response);
    }
    // https://fetch.spec.whatwg.org/#fetch-api
    get isJson() {
        var _a;
        return Boolean((_a = this.contentType) === null || _a === void 0 ? void 0 : _a.toLowerCase().match(/(^application\/json|\.json$)/));
    }
    getHeader(name) {
        return this.response.headers.get(name);
    }
}
//# sourceMappingURL=fetchResponse.js.map