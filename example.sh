
# This should be the base of a bucklescript project
base=~/clone/games/lost-ranger
# And this is the module you want to inspect
name=src/Play_step
# NOTE: you have to have built the project already to produce the artifacts.

./lib/bs/native/main.native \
${base}/${name}.re \
${base}/lib/bs/js/${name}.cmt \
${base}/lib/bs/js/${name}.mlast \
docs/index.html
