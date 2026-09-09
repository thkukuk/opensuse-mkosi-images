#!/usr/bin/env python3
"""Regenerate the Packages= list in */obs/mkosi.conf.

OBS needs a static list of all RPMs that could be required to build any of
the images defined for a distribution (mkosi.generic, mkosi.raspberrypi,
<dist>/mkosi.<dist>, <dist>/mkosi.images/*). Instead of tracking that list
by hand, ask mkosi itself for the fully resolved package list of every
image, for every architecture used in this project, and union the results.
"""
import json
import re
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent
DISTRIBUTIONS = ["MicroOS", "Tumbleweed"]
ARCHITECTURES = ["x86-64", "arm64"]


def resolved_packages(dist_dir: Path) -> list[str]:
    packages: set[str] = set()
    for arch in ARCHITECTURES:
        out = subprocess.run(
            ["mkosi", f"--architecture={arch}", "summary", "--json"],
            cwd=dist_dir,
            check=True,
            capture_output=True,
            text=True,
        ).stdout
        summary = json.loads(out)
        for image in summary["Images"]:
            packages.update(image.get("Packages", []))
    return sorted(packages)


def update_conf(obs_conf: Path, packages: list[str]) -> None:
    conf = obs_conf.read_text()

    new_block = "Packages=" + "".join(f"\n\t{p}" for p in packages) + "\n"

    updated, count = re.subn(
        r"Packages=.*\n(?:(?:[ \t]+.*|#.*)\n)*",
        new_block,
        conf,
        count=1,
    )
    if count != 1:
        sys.exit(f"error: could not find a Packages= block in {obs_conf}")

    obs_conf.write_text(updated)


def main() -> None:
    for dist in DISTRIBUTIONS:
        dist_dir = REPO_ROOT / dist
        obs_conf = dist_dir / "obs" / "mkosi.conf"
        packages = resolved_packages(dist_dir)
        update_conf(obs_conf, packages)
        print(f"Updated {obs_conf} with {len(packages)} packages.")


if __name__ == "__main__":
    main()
