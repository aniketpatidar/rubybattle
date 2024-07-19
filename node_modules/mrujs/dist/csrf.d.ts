export declare class Csrf {
    observer: MutationObserver;
    observerOptions: MutationObserverInit;
    constructor();
    connect(): void;
    disconnect(): void;
    refresh(): void;
    observerCallback(mutations: MutationRecord[]): void;
    static isCsrfToken(node: Node): boolean;
    get token(): string | null;
    get param(): string | null;
}
//# sourceMappingURL=csrf.d.ts.map