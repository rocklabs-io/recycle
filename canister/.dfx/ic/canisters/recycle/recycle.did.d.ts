import type { Principal } from '@dfinity/principal';
export interface Recycle {
  'cycles' : () => Promise<bigint>,
  'get_freezing_threshold' : (arg_0: Principal) => Promise<bigint>,
  'install_code' : (arg_0: Principal, arg_1: Array<number>) => Promise<boolean>,
  'recycle' : (arg_0: Principal, arg_1: bigint) => Promise<boolean>,
}
export interface _SERVICE extends Recycle {}
