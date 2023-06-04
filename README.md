# CUT TO THE CHASE

The chief modules are:
- capture.lua
- preferences.lua
- csv.lua

So that:
- commands.lua
can be pleasant syntactic sugar.


# Whowhowwhowho

This started out as a repo for learning Lua.
It's turned into proof of how much I love Lua.
It seems that as soon as I found out this took 5ms,
`lua -e "print(os.date('%m-%d-%Y'))"`
1/12th of the time as its 60ms Python equivalent:
`import datetime.datetime as dt; print(dt.today().strftime("%m-%d-%Y"))`
I was bound to love Lua.

[I read the design document again.]()
I dug into coroutines.
I love coroutines!
I love the ecosystem.
I love the portability, and simplicity of the language.
I'd love to test how embeddable it really is.
It was crazy to see it used in TPP modding -- teleporting a player.
Is InfiniteHeaven written in Lua?
Lua + reverse-engineering?
Wow.
There's also magic lantern.

## Current use of the repo

This is currently a testing ground for the application of Lua for business projects.
Running an fzf instance and passing in custom arguments to escape system-specific shell nonsense.
Lua works as a dependable bridge between systems to execute piped commands.
So long as the utilities are installed, the calls to them can be made.
The problem of working on multiple machines comes from adjusting *one* 'preferences.lua' file.
This in turn is referred to by a 'commands.lua' file.
To adjust the behavior, a user just changes the 'preferences.lua' file.
It's just like a neovim config.
In fact, I never would've been disposed to work like this if I didn't use neovim.
But I've been exposed to best practices for the organization of lua modules because of it.
I've manually installed lazy.nvim, I've rebuilt my config from scratch at least twice, and probably will a third time soon.
It's good to re-invent yourself.
I tried out helix the other day, and want to just install it instead of my config on a computer I'm not used to.
I don't want to leave behind a breadcrumb trail to myself with git authentications, or curl it from a site that betrays me.
Helix probably does more than what I need, and does certain things better.
gh and gl, for instance, are fucking genius.
s being dedicated to regex searches on a selection... also genius.
Built-in WhichKey, accessible registers, easy macros...
Helix is a best first option, and is more portable than a fully configured neovim.
I would have Sam, Gabe, and Andy learn to use helix first.
That said, having built my neovim config from repeated pulling, commiting, and pushing has made me a better developer.
It's taught me to see the immediate results of changes.
Just reload your text editor.
The main draw for me to use helix is how bloated my config is at the moment.
There are times I don't need cmp.
I love the idea of piping the file into a unix command with just one keybind.
Writing the result of sort %, etc.
Genius!
This sort of thing is great for those of us who love CLI tools.
Maas Lalani, who made nap, is the king of CLI tools.
I have so much to learn from him.
2023-05-26
But luasnippets is going to be a very powerful tool.
Using nap is probably the best move for a helix user.
I love how portable it makes all code.
I need to make a stack-overflow cURL-er.
Hell, I need to figure out how to use cURL at all.
But I need to finish reading Roberto's book on Lua.
GN.
