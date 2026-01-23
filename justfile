[private]
@default:
    just --list

@agent-run runner_name workspace:
    VCS_REF=$(git describe --always --dirty --tags) \
    HOST_USER=$(whoami) \
    HOST_OP_PATH=$(command -v op) \
    RUNNER_NAME={{runner_name}} \
    WORK_SPACE={{workspace}} \
    docker compose -p fedora -f ./src/docker-compose.yml \
    up -d --build 


@agent-down runner_name prune="false":
    [ {{prune}} = "true" ] \
    && docker compose -p {{runner_name}} -f ./src/docker-compose.yml down -v \
    || docker compose -p {{runner_name}} -f ./src/docker-compose.yml down

@update-lazy name:
    echo "Updating LazyVim plugins..."
    docker exec {{name}} nvim --headless "+Lazy! sync" +qa
