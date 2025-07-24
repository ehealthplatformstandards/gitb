#!/bin/bash
if [[ -n "$POSTGRES_PASSWORD_FILE" ]] ; then
  unset POSTGRES_PASSWORD
fi
if [[ -n "$POSTGRES_PASSWORD_FILE" ]] ; then
  unset POSTGRES_PASSWORD
fi
exec /usr/local/bin/docker-entrypoint.sh "$@"