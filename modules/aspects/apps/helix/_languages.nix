{
  language = [
    {
      name = "nix";
      comment-token = "#";
      language-servers = [ "nixd" ];
    }

    {
      name = "python";
      comment-token = "#";
      language-servers = [ "ty" ];
    }
  ];

  language-server = {
    ty = {
      command = "ty";
      args = ["server"];

      config = {
        experimental.rename = true;
        completions.completeFunctionParentheses = true;
      };
    };
  };
}
