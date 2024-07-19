import { Utils } from './utils';
import { match } from './utils/dom';
export class ClickHandler {
    static get queries() {
        return [
            {
                event: 'click',
                selectors: [
                    window.mrujs.querySelectors.linkClickSelector.selector,
                    window.mrujs.querySelectors.buttonClickSelector.selector,
                    window.mrujs.querySelectors.formInputClickSelector.selector
                ]
            }
        ];
    }
    connect() {
        ClickHandler.queries.forEach((obj) => {
            obj.selectors.forEach((selector) => {
                document.querySelectorAll(selector).forEach((element) => {
                    element.addEventListener(obj.event, Utils.preventInsignificantClick);
                });
            });
        });
    }
    disconnect() {
        ClickHandler.queries.forEach((obj) => {
            obj.selectors.forEach((selector) => {
                document.querySelectorAll(selector).forEach((element) => {
                    element.removeEventListener(obj.event, Utils.preventInsignificantClick);
                });
            });
        });
    }
    observerCallback(nodeList) {
        ClickHandler.queries.forEach((obj) => {
            obj.selectors.forEach((selector) => {
                nodeList.forEach((node) => {
                    if (match(node, { selector })) {
                        node.addEventListener(obj.event, Utils.preventInsignificantClick);
                    }
                    if (node instanceof Element) {
                        node.querySelectorAll(selector).forEach((el) => el.addEventListener(obj.event, Utils.preventInsignificantClick));
                    }
                });
            });
        });
    }
}
//# sourceMappingURL=clickHandler.js.map