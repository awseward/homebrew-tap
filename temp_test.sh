#!/usr/bin/env bash

set -euo pipefail

_brew_do() {
  # shellcheck disable=SC2068
  echo 'awseward/tap/check_zoom' | xargs -t brew $@
}

_brew_do services stop
_brew_do uninstall
_brew_do install
_brew_do services start
