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


shared(msg) actor class Recycle(owner_: Principal) = this {
	
	private stable var owner: Principal = owner_;

	public shared(msg) func install_code(canister_id: Principal, wasm: Blob): async Bool {
		assert(msg.caller == owner);
		//
	};

	public shared(msg) func get_freezing_threshold(canister_id: Principal): async Nat {
		return 2_592_000;
	};

	public shared(msg) func recycle(to: Principal): async Bool {
		assert(msg.caller == owner);
		let bal = Cycles.balance();
		let thresh = await get_freezing_threshold(Principal.fromActor(this));
		let amount = bal - thresh * 3 / 2;
		Cycles.add(amount);
		await dank.mint(to, amount)
	}
}
