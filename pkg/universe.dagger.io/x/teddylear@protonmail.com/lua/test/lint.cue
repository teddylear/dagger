package lua

import (
	"dagger.io/dagger"
	"universe.dagger.io/x/teddylear@protonmail.com/lua"
)

dagger.#Plan & {
	client: filesystem: "./data/hello": read: contents: dagger.#FS

	actions: test: simple: lint: lua.#LuaCheck & {
		source: client.filesystem."./data/hello".read.contents
	}
}
