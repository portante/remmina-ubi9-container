# Why's and what fors:
#  --rm          -- Don't keep the container around when it finishes
#  --read-only.  -- Make the root file-system in the container read-only
#  --security-.  -- Don't relabel so that the Wayland socket can be accessed
#  --mount typ.  -- Mount /run/user as a tmpfs volume in the container
#  --volume ${.  -- Mounts the "real" wayland display directory in the container
#  -e XDG_RUNT.  -- Set the same XDG_RUNTIME_DIR value in the container since the same directory is mounted in the container
#  -e HOME=/tmp  -- Avoids Fontconfig no writeable cache directory errors
#  -e GDK_BACK.  -- For working with Wayland displays
#  -e QT_QPA_P.  -- For working with Wayland displays
#  -e XDG_SESS.  -- For working with Wayland displays
#  -e WAYLAND_.  -- For working with Wayland displays
#  --name calc   -- Name the running container "calc"
#
# See https://github.com/podenv/podenv for a more generic way to accomplish
# this.  Note that the below is tailored for gnome-calculator with no errors
# or warnings.
run:
	podman run --rm \
		--read-only=true \
		--security-opt label=disable \
		--device=/dev/dri/renderD128 \
		--mount type=tmpfs,destination=/run/user \
		--volume ${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}:${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY} \
		--env XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR} \
		--env HOME=/tmp \
		--env DISPLAY=${DISPLAY} \
		--env GDK_BACKEND=wayland \
		--env QT_QPA_PLATFORM=wayland \
		--env XDG_SESSION_TYPE=wayland \
		--env WAYLAND_DISPLAY=${WAYLAND_DISPLAY} \
		--name calc \
		localhost/calc:latest

build:
	buildah bud -f ./ContainerFile --tag calc:latest .
