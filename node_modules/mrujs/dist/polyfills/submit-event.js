"use strict";
// Shamelessly stolen from Turbo. Makes the submit event listenable from Safari.
// https://github.com/hotwired/turbo/blob/main/src/polyfills/submit-event.ts
const submittersByForm = new WeakMap();
function findSubmitterFromClickTarget(target) {
    const element = target instanceof Element ? target : target instanceof Node ? target.parentElement : null;
    const candidate = (element != null) ? element.closest('input, button') : null;
    if ((candidate != null) && candidate.type === 'submit') {
        return candidate;
    }
    return null;
}
function clickCaptured(event) {
    const submitter = findSubmitterFromClickTarget(event.target);
    if ((submitter === null || submitter === void 0 ? void 0 : submitter.form) != null) {
        submittersByForm.set(submitter.form, submitter);
    }
}
(function () {
    // No need to continue, polyfill not needed.
    if ('SubmitEvent' in window)
        return;
    addEventListener('click', clickCaptured, true);
    Object.defineProperty(Event.prototype, 'submitter', {
        get() {
            if (this.type === 'submit' && this.target instanceof HTMLFormElement) {
                return submittersByForm.get(this.target);
            }
            return undefined;
        }
    });
})();
//# sourceMappingURL=submit-event.js.map