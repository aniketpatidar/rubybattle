import { expandUrl } from './utils/url';
import morphdom from 'morphdom';
const ALLOWABLE_ACTIONS = [
    'advance',
    'replace',
    'restore'
];
export class NavigationAdapter {
    constructor() {
        this.__navigateViaEvent__ = this.navigateViaEvent.bind(this);
    }
    connect() {
        document.addEventListener('ajax:complete', this.__navigateViaEvent__);
    }
    disconnect() {
        document.removeEventListener('ajax:complete', this.__navigateViaEvent__);
    }
    /**
     * Currently, this only fires on successful form submissions.
     */
    navigateViaEvent(event) {
        const { element, fetchResponse, fetchRequest } = event.detail;
        if (fetchResponse == null)
            return;
        // Only render / navigate responses on html responses.
        if (fetchResponse.isHtml === false)
            return;
        if (element instanceof HTMLFormElement && fetchResponse.succeeded === true && fetchResponse.redirected === false) {
            console.error('Successful form submissions must redirect');
            return;
        }
        // Dont navigate on <a data-method="get"> for links.
        if (element instanceof HTMLAnchorElement && fetchRequest.isGetRequest === true)
            return;
        this.navigate(fetchResponse, element, fetchRequest);
    }
    /**
     * This is a manual navigation triggered by something like `method: :delete`
     */
    navigate(response, element, request, action) {
        // If we get redirected, use Turbolinks
        // This needs to be reworked to not trigger 2 HTML responses or find a
        // way to not refetch a page.
        action = action !== null && action !== void 0 ? action : this.determineAction(element);
        let location = expandUrl(window.location.href);
        if (request === null || request === void 0 ? void 0 : request.isGetRequest)
            location = request.url;
        if (response.redirected)
            location = response.location;
        if (response.failed) {
            // Use morphdom to dom diff the response if the response is HTML.
            this.morphResponse(response);
            return;
        }
        if (!this.useTurbolinks)
            return;
        window.Turbolinks.clearCache();
        if (response.isHtml) {
            this.navigateToResponse(response, location, action);
            return;
        }
        window.Turbolinks.visit(location, { action });
    }
    get useTurbolinks() {
        if (window.Turbolinks == null)
            return false;
        if (window.Turbolinks.supported !== true)
            return false;
        return true;
    }
    navigateToResponse(response, location, action) {
        response.responseHtml.then((html) => {
            const snapshot = window.Turbolinks.Snapshot.wrap(html);
            window.Turbolinks.controller.cache.put(location, snapshot);
            action = 'restore';
            window.Turbolinks.visit(location, { action });
        }).catch((error) => console.error(error));
    }
    morphResponse(response) {
        // Dont pass go if its not HTML.
        if (!response.isHtml)
            return;
        response.responseHtml
            .then((html) => {
            var _a;
            const template = document.createElement('template');
            template.innerHTML = String(html).trim();
            morphdom(document.body, template.content, { childrenOnly: true });
            // https://developer.mozilla.org/en-US/docs/Web/API/History/pushState
            // @ts-expect-error pushState accepts URL | string, but TS complains about URL.
            window.history.pushState({}, '', response.location);
            // This is only needed until we start using mutationObservers.
            (_a = window === null || window === void 0 ? void 0 : window.mrujs) === null || _a === void 0 ? void 0 : _a.restart();
        })
            .catch((error) => {
            console.error(error);
        });
    }
    determineAction(element) {
        let action = element.dataset.turbolinksAction;
        if (action == null || !ALLOWABLE_ACTIONS.includes(action)) {
            action = 'advance';
        }
        return action;
    }
}
//# sourceMappingURL=navigationAdapter.js.map