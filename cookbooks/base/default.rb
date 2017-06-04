package "epel-release"

include_recipe '../user/default.rb'
include_recipe 'rtn_git::system'
include_recipe '../tmux/default.rb'
include_recipe '../zsh/default.rb'
include_recipe '../nginx/default.rb'
include_recipe '../mysql/default.rb'
