#!//bin/bash

# This should be the base of a bucklescript project
base=~/clone/games/lost-ranger
# And this is the module you want to inspect
name=src/Play_step
# name=src/Geom
name=src/Example
# NOTE: you have to have built the project already to produce the artifacts.

# ./lib/bs/native/main.native \
# ./_build/install/default/bin/docre \
# ${base}/${name}.re \
# ${base}/lib/bs/js/${name}.cmt \
# ${base}/lib/bs/js/${name}.mlast \
# docs/index.html

# ./_build/install/default/bin/docre ${base}/lib/bs/js/${name}.cmt docs/doc.html

# ./_build/install/default/bin/docre ${base}/lib/bs/js/src/Example.cmt docs/doc.html

# exit 0

# name=/node_modules/@jaredly/reprocessing/lib/bs/js/src/Reprocessing_Draw
# ./_build/install/default/bin/docre \
# ${base}${name}.cmti \
# ${base}${name}.mliast \
# docs/doc.html

base=${base}/node_modules/@jaredly/reprocessing/lib/bs/js/src

# List=(
# Reprocessing
# Reprocessing_Constants
# Reprocessing_Draw
# Reprocessing_Env
# Reprocessing_Utils
# )

# Normals=(
# Reprocessing_ClientWrapper
# Reprocessing_Common
# Reprocessing_Events
# Reprocessing_Font
# Reprocessing_Hotreload
# Reprocessing_Internal
# Reprocessing_Matrix
# Reprocessing_Shaders
# Reprocessing_Types
# )

# for name in ${List[@]}
# do
#   ./_build/install/default/bin/docre ${base}/${name}.cmti docs/${name}.html
# done

# for name in ${Normals[@]}
# do
#   ./_build/install/default/bin/docre ${base}/${name}.cmt docs/${name}.html
# done

./_build/install/default/bin/docre cmts docs/ ${base}/*.cmt*

./_build/install/default/bin/docre Reprocessing ../../games/reprocessing