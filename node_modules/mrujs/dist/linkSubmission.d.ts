import { FormEncType } from './utils/form';
import { FetchRequest } from './http/fetchRequest';
/**
 * This class handles LinkSubmissions (<a data-remote"true">)
  */
export declare class LinkSubmission {
    element: HTMLAnchorElement;
    fetchRequest: FetchRequest;
    constructor(element: HTMLAnchorElement);
    get request(): Request;
    /**
     * Headers to send to the request object
     */
    get headers(): Headers;
    /**
     * Returns properly built FormData
     */
    get formData(): FormData;
    /**
     * Finds how to send the fetch request
     * get, post, put, patch, etc
     */
    get method(): string;
    /**
     * If its a get request, leave it, everything else is masked as a POST.
     */
    get maskMethod(): string;
    get href(): string;
    /**
     * URL to send to. Is pulled from action=""
     * Throws an error of action="" is not defined on an element.
     */
    get url(): URL;
    get body(): URLSearchParams | FormData;
    get isGetRequest(): boolean;
    get enctype(): FormEncType;
}
//# sourceMappingURL=linkSubmission.d.ts.map