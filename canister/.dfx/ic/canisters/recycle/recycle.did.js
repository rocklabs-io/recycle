export const idlFactory = ({ IDL }) => {
  const Recycle = IDL.Service({
    'cycles' : IDL.Func([], [IDL.Nat], ['query']),
    'get_freezing_threshold' : IDL.Func([IDL.Principal], [IDL.Nat], []),
    'install_code' : IDL.Func(
        [IDL.Principal, IDL.Vec(IDL.Nat8)],
        [IDL.Bool],
        [],
      ),
    'recycle' : IDL.Func([IDL.Principal, IDL.Nat], [IDL.Bool], []),
  });
  return Recycle;
};
export const init = ({ IDL }) => { return [IDL.Principal]; };
