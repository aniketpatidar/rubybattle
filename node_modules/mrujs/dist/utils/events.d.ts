export declare const EVENT_DEFAULTS: {
    bubbles: boolean;
    cancelable: boolean;
};
/**
 * Thin wrapper around element.dispatchEvent and new CustomEvent
 */
export declare function dispatch(this: Node, name: string, options?: CustomEventInit): CustomEvent;
export declare function stopEverything(event: Event | CustomEvent): void;
export declare const AJAX_EVENTS: {
    /**
     * Before the ajax event gets sent.
     * You can view what data will be sent via: `event.detail.formData`
     */
    ajaxBefore: string;
    /**
     * Just prior to sending the fetch request
     * @TODO not currently implemented
     */
    ajaxBeforeSend: string;
    /**
     * When the fetch request is sent. You can view whats being sent via:
     * `event.detail.formData`
     */
    ajaxSend: string;
    /**
     * When a response error occurs. IE: 400, 404, 422, 500, etc (any status code not between 200 - 299)
     * The response error can be viewed via: `event.detail.response`
     */
    ajaxResponseError: string;
    /**
     * Catches errors with requests such as Network errors.
     */
    ajaxRequestError: string;
    /**
     * When a >= 200 and <= 299 response is returned
     * You can view the full response via: `event.detail.response`
     */
    ajaxSuccess: string;
    /**
     * A unified event to catch both Response and Request errors.
     * You can view the error via: `event.detail.error`
     * This will also generate an error in your console.log
     */
    ajaxError: string;
    /**
     * After any fetch request, regardless of outcome
     * Does not have any accessible data besides the event itself
     */
    ajaxComplete: string;
    ajaxStopped: string;
};
//# sourceMappingURL=events.d.ts.map