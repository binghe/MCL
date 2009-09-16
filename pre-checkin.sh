#!/bin/sh
#
# Split resource forks from resource files, so that we can check both
# forks into svn

function splitfile {
 cat "$1/rsrc" > ".resource-forks/$1"
}


splitfile OpenTransportSupport
splitfile pmcl-kernel
splitfile PPCCL
splitfile pmcl/siow_resources
#splitfile RMCL
splitfile examples/contextual-menu-cursor.rsrc
splitfile library/cursors.rsrc
splitfile "library/MCL Background.rsrc"

