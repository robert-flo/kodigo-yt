#!/usr/bin/env bash

# Terminal presentation adapted from ravn-wt (colors, section rule, errors).
if [[ ${_PRESENTATION_SOURCED:-0} -eq 1 ]]; then
  return 0 2> /dev/null || exit 0
fi
readonly _PRESENTATION_SOURCED=1

if [[ -t 1 && ${TERM:-dumb} != "dumb" && -z ${NO_COLOR:-} ]]; then
  readonly RED=$'\033[0;31m'
  readonly GREEN=$'\033[0;32m'
  readonly YELLOW=$'\033[0;33m'
  readonly BLUE=$'\033[0;34m'
  readonly MAGENTA=$'\033[0;35m'
  readonly CYAN=$'\033[0;36m'
  readonly WHITE=$'\033[1;37m'
  readonly GRAY=$'\033[0;90m'
  readonly LIGHT_GRAY=$'\033[0;37m'
  readonly NC=$'\033[0m'
else
  readonly RED=""
  readonly GREEN=""
  readonly YELLOW=""
  readonly BLUE=""
  readonly MAGENTA=""
  readonly CYAN=""
  readonly WHITE=""
  readonly GRAY=""
  readonly LIGHT_GRAY=""
  readonly NC=""
fi

if [[ ${TERM:-} != "dumb" && -z ${NO_COLOR:-} ]]; then
  readonly ICON_CROSS="✗"
  readonly ICON_INFO="ℹ"
  readonly ICON_GOODBYE="👋"
else
  readonly ICON_CROSS="[ERROR]"
  readonly ICON_INFO="[INFO]"
  readonly ICON_GOODBYE="[BYE]"
fi

# Icons used by the menu. Same codepoints as ravn-wt.
declare -Ar RAVN_ICON=(
  [ui_close]=" "
  [ui_command]=" "
)

print_section() {
  echo ""
  echo -e "${MAGENTA}  $1${NC}"
  echo -e "${GRAY}  ──────────────────────────────────────────────────────────${NC}"
}

print_error() {
  echo -e "  ${RED}${ICON_CROSS}${NC} $1"
}

print_info() {
  echo -e "  ${BLUE}${ICON_INFO}${NC} $1"
}
