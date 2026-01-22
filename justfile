@agent-run:
    VCS_REF=$(git describe --always --dirty --tags) \
    HOST_USER=$(whoami) \
    HOST_OP_PATH=$(command -v op) \
    RUNNER_NAME=runer \
    docker compose -p fedora -f ./src/docker-compose.yml up -d --build


@agent-down prune="false":
    [ {{prune}} = "true" ] \
    && docker compose -p fedora -f ./src/docker-compose.yml down -v \
    || docker compose -p fedora -f ./src/docker-compose.yml down

@update-lazy name:
    echo "Updating LazyVim plugins..."
    docker exec {{name}} nvim --headless "+Lazy! sync" +qa
