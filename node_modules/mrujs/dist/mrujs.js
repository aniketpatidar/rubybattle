// Currently only import the safari submit event polyfill.
import './polyfills';
import { FormSubmitDispatcher } from './formSubmitDispatcher';
import { ClickHandler } from './clickHandler';
import { Csrf } from './csrf';
import { Confirm } from './confirm';
import { Method } from './method';
import { NavigationAdapter } from './navigationAdapter';
import { Toggler } from './toggler';
import { AddedNodesObserver } from './addedNodesObserver';
import { FetchRequest } from './http/fetchRequest';
import { FetchResponse } from './http/fetchResponse';
import { BASE_SELECTORS, match } from './utils/dom';
import { BASE_ACCEPT_HEADERS } from './utils/headers';
export class Mrujs {
    constructor() {
        this.config = {
            querySelectors: Object.assign({}, BASE_SELECTORS),
            mimeTypes: Object.assign({}, BASE_ACCEPT_HEADERS),
            plugins: []
        };
        this.clickHandler = new ClickHandler();
        this.csrf = new Csrf();
        this.formSubmitDispatcher = new FormSubmitDispatcher();
        this.navigationAdapter = new NavigationAdapter();
        this.method = new Method();
        this.confirmClass = new Confirm();
        this.toggler = new Toggler();
        this.boundReenableDisabledElements = this.reenableDisabledElements.bind(this);
        // MutationObserver for added nodes
        this.addedNodesObserver = new AddedNodesObserver(this.addedNodesCallback.bind(this));
        this.connected = false;
    }
    start(config = {}) {
        window.Rails = window.mrujs = this;
        // Dont start twice!
        if (window.mrujs.connected) {
            return window.mrujs;
        }
        this.config = Object.assign(Object.assign({}, this.config), config);
        this.connect();
        return this;
    }
    stop() {
        this.disconnect();
    }
    restart() {
        this.disconnect();
        this.connect();
    }
    connect() {
        this.addedNodesObserver.connect();
        // This event works the same as the load event, except that it fires every
        // time the page is loaded.
        // See https://github.com/rails/jquery-ujs/issues/357
        // See https://developer.mozilla.org/en-US/docs/Using_Firefox_1.5_caching
        this.reenableDisabledElements();
        window.addEventListener('pageshow', this.boundReenableDisabledElements);
        this.csrf.connect();
        this.toggler.addEnableElementListeners(); // Enables elements on ajax:stopped / ajax:complete
        this.clickHandler.connect(); // preventInsignificantClicks
        this.toggler.addHandleDisabledListeners(); // checks if element is disabled before proceeding.
        this.confirmClass.connect(); // confirm
        this.toggler.addDisableElementListeners(); // disables element while processing.
        this.method.connect();
        this.formSubmitDispatcher.connect();
        this.navigationAdapter.connect();
        this.plugins.forEach((plugin) => {
            plugin.connect();
        });
        this.connected = true;
    }
    disconnect() {
        window.removeEventListener('pageshow', this.boundReenableDisabledElements);
        this.addedNodesObserver.disconnect();
        this.csrf.disconnect();
        this.toggler.removeEnableElementListeners();
        this.clickHandler.disconnect();
        this.toggler.removeHandleDisabledListeners();
        this.confirmClass.disconnect();
        this.toggler.removeDisableElementListeners();
        this.method.disconnect();
        this.formSubmitDispatcher.disconnect();
        this.navigationAdapter.disconnect();
        this.addedNodesObserver.disconnect();
        this.plugins.forEach((plugin) => {
            plugin.disconnect();
        });
        this.connected = false;
    }
    addedNodesCallback(mutationList, _observer) {
        for (const mutation of mutationList) {
            this.toggler.enableElementObserverCallback(mutation.addedNodes);
            this.clickHandler.observerCallback(mutation.addedNodes);
            this.confirmClass.observerCallback(mutation.addedNodes);
            this.toggler.disableElementObserverCallback(mutation.addedNodes);
            this.toggler.handleDisabledObserverCallback(mutation.addedNodes);
            this.method.observerCallback(mutation.addedNodes);
        }
    }
    /**
     * Can be overridden with a custom confirm message
     */
    confirm(message) {
        return window.confirm(message);
    }
    /**
     * Utilities generally not used for general purpose, but instead used for things like
     *   plugins or advanced features.
     */
    get utils() {
        return {
            match,
            FetchRequest: FetchRequest,
            FetchResponse: FetchResponse
        };
    }
    async fetch(input, options = {}) {
        const fetchRequest = new FetchRequest(input, options);
        return await window.fetch(fetchRequest.request);
    }
    registerMimeTypes(mimeTypes) {
        const customMimeTypes = {};
        mimeTypes.forEach((mimeType) => {
            const { shortcut, header } = mimeType;
            customMimeTypes[shortcut] = header;
        });
        this.config.mimeTypes = Object.assign(Object.assign({}, this.config.mimeTypes), customMimeTypes);
        return this.mimeTypes;
    }
    get mimeTypes() {
        return this.config.mimeTypes;
    }
    get plugins() {
        return this.config.plugins;
    }
    get querySelectors() {
        return this.config.querySelectors;
    }
    set querySelectors(querySelectors) {
        this.config.querySelectors = querySelectors;
    }
    get csrfToken() {
        return this.csrf.token;
    }
    get csrfParam() {
        return this.csrf.param;
    }
    reenableDisabledElements() {
        document
            .querySelectorAll(`${this.querySelectors.formEnableSelector.selector} ${this.querySelectors.linkDisableSelector.selector}`)
            .forEach(element => {
            const el = element;
            // Reenable any elements previously disabled
            this.toggler.enableElement(el);
        });
    }
}
//# sourceMappingURL=mrujs.js.map