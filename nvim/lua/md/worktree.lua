local status_wt, Worktree = pcall(require, "git-worktree")
local status_job, Job = pcall(require, "plenary.job")

if not status_wt or not status_job then
  return
end

-- op = Operations.Switch, Operations.Create, Operations.Delete
-- metadata = table of useful values (structure dependent on op)
--      Switch
--          path = path you switched to
--          prev_path = previous worktree path
--      Create
--          path = path where worktree created
--          branch = branch name
--          upstream = upstream remote name
--      Delete
--          path = path where worktree deleted

local function is_master_worktree(path)
  print("========================")
  print("is_master_worktree(path)")
  print(path)
  print("========================")
  return not not (string.find(path, "/master"))
end

Worktree.on_tree_change(function(op, metadata)
  if op == Worktree.Operations.Create then
    print("========================")
    print("Create new worktree")
    print(metadata.path)
    print("========================")
    local job = Job:new({
      command = "npm",
      args = { "install" },
      cwd = metadata.path,
    })
    job:start()

    print(vim.inspect.inspect(job:result()))
  end

  if op == Worktree.Operations.Switch and not( is_master_worktree(metadata.path) ) then
    local credFiles = metadata.prev_path .. "/*.yml"
    print("========================")
    print("Switching worktree")
    print(credFiles)
    print(metadata.path)
    print("========================")
    local copyCred = Job:new({
      command = "cp",
      args = { credFiles, metadata.path },
    })
    copyCred:sync()

    print(vim.inspect.inspect(copyCred:result()))
  end
end)
