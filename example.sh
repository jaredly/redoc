
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

# ./_build/install/default/bin/docre \
# ${base}/lib/bs/js/${name}.cmt \
# ${base}/lib/bs/js/${name}.mlast \
# docs/doc.html

# name=/node_modules/@jaredly/reprocessing/lib/bs/js/src/Reprocessing_Draw
# ./_build/install/default/bin/docre \
# ${base}${name}.cmti \
# ${base}${name}.mliast \
# docs/doc.html

base=${base}/node_modules/@jaredly/reprocessing/lib/bs/js/src


List=(Reprocessing Reprocessing_Constants Reprocessing_Draw Reprocessing_Env Reprocessing_Utils)
Normals=(Reprocessing_Types Reprocessing_Events Reprocessing_Common)

for name in ${List[@]}
do
  ./_build/install/default/bin/docre \
  ${base}/${name}.cmti \
  ${base}/${name}.mliast \
  docs/${name}.html

done


for name in ${Normals[@]}
do
  ./_build/install/default/bin/docre \
  ${base}/${name}.cmt \
  ${base}/${name}.mlast \
  docs/${name}.html

done