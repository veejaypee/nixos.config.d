# Nixvim

My configuration for nixvim

## TODO

- figure out what is implemented in nixvim to use and what needs to be done with LUA imports.

## Configuring

To start configuring, just add or modify the nix files in `./config`.
If you add a new configuration file, remember to add it to the
[`config/default.nix`](./config/default.nix) file

## Testing your new configuration

To test your configuration simply run the following command

```
nix run .
```
