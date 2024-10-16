run:
	podman run -it -e WAYLAND_DISPLAY=${WAYLAND_DISPLAY} -e XAUTHORITY=${XAUTHORITY} -e XDG_RUNTIME_DIR=/tmp/xdg-runtime-dir -v ${XDG_RUNTIME_DIR}:/tmp/xdg-runtime-dir --userns=keep-id localhost/calc:latest

build:
	buildah bud -f ./ContainerFile --tag calc:latest .
