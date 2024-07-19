import { formDataToStrings, FormEncType } from './utils/form';
import { findResponseTypeHeader } from './utils/headers';
import { FetchRequest } from './http/fetchRequest';
/**
 * This class handles LinkSubmissions (<a data-remote"true">)
  */
export class LinkSubmission {
    constructor(element) {
        this.element = element;
        const options = {
            method: this.maskMethod,
            headers: this.headers
        };
        if (!this.isGetRequest)
            options.body = this.body;
        this.fetchRequest = new FetchRequest(this.url, options);
    }
    get request() {
        return this.fetchRequest.request;
    }
    /**
     * Headers to send to the request object
     */
    get headers() {
        let responseType;
        if (this.element != null) {
            responseType = this.element.dataset.type;
        }
        const acceptHeader = findResponseTypeHeader(responseType);
        const headers = new Headers({ Accept: acceptHeader });
        headers.set('Accept', acceptHeader);
        return headers;
    }
    /**
     * Returns properly built FormData
     */
    get formData() {
        const formData = new FormData();
        formData.append('_method', this.method);
        return formData;
    }
    /**
     * Finds how to send the fetch request
     * get, post, put, patch, etc
     */
    get method() {
        var _a;
        const method = (_a = this.element.dataset.method) !== null && _a !== void 0 ? _a : 'get';
        return method.toLowerCase();
    }
    /**
     * If its a get request, leave it, everything else is masked as a POST.
     */
    get maskMethod() {
        return this.isGetRequest ? 'get' : 'post';
    }
    get href() {
        return this.element.href;
    }
    /**
     * URL to send to. Is pulled from action=""
     * Throws an error of action="" is not defined on an element.
     */
    get url() {
        return new URL(this.href);
    }
    get body() {
        if (this.enctype === FormEncType.urlEncoded || (this.isGetRequest)) {
            return new URLSearchParams(formDataToStrings(this.formData));
        }
        else {
            return this.formData;
        }
    }
    get isGetRequest() {
        return this.method.toLowerCase() === 'get';
    }
    get enctype() {
        return FormEncType.urlEncoded;
    }
}
//# sourceMappingURL=linkSubmission.js.map