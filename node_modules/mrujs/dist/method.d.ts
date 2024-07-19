/**
 * Handles `data-method="method" submissions.`
 */
export declare class Method {
    connect(): void;
    disconnect(): void;
    observerCallback(nodeList: NodeList): void;
    /**
     * Handles "data-method" on <a> tags such as:
     * @example
     *   // Not implemented!
     *   <a href="/users/5" data-method="delete" rel="nofollow" data-confirm="Are you sure?">Delete</a>
     *
     *   // Implemented!
     *   <a href="/users/5" data-method="delete" rel="nofollow">Delete</a>
     */
    handle(event: Event): void;
    get allLinks(): HTMLAnchorElement[];
}
//# sourceMappingURL=method.d.ts.map