# Add an argument for building a different image

# Give Apollo-specific build scripts their own folder, making modularity for us easier. These will be called in once the base OS is built.
FROM scratch AS ctx
COPY build_files /build_files
COPY system_files /system_files
COPY assets /assets

FROM ghcr.io/bootcrew/arch-bootc:latest

ARG IMAGE_NAME="${IMAGE_NAME:-apollo}"

# Call in Apollo's build scripts.
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/base/01-locales.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/base/02-base.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/base/03-tools.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/base/99-base-overrides.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/gnome/01-gnome.sh

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
	/ctx/build_files/gnome/99-gnome-overrides.sh

# Copy Homebrew files from the brew image (credit to Universal Blue)
COPY --from=ghcr.io/ublue-os/brew:latest /system_files /

# https://bootc-dev.github.io/bootc/bootc-images.html#standard-metadata-for-bootc-compatible-images
LABEL containers.bootc 1

RUN bootc container lint
