{ pkgs, libs, ... }:
{
  vim = {
    theme = {
      enable = true;
      name = "everforest";
      style = "hard";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      python.enable = true;
    };
  };
}
