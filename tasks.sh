#/bin/bash
#docker-compose -f docker/docker-compose.dev.yml up
# docker-compose -f docker/docker-compose.dev.yml run app mix ecto.reset

if [[ $1 == "dev" ]]; then

  POSITIONAL=()
  while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
      -b|--build)
        BUILD="YES"
        shift # past argument
        shift # past value
        ;;
      *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
  done

  set -- "${POSITIONAL[@]}" # restore positional parameters

  if [[ BUILD == "YES" ]]; then
    echo "BUILDING DEV"
  fi

  echo $POSITIONAL
fi