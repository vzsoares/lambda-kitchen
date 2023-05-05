const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['helpers/index.ts'],
  platform: 'node',
  bundle: true,
  minify: false,
  // sourcemap: true,
  target: 'es2020',
  outdir: 'dist/nodejs/node_modules/helpers/',
});
