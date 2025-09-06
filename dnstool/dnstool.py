#!/bin/python3
#
# NomadicClient - HTTP client
#
# Copyright (C) 2025 NobleNomadic
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.
#
# dnstool.py - DNS Resolve and reverse domains and IP
import socket
import sys

def resolveDomain(domain):
  try:
    ip = socket.gethostbyname(domain)
    print(ip)
  except socket.gaierror:
    print(f"Failed to resolve domain: {domain}")

def reverseIP(ip):
  try:
    host = socket.gethostbyaddr(ip)
    print(host[0])
  except socket.herror:
    print(f"Failed to reverse lookup IP: {ip}")

if __name__ == "__main__":
  # Bad argument handling
  if len(sys.argv) < 3:
    print("Usage: python3 dnstool.py <Domain|IP> <Resolve|Reverse>")
    exit(1)

  # Extract argument data
  data = sys.argv[1]
  action = sys.argv[2]

  # Resolve or reverse the data
  if action.lower() == "resolve":
    resolveDomain(data)
    exit(0)

  elif action.lower() == "reverse":
    reverseIP(data)
    exit(0)

  else:
    print("Invalid action. Use resolve or reverse")
    exit(1)
