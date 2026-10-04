# TASK 04 - Pivoting, Tunneling & Port Forwarding

## Goal

Starting from `ga-attacker`, understand the visible network, identify the pivot host, establish a tunnel, and validate access to services on an internal network that is not directly attached to the attacker.

## Required stages

1. Record the attacker IP address and routing table.
2. Identify reachable systems on the Corporate network.
3. Identify the system suitable for use as the Pivot Host.
4. Document why the internal network is not directly available from the attacker.
5. Connect to the pivot using the supplied training credentials.
6. Record the pivot host interfaces and identify its second network.
7. Create an SSH Local Port Forward to reach the internal web service.
8. Create an SSH Dynamic Port Forward (SOCKS) and validate internal access through it.
9. Reach the second internal service through a tunnel.
10. Record screenshots/evidence and draw the final network path.

## What to submit

- Student name
- Attacker network information
- Reachable hosts
- Pivot host and justification
- Internal network
- Tunnel type(s)
- Commands used
- Two internal services reached
- Evidence screenshots
- Final network diagram
- Final result

## Questions

1. Why is the pivot host useful in this topology?
2. What is the difference between Local Port Forwarding and Dynamic Port Forwarding?
3. How did you verify that an internal service was reached through the tunnel?
4. What happens to the forwarded access when the SSH tunnel is closed?
5. Why should direct reachability be checked before claiming that pivoting was required?

## Rules

Work only inside this local lab. The objective is tunneling and validation, not destructive exploitation, brute force, persistence, or denial of service.
