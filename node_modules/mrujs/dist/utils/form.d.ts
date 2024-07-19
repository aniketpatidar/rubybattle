import { Submitter } from '../types';
export declare function buildFormElementFormData(element: HTMLFormElement, submitter?: Submitter): FormData;
export declare enum FormEncType {
    urlEncoded = "application/x-www-form-urlencoded",
    multipart = "multipart/form-data",
    plain = "text/plain"
}
export declare function formEnctypeFromString(encoding: string): FormEncType;
export declare function formDataToStrings(formData: FormData): Array<[string, string]> | undefined;
//# sourceMappingURL=form.d.ts.map