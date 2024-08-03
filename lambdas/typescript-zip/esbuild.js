const esbuild = require('esbuild');

esbuild.build({
    entryPoints: ['handler.ts'],
    platform: 'node',
    bundle: true,
    minify: true,
    sourcemap: true,
    target: 'es2020',
    outfile: 'dist/index.js',
});
