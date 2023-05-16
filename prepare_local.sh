# declare types so Lambda knows it
yarn tsc index.ts --declaration --allowJs --emitDeclarationOnly --outDir types

# create symlink to the layer
mkdir -p /opt/nodejs
sudo ln -sf `pwd` /opt/nodejs/
