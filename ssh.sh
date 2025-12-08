#!/usr/bin/env bash
echo "Connecting..."
ssh -o ServerAliveInterval=30 -o ServerAliveCountMax=3 lillypond@lillypond.local
