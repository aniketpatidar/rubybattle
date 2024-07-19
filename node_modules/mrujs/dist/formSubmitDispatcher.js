import { AJAX_EVENTS, dispatch } from './utils/events';
import { findSubmitter } from './submitFinder';
import { FetchResponse } from './http/fetchResponse';
import { FormSubmission } from './formSubmission';
export class FormSubmitDispatcher {
    constructor() {
        this.__startFormSubmission__ = this.startFormSubmission.bind(this);
        this.__startFetchRequest__ = this.startFetchRequest.bind(this);
        this.__sendFetchRequest__ = this.sendFetchRequest.bind(this);
        this.__dispatchError__ = this.dispatchError.bind(this);
        this.__dispatchComplete__ = this.dispatchComplete.bind(this);
    }
    connect() {
        this.listeners('addEventListener');
    }
    disconnect() {
        this.listeners('removeEventListener');
    }
    /**
     * Basic fetch request which leverages the FetchRequest object.
     *   This is an internal fetch
     *   Appropriate headers will be set for you but can be overriden.
     * @fires `ajax:before`
     */
    startFormSubmission(event) {
        // If it doesnt have remote="true"...forget about it!
        const element = this.findTarget(event);
        if (element.dataset.remote !== 'true')
            return;
        event.preventDefault();
        const submitter = findSubmitter(event);
        if (submitter != null) {
            window.mrujs.toggler.disableElement(submitter);
        }
        const { fetchRequest, request } = new FormSubmission(element, submitter);
        const detail = { element, fetchRequest, request, submitter };
        dispatch.call(element, AJAX_EVENTS.ajaxBefore, { detail });
    }
    /**
     * Fires off a fetch request and returns the response data. Triggered by events.
     * @fires `ajax:beforeSend`
     * The request can be found via `event.detail.request`
     */
    startFetchRequest(event) {
        if (event.defaultPrevented) {
            this.dispatchStopped(event);
            return;
        }
        const { element, fetchRequest, request, submitter } = event.detail;
        dispatch.call(element, AJAX_EVENTS.ajaxBeforeSend, {
            detail: { element, fetchRequest, request, submitter }
        });
    }
    async sendFetchRequest(event) {
        if (event.defaultPrevented) {
            this.dispatchStopped(event);
            return;
        }
        const { request } = event.detail;
        try {
            const fetchResponse = new FetchResponse(await window.fetch(request));
            const { response } = fetchResponse;
            this.dispatchResponse(Object.assign(Object.assign({}, event.detail), { fetchResponse, response }));
        }
        catch (error) {
            this.dispatchRequestError(Object.assign(Object.assign({}, event.detail), { error }));
        }
    }
    /**
     * Handles FetchResponses
     *   Fires `ajax:response:error` or `ajax:success` depending on the response.
     *   You can find the response in `event.detail.response`
  
    /*
     * Dispatches the `ajax:complete` event.
     * { response, request?, error?, submitter } = detail
     */
    dispatchComplete(event) {
        if (event.defaultPrevented) {
            this.dispatchStopped(event);
            return;
        }
        dispatch.call(this.findTarget(event), AJAX_EVENTS.ajaxComplete, {
            detail: Object.assign({}, event.detail)
        });
    }
    /**
     * Handles FetchResponses
     * @fires `ajax:response:error` or `ajax:success` depending on if the response succeeded.
     * properties: { request, response, submitter } = event.detail
     */
    dispatchResponse({ element, fetchRequest, request, fetchResponse, response, submitter }) {
        if ((fetchResponse === null || fetchResponse === void 0 ? void 0 : fetchResponse.succeeded) === true) {
            dispatch.call(element, AJAX_EVENTS.ajaxSuccess, {
                detail: { element, fetchRequest, request, fetchResponse, response, submitter }
            });
            return;
        }
        // Response errors, >= 400 responses
        dispatch.call(element, AJAX_EVENTS.ajaxResponseError, {
            detail: { element, fetchRequest, request, fetchResponse, response, submitter }
        });
    }
    /**
     * Handles a `fetch()` request error.
     * @fires `ajax:request:error`
     * properties: `{ request, error, submitter } = event.detail`
     */
    dispatchRequestError({ element, fetchRequest, request, error, submitter }) {
        dispatch.call(element, AJAX_EVENTS.ajaxRequestError, {
            detail: { element, fetchRequest, request, error, submitter }
        });
    }
    /**
     * @fires the `ajax:error` event which is a catchall for request + response errors.
     * { response, request?, error?, submitter } = event.detail
     */
    dispatchError(event) {
        if (event.defaultPrevented) {
            this.dispatchStopped(event);
            return;
        }
        const { element, fetchRequest, request, fetchResponse, response, submitter } = event.detail;
        dispatch.call(this.findTarget(event), AJAX_EVENTS.ajaxError, {
            detail: { element, fetchRequest, request, fetchResponse, response, submitter }
        });
    }
    // This is only for when event.defaultPrevented() is called.
    // if a user calls `event.detail.submission.cancel()`, that will be triggered separately.
    dispatchStopped(event) {
        dispatch.call(this.findTarget(event), AJAX_EVENTS.ajaxStopped, {
            detail: Object.assign({}, event.detail)
        });
    }
    /**
     * dispatches a given event in the context of `this.element`
     */
    listeners(fn) {
        document[fn]('submit', this.__startFormSubmission__); // fires ajaxBefore
        document[fn](AJAX_EVENTS.ajaxBefore, this.__startFetchRequest__); // fires ajaxBeforeSend
        // fires ajaxRequestError || ajaxSuccess || ajaxResponse
        document[fn](AJAX_EVENTS.ajaxBeforeSend, this.__sendFetchRequest__);
        document[fn](AJAX_EVENTS.ajaxSuccess, this.__dispatchComplete__);
        document[fn](AJAX_EVENTS.ajaxRequestError, this.__dispatchError__);
        document[fn](AJAX_EVENTS.ajaxResponseError, this.__dispatchError__);
        document[fn](AJAX_EVENTS.ajaxError, this.__dispatchComplete__);
    }
    findTarget(event) {
        return event.target;
    }
}
//# sourceMappingURL=formSubmitDispatcher.js.map