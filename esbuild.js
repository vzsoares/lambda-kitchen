const esbuild = require('esbuild');

esbuild.build({
  entryPoints: ['index.ts'],
  platform: 'node',
  bundle: true,
  minify: false,
  target: 'es2020',
  outdir: 'dist/',
});
