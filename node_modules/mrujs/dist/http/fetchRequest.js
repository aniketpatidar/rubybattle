import { AJAX_EVENTS, dispatch, stopEverything } from '../utils/events';
import { mergeHeaders, expandUrl } from '../utils/url';
/**
 * Fetch Request is essentially an "proxy" class meant to wrap a standard Request
 *   Object and provide some sane convetions like passing in an abort controller,
 *   auto-serialization of FormData, auto-filling X-CSRF-Token and a number of other
 *   niceties. The FetchRequest constructor follows the same conventions as fetch.
 *   It can either take in a Request object, or be giving a url and then an object
 *   with all the fetch options.
 */
export class FetchRequest {
    constructor(input, options = {}) {
        this.abortController = new AbortController();
        // if we're given a Request, set the method, headers and body first, then we
        // merge with the defaultRequestOptions and clone the instance of Request
        if (input instanceof Request) {
            this.setMethodAndBody(input);
            this.modifyUrl(input.url);
            this.headers = mergeHeaders(this.defaultHeaders, input.headers);
            const mergedOptions = Object.assign(Object.assign({}, this.defaultRequestOptions), input);
            mergedOptions.headers = this.headers;
            this.request = new Request(mergedOptions);
        }
        else {
            this.setMethodAndBody(options);
            this.modifyUrl(input);
            this.headers = mergeHeaders(this.defaultHeaders, new Headers(options.headers));
            const mergedOptions = Object.assign(Object.assign({}, this.defaultRequestOptions), options);
            mergedOptions.headers = this.headers;
            // @ts-expect-error this.url is really a URL, but typescript seems to think Request cant handle it.
            this.request = new Request(this.url, mergedOptions);
        }
        this.headers = this.request.headers;
    }
    get params() {
        return this.url.searchParams;
    }
    get entries() {
        return this.body instanceof URLSearchParams ? Array.from(this.body.entries()) : [];
    }
    cancel(event) {
        this.abortController.abort();
        // trigger event dispatching if an event gets passed in.
        if (event != null) {
            stopEverything(event);
            const { element } = event.detail;
            dispatch.call(element, AJAX_EVENTS.ajaxStopped, {
                detail: Object.assign({}, event.detail)
            });
        }
    }
    modifyUrl(url) {
        this.url = expandUrl(url);
        if (!this.isGetRequest)
            return;
        // Append params to the Url.
        this.url = mergeFormDataEntries(this.url, this.entries);
    }
    setMethodAndBody(input) {
        var _a, _b, _c;
        this.method = ((_b = (_a = input.method) === null || _a === void 0 ? void 0 : _a.toLowerCase()) !== null && _b !== void 0 ? _b : 'get');
        if (this.isGetRequest)
            return;
        this.body = ((_c = input.body) !== null && _c !== void 0 ? _c : new URLSearchParams());
    }
    get defaultRequestOptions() {
        return {
            method: this.method,
            headers: this.headers,
            credentials: 'same-origin',
            redirect: 'follow',
            body: this.body,
            signal: this.abortSignal
        };
    }
    get defaultHeaders() {
        const headers = new Headers({
            Accept: '*/*',
            'X-REQUESTED-WITH': 'XmlHttpRequest'
        });
        const token = this.csrfToken;
        if (token != null) {
            headers.set('X-CSRF-TOKEN', token);
        }
        return headers;
    }
    get csrfToken() {
        if (this.isGetRequest)
            return;
        const token = window.mrujs.csrfToken;
        if (token == null)
            return;
        return token;
    }
    get isGetRequest() {
        return this.method.toLowerCase() === 'get';
    }
    get abortSignal() {
        return this.abortController.signal;
    }
}
function mergeFormDataEntries(url, entries) {
    const currentSearchParams = new URLSearchParams(url.search);
    for (const [name, value] of entries) {
        if (value instanceof File)
            continue;
        if (currentSearchParams.has(name)) {
            currentSearchParams.delete(name);
            url.searchParams.set(name, value);
        }
        else {
            url.searchParams.append(name, value);
        }
    }
    return url;
}
//# sourceMappingURL=fetchRequest.js.map