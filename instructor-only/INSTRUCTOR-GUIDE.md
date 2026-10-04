# GREEN ARMOR CYBER RANGE - Instructor Guide

## Expected addresses

- Attacker: `172.16.10.10`
- Pivot corporate interface: `172.16.10.20`
- Pivot internal interface: `10.10.20.20`
- Internal web: `10.10.20.30:80`
- Internal SSH: `10.10.20.40:22`

## Credentials

- Pivot: `pivot / PivotLab2026!`
- Internal SSH: `internal / InternalLab2026!`

## Local Port Forwarding

From `ga-attacker`:

```bash
ssh -L 8080:10.10.20.30:80 -N pivot@172.16.10.20
```

In another attacker shell:

```bash
curl http://127.0.0.1:8080/challenge.txt
```

Expected:

```text
GA{INTERNAL_WEB_REACHED_VIA_PIVOT}
```

## Dynamic Port Forwarding / SOCKS

```bash
ssh -D 1080 -N pivot@172.16.10.20
```

For a direct SOCKS validation without changing configuration files:

```bash
curl --socks5-hostname 127.0.0.1:1080 http://10.10.20.30/challenge.txt
```

For Proxychains, ensure `/etc/proxychains4.conf` ends with:

```text
socks5 127.0.0.1 1080
```

Then:

```bash
proxychains4 curl http://10.10.20.30/challenge.txt
```

## Internal SSH through Local Forward

```bash
ssh -L 2222:10.10.20.40:22 -N pivot@172.16.10.20
```

In another attacker shell:

```bash
ssh -p 2222 internal@127.0.0.1
cat ~/flag.txt
```

Expected:

```text
GA{SECOND_INTERNAL_SERVICE_REACHED}
```

## Automated validation

```bash
./tests/self-test.sh
```

Do not give the instructor guide or self-test details to students before the exercise if you want discovery to remain part of the task.
