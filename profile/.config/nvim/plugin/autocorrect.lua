local fixes = {
    [ "uft" ] = "utf",
    [ "uft8" ] = "utf8",
    [ "бдует" ] = "будет",
    [ "бдудут" ] = "будут",
    [ "прилодения" ] = "приложения",
    [ "прилодение" ] = "приложение",
    [ "fasle" ] = "false",
    [ "udmp" ] = "dump",
    [ "dumo" ] = "dump",
}

for typo, fix in pairs( fixes ) do
    vim.keymap.set( "ia", typo, fix )
end
