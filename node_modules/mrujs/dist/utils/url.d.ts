export declare type Locateable = URL | string;
export declare function expandUrl(locateable: Locateable): URL;
export declare function getAnchor(url: URL): string;
export declare function urlsAreEqual(left: string, right: string): boolean;
export interface ObjectHeaders {
    [header: string]: string;
}
export declare function mergeHeaders(...sources: Headers[]): Headers;
//# sourceMappingURL=url.d.ts.map