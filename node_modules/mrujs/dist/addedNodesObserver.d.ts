/**
 * Mutation observer for added nodes.
 */
export declare class AddedNodesObserver {
    readonly observer: MutationObserver;
    readonly observerOptions: MutationObserverInit;
    constructor(callback: MutationCallback);
    connect(): void;
    disconnect(): void;
}
//# sourceMappingURL=addedNodesObserver.d.ts.map