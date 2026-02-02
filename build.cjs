const fs = require("fs")

// Move compiled libopus files
fs.mkdirSync("./dist", { recursive: true })
fs.copyFileSync("./build/decoder.d.ts", "./src/decoder.d.ts")
fs.copyFileSync("./build/decoder.js", "./dist/decoder.js")