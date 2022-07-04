local status_ok, devicons = pcall(require, 'nvim-web-devicons')
if not status_ok then
  return
end

devicons.set_icon {
  sh = {
    icon = "",
    color = "#1DC123",
    cterm_color = "59",
    name = "Sh",
  },
  liquid = {
    icon = "",
    color = "#95BF47",
    cterm_color = "59",
    name = "liquid"
  },
  [".gitattributes"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "59",
    name = "GitAttributes",
  },
  [".gitconfig"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "59",
    name = "GitConfig",
  },
  [".gitignore"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "59",
    name = "GitIgnore",
  },
  [".gitlab-ci.yml"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "166",
    name = "GitlabCI",
  },
  [".gitmodules"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "59",
    name = "GitModules",
  },
  ["diff"] = {
    icon = "",
    color = "#e24329",
    cterm_color = "59",
    name = "Diff",
  },
}
