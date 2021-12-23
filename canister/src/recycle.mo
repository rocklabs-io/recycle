/**
 * Module     : recycle.mo
 * Copyright  : 2021 Rocklabs
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Rocklabs Team <hello@rocklabs.io>
 * Stability  : Experimental
 */

import Nat "mo:base/Nat";
import Error "mo:base/Error";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Cycles = "mo:base/ExperimentalCycles";
import ic "./ic"

shared(msg) actor class Recycle(owner_: Principal) = this {
    
    private stable var owner: Principal = owner_;
    private stable var IC: ic.ICActor = actor("aaaaa-aa");

    public type CyclesWallet = actor {
        wallet_receive: shared() -> async ();
    };

    public shared(msg) func install_code(canister_id: Principal, wasm: Blob): async Bool {
        assert(msg.caller == owner);
        //
        true
    };

    public query func cycles(): async Nat {
        return Cycles.balance();
    };

    public shared(msg) func get_freezing_threshold(canister_id: Principal): async Nat {
        try {
            let status = await IC.canister_status({canister_id = canister_id});
            switch(status.settings.freezing_threshold) {
                case(?n) { return n; };
                case(_) { return 0; };
            };
        } catch (e) {
            return 2_592_000;
        };
    };

    public shared(msg) func recycle(to: Principal, leftover: Nat): async Bool {
        assert(msg.caller == owner);
        let bal = Cycles.balance();
        let amount: Nat = bal - leftover;

        let wallet: CyclesWallet = actor(Principal.toText(to));
        Cycles.add(amount);
        await wallet.wallet_receive();
        return true;
    };
}
