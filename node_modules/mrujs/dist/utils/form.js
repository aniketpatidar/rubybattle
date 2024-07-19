export function buildFormElementFormData(element, submitter) {
    const formData = new FormData(element);
    const name = submitter === null || submitter === void 0 ? void 0 : submitter.getAttribute('name');
    const value = submitter === null || submitter === void 0 ? void 0 : submitter.getAttribute('value');
    if (name != null && value != null && formData.get(name) !== value) {
        formData.append(name, value);
    }
    return formData;
}
export var FormEncType;
(function (FormEncType) {
    FormEncType["urlEncoded"] = "application/x-www-form-urlencoded";
    FormEncType["multipart"] = "multipart/form-data";
    FormEncType["plain"] = "text/plain";
})(FormEncType || (FormEncType = {}));
export function formEnctypeFromString(encoding) {
    switch (encoding.toLowerCase()) {
        case FormEncType.multipart: return FormEncType.multipart;
        case FormEncType.plain: return FormEncType.plain;
        default: return FormEncType.urlEncoded;
    }
}
export function formDataToStrings(formData) {
    return [...formData].reduce((entries, [name, value]) => {
        return entries.concat(typeof value === 'string' ? [[name, value]] : []);
    }, []);
}
//# sourceMappingURL=form.js.map