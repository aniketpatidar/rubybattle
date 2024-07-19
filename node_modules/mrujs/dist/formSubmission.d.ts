import { FormEncType } from './utils/form';
import { Submitter } from './types';
import { FetchRequest } from './http/fetchRequest';
/**
 * This class handles FormSubmissions on forms that use data-remote="true"
 * This class should not be interacted with directly and instead is merely meant for
 * connecting to the DOM.
 */
export declare class FormSubmission {
    submitter: Submitter | undefined;
    element: HTMLFormElement;
    fetchRequest: FetchRequest;
    constructor(element: HTMLFormElement, submitter?: Submitter);
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
    get action(): string;
    /**
     * URL to send to. Is pulled from action=""
     * Throws an error of action="" is not defined on an element.
     */
    get url(): URL;
    get body(): URLSearchParams | FormData;
    get isGetRequest(): boolean;
    get enctype(): FormEncType;
}
//# sourceMappingURL=formSubmission.d.ts.map