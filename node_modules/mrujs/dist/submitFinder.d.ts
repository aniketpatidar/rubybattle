import { Submitter } from './types';
export interface ExtendedSubmitEvent extends CustomEvent {
    submitter: Submitter;
    detail: {
        submitter?: Submitter;
    };
}
export declare function findSubmitter(event: ExtendedSubmitEvent): Submitter | undefined;
//# sourceMappingURL=submitFinder.d.ts.map