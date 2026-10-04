#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
PASS=0; FAIL=0
ok(){ printf '[PASS] %s\n' "$1"; PASS=$((PASS+1)); }
bad(){ printf '[FAIL] %s\n' "$1"; FAIL=$((FAIL+1)); }
run(){ if eval "$2" >/dev/null 2>&1; then ok "$1"; else bad "$1"; fi; }

run 'All four containers are running' "test \"\$(docker compose ps --status running --services | wc -l)\" -eq 4"
run 'Attacker has corporate IP 172.16.10.10' "docker exec ga-attacker ip -4 addr show | grep -q '172.16.10.10/24'"
run 'Pivot has corporate IP 172.16.10.20' "docker exec ga-pivot ip -4 addr show | grep -q '172.16.10.20/24'"
run 'Pivot has internal IP 10.10.20.20' "docker exec ga-pivot ip -4 addr show | grep -q '10.10.20.20/24'"
run 'Internal web has IP 10.10.20.30' "docker exec ga-internal-web ip -4 addr show | grep -q '10.10.20.30/24'"
run 'Internal SSH has IP 10.10.20.40' "docker exec ga-internal-ssh ip -4 addr show | grep -q '10.10.20.40/24'"
run 'Attacker can reach pivot SSH' "docker exec ga-attacker nc -z -w2 172.16.10.20 22"
run 'Pivot can reach internal web' "docker exec ga-pivot curl -fsS http://10.10.20.30/health.txt | grep -q '^OK$'"
run 'Pivot can reach internal SSH' "docker exec ga-pivot bash -lc 'timeout 2 bash -c \"</dev/tcp/10.10.20.40/22\"'"

if docker exec ga-attacker curl -fsS --connect-timeout 2 http://10.10.20.30/health.txt >/dev/null 2>&1; then
  bad 'Internal web is NOT directly reachable from attacker'
else
  ok 'Internal web is NOT directly reachable from attacker'
fi

# Remove stale SSH tunnels from previous self-tests.
docker exec ga-attacker pkill -f 'ssh .*127.0.0.1:18080' >/dev/null 2>&1 || true
docker exec ga-attacker pkill -f 'ssh .*127.0.0.1:12222' >/dev/null 2>&1 || true
docker exec ga-attacker pkill -f 'ssh .*127.0.0.1:11080' >/dev/null 2>&1 || true

run 'Local port forwarding reaches internal web' "docker exec ga-attacker bash -lc \"sshpass -p 'PivotLab2026!' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -f -N -L 127.0.0.1:18080:10.10.20.30:80 pivot@172.16.10.20 && sleep 1 && curl -fsS http://127.0.0.1:18080/challenge.txt | grep -q 'GA{INTERNAL_WEB_REACHED_VIA_PIVOT}'\""
run 'Dynamic SOCKS forwarding reaches internal web' "docker exec ga-attacker bash -lc \"sshpass -p 'PivotLab2026!' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -f -N -D 127.0.0.1:11080 pivot@172.16.10.20 && sleep 1 && curl -fsS --socks5-hostname 127.0.0.1:11080 http://10.10.20.30/challenge.txt | grep -q 'GA{INTERNAL_WEB_REACHED_VIA_PIVOT}'\""
run 'Forwarded SSH reaches second internal service' "docker exec ga-attacker bash -lc \"sshpass -p 'PivotLab2026!' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -f -N -L 127.0.0.1:12222:10.10.20.40:22 pivot@172.16.10.20 && sleep 1 && sshpass -p 'InternalLab2026!' ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -p 12222 internal@127.0.0.1 'cat ~/flag.txt' | grep -q 'GA{SECOND_INTERNAL_SERVICE_REACHED}'\""

docker exec ga-attacker pkill ssh >/dev/null 2>&1 || true
printf '\nSelf-test result: %d passed, %d failed.\n' "$PASS" "$FAIL"
[ "$FAIL" -eq 0 ]
