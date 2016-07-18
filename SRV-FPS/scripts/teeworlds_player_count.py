#!/usr/bin/env python
# vim: set ts=4 sw=4 noet:

from __future__ import print_function

import socket
import sys
import select

TIMEOUT = 0.1
REQUEST = b"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xffgie3\xff"

try:
    address = sys.argv[1], int(sys.argv[2])
except (IndexError, ValueError):
    print("usage: {} HOST PORT".format(sys.argv[0]), file=sys.stderr)
    sys.exit(-1)

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.sendto(REQUEST, address)
r,_,_ = select.select([s], [], [], TIMEOUT)
if not r:
    sys.exit(-2)

data = s.recv(4096)
data = data.split(b"\x00")
print(data[6].decode())
