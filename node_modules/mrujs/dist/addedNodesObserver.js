import { BASE_MODIFIERS } from './utils/dom';
/**
 * Mutation observer for added nodes.
 */
export class AddedNodesObserver {
    constructor(callback) {
        this.observer = new MutationObserver(callback);
        this.observerOptions = {
            childList: true,
            subtree: true,
            attributeFilter: BASE_MODIFIERS
        };
    }
    connect() {
        this.observer.observe(document, this.observerOptions);
    }
    disconnect() {
        this.observer.disconnect();
    }
}
//# sourceMappingURL=addedNodesObserver.js.map