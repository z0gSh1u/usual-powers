#!/usr/bin/env bash

# Human-in-the-loop reproduction loop.
# Copy this file, edit the steps below, and run it.
# The agent runs the script; the user follows prompts in their terminal.
#
# Usage:
#   bash hitl-loop.template.sh
#
# Helpers:
#   step "..."                 Show an instruction and wait for Enter.
#   capture VAR "..."          Ask a question and capture the response.

set -euo pipefail

step() {
  printf '\n>>> %s\n' "$1"
  read -r -p " [Enter when done] " _
}

capture() {
  local var="$1"
  local question="$2"
  local answer

  printf '\n>>> %s\n' "$question"
  read -r -p " > " answer
  printf -v "$var" '%s' "$answer"
}

# --- edit below ---------------------------------------------------------
step "Open the app at http://localhost:3000 and sign in."
capture ERRORED "Click the 'Export' button. Did it throw an error? (y/n)"
capture ERROR_MSG "Paste the error message (or 'none'):"
# --- edit above ---------------------------------------------------------

printf '\n--- Captured ---\n'
printf 'ERRORED=%s\n' "$ERRORED"
printf 'ERROR_MSG=%s\n' "$ERROR_MSG"
