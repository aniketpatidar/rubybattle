import { formDataToStrings, buildFormElementFormData, formEnctypeFromString, FormEncType } from './utils/form';
import { findResponseTypeHeader } from './utils/headers';
import { FetchRequest } from './http/fetchRequest';
/**
 * This class handles FormSubmissions on forms that use data-remote="true"
 * This class should not be interacted with directly and instead is merely meant for
 * connecting to the DOM.
 */
export class FormSubmission {
    constructor(element, submitter) {
        this.element = element;
        if (submitter != null) {
            this.submitter = submitter;
        }
        const options = {
            method: this.method,
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
        return buildFormElementFormData(this.element, this.submitter);
    }
    /**
     * Finds how to send the fetch request
     * get, post, put, patch, etc
     */
    get method() {
        var _a, _b, _c;
        const method = (_c = (_b = (_a = this.submitter) === null || _a === void 0 ? void 0 : _a.getAttribute('formmethod')) !== null && _b !== void 0 ? _b : this.element.getAttribute('method')) !== null && _c !== void 0 ? _c : 'get';
        return method.toLowerCase();
    }
    get action() {
        var _a, _b;
        return (_b = (_a = this.submitter) === null || _a === void 0 ? void 0 : _a.getAttribute('formaction')) !== null && _b !== void 0 ? _b : this.element.action;
    }
    /**
     * URL to send to. Is pulled from action=""
     * Throws an error of action="" is not defined on an element.
     */
    get url() {
        return new URL(this.action);
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
        var _a, _b;
        const elementEncType = (this.element).enctype;
        return formEnctypeFromString((_b = (_a = this.submitter) === null || _a === void 0 ? void 0 : _a.getAttribute('formenctype')) !== null && _b !== void 0 ? _b : elementEncType);
    }
}
//# sourceMappingURL=formSubmission.js.map