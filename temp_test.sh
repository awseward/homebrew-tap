#!/usr/bin/env bash

set -euo pipefail

hb_tap="awseward/homebrew-tap"
hb_formula="${hb_tap}/call_status_checker"

_tap_do() {
  # shellcheck disable=SC2068
  echo "${hb_tap}" | xargs -t brew $@
}

_formula_do() {
  # shellcheck disable=SC2068
  echo "${hb_formula}" | xargs -t brew $@
}

_formula_do services stop
_formula_do uninstall
_tap_do  untap
_formula_do install
_formula_do services start
