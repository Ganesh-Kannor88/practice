#!/usr/bin/env python3
"""Simple hello world script."""

import argparse


def main():
    parser = argparse.ArgumentParser(description="Print a greeting.")
    parser.add_argument('-n', '--name', default='World', help='Name to greet')
    args = parser.parse_args()
    print(f"Hello, {args.name}!")


if __name__ == '__main__':
    main()