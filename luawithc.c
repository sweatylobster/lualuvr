#include <stdio.h>
#include "lauxlib.h"
#include "lualib.h"

int main (int argc, char **argv) {
	// make a new state
	lua_State *L = luaL_newstate();
	// load the standard libraries
	luaL_openlibs(L);
	// try to load the given file and then
	// call the resulting function
	if (luaL_loadfile(L, argv[1]) != LUA_OK ||
		lua_pcall(L, 0, 0, 0) != LUA_OK) {
	// some error occurred; print the error message
	fprintf(stderr, "lua: %s\n", lua_tostring(L, -1));
	}
     	else { //code ran successfully
		lua_getglobal(L, "pi");
     		printf("pi: %f\n", lua_tonumber(L, -1));
	     }
     	lua_close(L); // close the state
	return 0;
}
