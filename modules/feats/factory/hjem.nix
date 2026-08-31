{
  inputs,
  lib,
  ...
}: {
  flake.factory.hjem = {
    users,
    host,
    config,
  }: {
    imports = [
      inputs.hjem.nixosModules.default
    ];

    hjem.clobberByDefault = true;

    hjem.users = lib.genAttrs users (
      user:
        lib.mkMerge [
          (lib.attrByPath [user] {} inputs.self.modules.hjem)
          (lib.attrByPath [host] {} inputs.self.modules.hjem)
          {_module.args.osConfig = config;}
        ]
    );
  };
}
