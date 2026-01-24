function fish_right_prompt
        set_color $fish_color_cwd
        # Path shortening inside home
        set -l current_dir (prompt_pwd)
        echo -n "$current_dir"

        set_color brblack
        echo -n " ╯"
        set_color normal
end
