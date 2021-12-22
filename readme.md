# Recycle: Reclaim cycles in unused canisters



Reclaim cycles in unused canisters, transfer it to user in the form of XTC.

User provide the canister id, the canister must be controlled by the user himself:

```
recycle --canister-id <CANISTER_ID> --receiver <PRINCIPAL_ID>
```

Logic:

1. get the canister information from ic.rocks, get the canisters controlled by this canister
2. install recycle.mo to this canister:
   1. if there are sub-canisters controlled by this canister, install recycle.mo for sub-canisters
   2. convert cycles in the sub-canisters into XTC and send to `receiver`
3. convert cycles in the designated canister into XTC and send to `receiver`
4. done

ic.rocks API: https://ic.rocks/api/canisters/oexpe-biaaa-aaaah-qcf6q-cai
