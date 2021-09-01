#!/bin/bash

show_help() {
  echo Usage: ./generate.sh loh-m0.6 2.3
}

if [[ -z $1 ]]; then
    echo ERROR: provide output file name
    show_help
    exit 1
fi
MESH_NAME=$1

if [[ -z $2 ]]; then
    echo ERROR: provide a mesh scale to generate, in mio cells
    show_help
    exit 1
fi
MESH_SCALE=$2

which gmsh
if [[ $? -ne 0 ]]; then
    echo ERROR: cannot find gmsh
fi


which gmsh2gambit
if [[ $? -ne 0 ]]; then
    echo ERROR: cannot find gmsh2gambit
fi


which pumgen
if [[ $? -ne 0 ]]; then
    echo ERROR: cannot find pumgen
fi

set -e
mkdir -p ./generated_meshes
gmsh ./loh.geo -3 -optimize -format msh2 -clscale $MESH_SCALE -o ./$MESH_NAME.msh
#gmsh ./loh.geo -3 -optimize_netgen -format msh2 -clscale $MESH_SCALE -o ./$MESH_NAME.msh
gmsh2gambit -i ./$MESH_NAME.msh -o ./$MESH_NAME.neu
pumgen $MESH_NAME.neu ./generated_meshes/$MESH_NAME.h5
rm ./$MESH_NAME.msh ./$MESH_NAME.neu
