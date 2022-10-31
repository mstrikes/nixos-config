let version = "0.0.21"; in self: super: {    
    discord = (super.discord.overrideAttrs (oldAttrs: {
        src = builtins.fetchTarball {
            url = "https://dl.discordapp.net/apps/linux/${version}/discord-${version}.tar.gz";
            sha256 = "1pw9q4290yn62xisbkc7a7ckb1sa5acp91plp2mfpg7gp7v60zvz";
        };
    })).override { nss = self.nss_latest; };
}
