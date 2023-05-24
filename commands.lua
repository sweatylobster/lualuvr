return {
  -- we can eventually turn these into bat_opts for customizability, but i want proof of concept now.
  bat = "bat -p -f",
  fzf = 'fzf --reverse --prompt="monstrous use of lua bro > " --ansi --margin=2 --padding=2 --header-lines=1 --no-multi',
  gum = {
    today = 'gum input --placeholder="You wanna print a lien from today\'s schedule?"',
    past = 'gum input --header="Which day do you wanna print a lien for, then?"',
  latex = 'python3 C:\\Users\\maxde\\code\\interpreting\\aguila\\forms\\luaforms\\pylualatex.py',
  schedule = 'python3 C:\\Users\\maxde\\code\\interpreting\\aguila\\billing\\get_schedule.py',
  }
}
