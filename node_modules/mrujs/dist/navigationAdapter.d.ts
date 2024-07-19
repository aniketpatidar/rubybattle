import { Locateable } from './utils/url';
import { FetchRequest } from './http/fetchRequest';
import { FetchResponse } from './http/fetchResponse';
declare type VisitAction = 'advance' | 'replace' | 'restore';
export declare class NavigationAdapter {
    private readonly __navigateViaEvent__;
    constructor();
    connect(): void;
    disconnect(): void;
    /**
     * Currently, this only fires on successful form submissions.
     */
    navigateViaEvent(event: CustomEvent): void;
    /**
     * This is a manual navigation triggered by something like `method: :delete`
     */
    navigate(response: FetchResponse, element: HTMLElement, request: FetchRequest, action?: VisitAction): void;
    get useTurbolinks(): boolean;
    navigateToResponse(response: FetchResponse, location: Locateable, action: VisitAction): void;
    morphResponse(response: FetchResponse): void;
    determineAction(element: HTMLElement): VisitAction;
}
export {};
//# sourceMappingURL=navigationAdapter.d.ts.map