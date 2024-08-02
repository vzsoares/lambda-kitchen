# declare types so Lambda knows it
yarn tsc index.ts --declaration --allowJs --emitDeclarationOnly --outDir types

# prapere layer for local usage
LAYER_NAME="helpers"
FINAL_PATH="./lib/nodejs/$LAYER_NAME"

[ -e lib ] && rm -f -r lib
[ -e dist ] && rm -f -r dist

node ./esbuild.js

mkdir -p "$FINAL_PATH" && cp -r dist/* "$FINAL_PATH" && \
(cd "$FINAL_PATH" && npm init -y 1> /dev/null)

# create symlink to the layer
mkdir -p /opt/nodejs
sudo ln -sf `pwd` /opt/nodejs/

echo "**Local enviroment prepared**"