import { Locateable } from '../utils/url';
export declare type FetchRequestBody = URLSearchParams | ReadableStream<Uint8Array>;
export declare type FetchMethodString = 'get' | 'put' | 'post' | 'patch' | 'delete';
export declare type RequestInfo = Request | string | URL;
/**
 * Fetch Request is essentially an "proxy" class meant to wrap a standard Request
 *   Object and provide some sane convetions like passing in an abort controller,
 *   auto-serialization of FormData, auto-filling X-CSRF-Token and a number of other
 *   niceties. The FetchRequest constructor follows the same conventions as fetch.
 *   It can either take in a Request object, or be giving a url and then an object
 *   with all the fetch options.
 */
export declare class FetchRequest {
    abortController: AbortController;
    request: Request;
    headers: Headers;
    method: FetchMethodString;
    url: URL;
    body?: FetchRequestBody;
    constructor(input: Request | Locateable, options?: RequestInit);
    get params(): URLSearchParams;
    get entries(): Array<[string, FormDataEntryValue]>;
    cancel(event?: CustomEvent): void;
    modifyUrl(url: Locateable): void;
    setMethodAndBody(input: Request | RequestInit): void;
    get defaultRequestOptions(): RequestInit;
    get defaultHeaders(): Headers;
    get csrfToken(): string | undefined;
    get isGetRequest(): boolean;
    get abortSignal(): AbortSignal;
}
//# sourceMappingURL=fetchRequest.d.ts.map