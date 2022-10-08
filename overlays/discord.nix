self: super: {    
    discord = super.discord.overrideAttrs (oldAttrs: {
        src = builtins.fetchTarball {
            url = "https://discord.com/api/download?platform=linux&format=tar.gz";
            sha256 = "0qaczvp79b4gzzafgc5ynp6h4nd2ppvndmj6pcs1zys3c0hrabpv";
        };
        nss = self.nss;
    });
}
