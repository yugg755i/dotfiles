function fish_prompt
    set -l normal (set_color normal)

    # Username (now actually controlled)
    set_color --bold brblue
    echo -n $USER"@"(prompt_hostname)

    echo -n " "

    # Path
    set_color cyan
    echo -n (prompt_pwd)

    set_color normal
    echo -n " > "
end
