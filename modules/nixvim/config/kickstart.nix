{
pkgs,
lib,
config,
...
}: {
config = {
# globals.have_nerd_font = true;

options = {
## prompt on exit instead of erroring when files are unvisited
cursorline = true;
confirm = true;
autochdir = true;
};
};
}
