import { EventQueryInterface } from './types';
export declare class Confirm {
    boundHandleConfirm: EventListener;
    get queries(): EventQueryInterface[];
    connect(): void;
    disconnect(): void;
    observerCallback(nodeList: NodeList): void;
    handleConfirm(event: Event | CustomEvent): void;
}
//# sourceMappingURL=confirm.d.ts.map