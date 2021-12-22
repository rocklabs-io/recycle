/**
 * Module     : recycle.mo
 * Copyright  : 2021 Rocklabs
 * License    : Apache 2.0 with LLVM Exception
 * Maintainer : Rocklabs Team <hello@rocklabs.io>
 * Stability  : Experimental
 */


import HashMap "mo:base/HashMap";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Order "mo:base/Order";
import Hash "mo:base/Hash";
import Error "mo:base/Error";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Time "mo:base/Time";
import Text "mo:base/Text";
import Result "mo:base/Result";
import Cycles = "mo:base/ExperimentalCycles";


shared(msg) actor class Recycle() = this {
    type CanisterSettings = {
        controllers : ?[Principal];
        compute_allocation : ?Nat;
        memory_allocation : ?Nat;
        freezing_threshold : ?Nat;
    };
    type CanisterId = {
        canister_id: Principal;
    };
    type InstallMode = {
        #install;
        #reinstall;
        #upgrade;
    };
    type InstallCodeParams = {
        mode: InstallMode;
        canister_id: Principal;
        wasm_module: Blob;
        arg: Blob;
    };
    type UpdateSettingsParams = {
        canister_id: Principal;
        settings: CanisterSettings;
    };
    type Status = {
        #running;
        #stopping;
        #stopped;
    };
    type CanisterStatus = {
        status: Status;
        settings: CanisterSettings;
        module_hash: ?Blob;
        memory_size: Nat;
        cycles: Nat;
    };
    public type ICActor = actor {
        create_canister: shared(settings: ?CanisterSettings) -> async CanisterId;
        update_settings: shared(params: UpdateSettingsParams) -> async ();
        install_code: shared(params: InstallCodeParams) -> async ();
        canister_status: query(canister_id: CanisterId) -> async CanisterStatus;
    };
    let IC: ICActor = actor("aaaaa-aa");

}
