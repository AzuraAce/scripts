#!/usr/bin/env bash

# Paths to bash and zsh
BASH_BIN=$(which bash)
ZSH_BIN=$(which zsh)

# Colors for output
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

echo "Benchmarking Bash vs Zsh on: $(uname -a)"
echo

# --- Startup Time ---
echo "1. Shell Startup Time (interactive login + exit)"

time_shell_startup() {
    local shell=$1
    (time "$shell" -i -c exit) 2>&1 | grep real | awk '{print $2}'
}

bash_startup=$(time_shell_startup "$BASH_BIN")
zsh_startup=$(time_shell_startup "$ZSH_BIN")

echo "  Bash: ${GREEN}${bash_startup}${RESET}"
echo "  Zsh : ${GREEN}${zsh_startup}${RESET}"
echo

# --- Loop Performance ---
echo "2. Loop Performance (100000 no-op iterations)"

cat > loop_test.sh << 'EOF'
#!/bin/sh
i=0
while [ $i -lt 100000 ]; do
  i=$((i + 1))
done
EOF
chmod +x loop_test.sh

time_loop() {
    local shell=$1
    (time "$shell" ./loop_test.sh) 2>&1 | grep real | awk '{print $2}'
}

bash_loop=$(time_loop "$BASH_BIN")
zsh_loop=$(time_loop "$ZSH_BIN")

echo "  Bash: ${GREEN}${bash_loop}${RESET}"
echo "  Zsh : ${GREEN}${zsh_loop}${RESET}"
echo

# --- Function Call Overhead ---
echo "3. Function Call Overhead (100000 trivial calls)"

cat > func_test.sh << 'EOF'
#!/bin/sh
f() { :; }
i=0
while [ $i -lt 100000 ]; do
  f
  i=$((i + 1))
done
EOF
chmod +x func_test.sh

time_func() {
    local shell=$1
    (time "$shell" ./func_test.sh) 2>&1 | grep real | awk '{print $2}'
}

bash_func=$(time_func "$BASH_BIN")
zsh_func=$(time_func "$ZSH_BIN")

echo "  Bash: ${GREEN}${bash_func}${RESET}"
echo "  Zsh : ${GREEN}${zsh_func}${RESET}"
echo

# Cleanup
rm -f loop_test.sh func_test.sh

