package lua

import (
	"dagger.io/dagger"
	"universe.dagger.io/docker"
)

// Checks lua format via Luacheck
#LuaCheck: {
	// Files to Copy
	source: dagger.#FS

    checkDir: string | "."

	// Any extra luaCheck args
	extraArgs: [...string]

	_run: docker.#Build & {
		steps: [
			docker.#Pull & {
				source: "alpine:latest"
			},

			docker.#Run & {
				command: {
					name: "apt"
					user: "root"
					args: ["install", "lua5.3"]
				}
			},

			docker.#Run & {
				command: {
					name: "luarocks"
					args: ["install", "luacheck"]
				}
			},

			docker.#Copy & {
				dest:     "/tmp"
				contents: source
			},

			docker.#Run & {
				command: {
					name: "luacheck"
					args: [checkDir] + extraArgs
				}
				workdir: "/tmp"
			},
		]
	}
}
