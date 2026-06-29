#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Author: Simone Machetti
# -----------------------------------------------------------------------------

set -euo pipefail

verilator \
    -sv \
    --binary \
    --timing \
    --trace \
    --trace-max-array 0 \
    --trace-max-width 0 \
    -Wall \
    -Wno-fatal \
    -I"${CODE_HOME}/ip-lib/rtl" \
    --top-module "tb_${SEL_TOP_LEVEL}" \
    "${CODE_HOME}/ip-lib/tb/tb_${SEL_TOP_LEVEL}.sv" \
    -Mdir "${CODE_HOME}/ip-lib/sim/${SEL_OUT_DIR}/build/obj_dir" \
    -o "${CODE_HOME}/ip-lib/sim/${SEL_OUT_DIR}/build/simv" \
    | tee "${CODE_HOME}/ip-lib/sim/${SEL_OUT_DIR}/output/compile.log"

exec "${CODE_HOME}/ip-lib/sim/${SEL_OUT_DIR}/build/simv" "$@" \
    | tee "${CODE_HOME}/ip-lib/sim/${SEL_OUT_DIR}/output/run.log"
