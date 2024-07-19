import { Submitter } from './types';
interface ListeningConditions {
    event: string;
    selector: string;
}
/**
 * Disables buttons / links / forms on submission start
 *   and reenables them when ajax:stopped or ajax:complete is fired.
 */
export declare class Toggler {
    readonly boundEnableElement: (trigger: Event | HTMLElement) => void;
    readonly boundDisableElement: (event: Event | HTMLFormElement | Submitter) => void;
    get enableElementConditions(): ListeningConditions[];
    get handleDisabledConditions(): ListeningConditions[];
    get disableElementConditions(): ListeningConditions[];
    addEnableElementListeners(): void;
    removeEnableElementListeners(): void;
    enableElementObserverCallback(nodeList: NodeList): void;
    addDisableElementListeners(): void;
    removeDisableElementListeners(): void;
    disableElementObserverCallback(nodeList: NodeList): void;
    addHandleDisabledListeners(): void;
    removeHandleDisabledListeners(): void;
    handleDisabledObserverCallback(nodeList: NodeList): void;
    addListeners(conditions: ListeningConditions[], callback: EventListener): void;
    removeListeners(conditions: ListeningConditions[], callback: EventListener): void;
    handleDisabledElement(this: HTMLFormElement, event: Event): void;
    enableElement(trigger: Event | HTMLElement): void;
    /**
     * Unified function to disable an element (link, button and form)
     */
    disableElement(event: Event | HTMLFormElement | Submitter): void;
    /**
     * Replace element's html with the 'data-disable-with' after storing original html
     *   and prevent clicking on it
     */
    disableLinkElement(element: HTMLElement): void;
    /**
     * Restore element to its original state which was disabled by 'disableLinkElement' above
     */
    enableLinkElement(element: HTMLElement): void;
    disableFormElements(form: HTMLFormElement): void;
    disableFormElement(element: HTMLFormElement): void;
    /**
   * Re-enables disabled form elements:
   *  - Replaces element text with cached value from 'ujs-enable-with' data store (created in `disableFormElements`)
   *  - Sets disabled property to false
   */
    enableFormElements(form: HTMLFormElement): void;
    enableFormElement(element: HTMLElement): void;
}
export {};
//# sourceMappingURL=toggler.d.ts.map