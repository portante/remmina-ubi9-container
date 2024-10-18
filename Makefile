# Why's and what fors:
#  -e HOME=/tmp  -- Avoids Fontconfig no writeable cache directory errors
#  -e WAYLAN...  -- For working with Wayland displays
#  -e XAUTHO...  -- Ditto
#  -e XDG_RU...  -- Ditto
#  -v ${XDG_...  -- Ditto
#  --userns=...  -- Wayload environment is assumed to be the current user
#  --securit...  -- Don't relabel so that the Wayland socket can be accessed
run:
	podman run -d --name calc -e HOME=/tmp -e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} -e XAUTHORITY=$(basename ${XAUTHORITY}) -e XDG_RUNTIME_DIR=/tmp/xdg-runtime-dir -v ${XDG_RUNTIME_DIR}:/tmp/xdg-runtime-dir --userns=keep-id --security-opt label=disable localhost/calc:latest

build:
	buildah bud -f ./ContainerFile --tag calc:latest .
