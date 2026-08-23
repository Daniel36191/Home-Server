#!/usr/bin/env bash
echo "Warning! This will wipe all raid drives. Any key to proceeded: "
read
echo "Writing..."
sudo nix run github:nix-community/disko -- --mode destroy,format,mount ./disko.nix
sudo zpool status
sudo zfs list
