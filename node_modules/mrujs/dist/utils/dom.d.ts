import { QuerySelectorInterface, SelectorInterface } from '../types';
/**
 * Checks if the given native dom element matches the selector
 * @example
 *   match(document.querySelector("form"), { selector: "form", exclude: "form[data-remote='true']"})
 */
export declare function match(element: Node | Element, { selector, exclude }: SelectorInterface): boolean;
export declare const BASE_MODIFIERS: string[];
export declare const BASE_SELECTORS: QuerySelectorInterface;
//# sourceMappingURL=dom.d.ts.map