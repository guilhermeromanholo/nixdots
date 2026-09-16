{den, ...}: {
  den.classes.persist.description = "Impermanence host content";

  den.policies.persist-to-host = {host, ...}:
    den.lib.policy.route {
      fromClass = "persist";
      intoClass = host.class;
      intoPath = ["environment" "persistence" "/persist"];
      guard = {options, ...}: options.environment ? impermanence;
    };

  den.schema.host.includes = [den.policies.persist-to-host];
}
