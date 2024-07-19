import { ExtendedSubmitEvent } from './submitFinder';
import { AjaxEventDetail } from './types';
export declare class FormSubmitDispatcher {
    readonly __startFormSubmission__: Function;
    readonly __startFetchRequest__: Function;
    readonly __sendFetchRequest__: Function;
    readonly __dispatchError__: Function;
    readonly __dispatchComplete__: Function;
    constructor();
    connect(): void;
    disconnect(): void;
    /**
     * Basic fetch request which leverages the FetchRequest object.
     *   This is an internal fetch
     *   Appropriate headers will be set for you but can be overriden.
     * @fires `ajax:before`
     */
    startFormSubmission(event: ExtendedSubmitEvent): void;
    /**
     * Fires off a fetch request and returns the response data. Triggered by events.
     * @fires `ajax:beforeSend`
     * The request can be found via `event.detail.request`
     */
    startFetchRequest(event: CustomEvent): void;
    sendFetchRequest(event: CustomEvent): Promise<void>;
    /**
     * Handles FetchResponses
     *   Fires `ajax:response:error` or `ajax:success` depending on the response.
     *   You can find the response in `event.detail.response`
  
    /*
     * Dispatches the `ajax:complete` event.
     * { response, request?, error?, submitter } = detail
     */
    dispatchComplete(event: CustomEvent): void;
    /**
     * Handles FetchResponses
     * @fires `ajax:response:error` or `ajax:success` depending on if the response succeeded.
     * properties: { request, response, submitter } = event.detail
     */
    dispatchResponse({ element, fetchRequest, request, fetchResponse, response, submitter }: AjaxEventDetail): void;
    /**
     * Handles a `fetch()` request error.
     * @fires `ajax:request:error`
     * properties: `{ request, error, submitter } = event.detail`
     */
    dispatchRequestError({ element, fetchRequest, request, error, submitter }: AjaxEventDetail): void;
    /**
     * @fires the `ajax:error` event which is a catchall for request + response errors.
     * { response, request?, error?, submitter } = event.detail
     */
    dispatchError(event: CustomEvent): void;
    dispatchStopped(event: CustomEvent): void;
    /**
     * dispatches a given event in the context of `this.element`
     */
    private listeners;
    private findTarget;
}
//# sourceMappingURL=formSubmitDispatcher.d.ts.map