{...}: {
  services.vscode-server.enable = true;

  services.gpg-agent = {
    enable = true;

    defaultCacheTtl = 5 * 60;
    defaultCacheTtlSsh = 5 * 60;
    enableSshSupport = true;
    maxCacheTtl = 30 * 60;
    maxCacheTtlSsh = 30 * 60;
    pinentryFlavor = "tty";
    sshKeys = ["6C560B0B5F2146329B7AC36992F7186F2EE51AD4"];
  };
}
