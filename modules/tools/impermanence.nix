{
  inputs,
  den,
  ...
}: {
  #--------#
  # Aspect #
  #--------#
   
  den.aspects.impermanence.nixos = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;

      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];

      files = ["etc/machine-id"];
    };
  };

  #--------#
  # Schema #
  #--------#
   
  den.schema.host.includes = [
    (den.lib.policy.route {
      fromClass = "persist";
      intoClass = host.class;
      intoPath = ["environment" "persistence" "/persist"];
      guard = {options, ...}: options.environment ? impermanence;
    })
  ];
}
