import './polyfills';
import { FormSubmitDispatcher } from './formSubmitDispatcher';
import { ClickHandler } from './clickHandler';
import { Csrf } from './csrf';
import { Confirm } from './confirm';
import { Method } from './method';
import { Toggler } from './toggler';
import { Locateable } from './utils/url';
import { ExposedUtilsInterface, MrujsPluginInterface, MrujsConfigInterface, QuerySelectorInterface, MimeTypeInterface, CustomMimeTypeInterface } from './types';
export declare class Mrujs {
    formSubmitDispatcher: FormSubmitDispatcher;
    clickHandler: ClickHandler;
    connected: boolean;
    config: MrujsConfigInterface;
    confirmClass: Confirm;
    csrf: Csrf;
    method: Method;
    toggler: Toggler;
    private readonly navigationAdapter;
    private readonly boundReenableDisabledElements;
    private readonly addedNodesObserver;
    constructor();
    start(config?: Partial<MrujsConfigInterface>): Mrujs;
    stop(): void;
    restart(): void;
    connect(): void;
    disconnect(): void;
    addedNodesCallback(mutationList: MutationRecord[], _observer: MutationObserver): void;
    /**
     * Can be overridden with a custom confirm message
     */
    confirm(message: string): boolean;
    /**
     * Utilities generally not used for general purpose, but instead used for things like
     *   plugins or advanced features.
     */
    get utils(): ExposedUtilsInterface;
    fetch(input: Request | Locateable, options?: RequestInit): Promise<Response>;
    registerMimeTypes(mimeTypes: CustomMimeTypeInterface[]): MimeTypeInterface;
    get mimeTypes(): MimeTypeInterface;
    get plugins(): MrujsPluginInterface[];
    get querySelectors(): QuerySelectorInterface;
    set querySelectors(querySelectors: QuerySelectorInterface);
    get csrfToken(): string | null;
    get csrfParam(): string | null;
    reenableDisabledElements(): void;
}
//# sourceMappingURL=mrujs.d.ts.map