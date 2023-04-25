const esbuild = require("esbuild");

esbuild.build({
  entryPoints: ["handler.ts"],
  platform: "node",
  bundle: true,
  minify: true,
  outfile: "dist/main.js",
  target: "es2020",
});
