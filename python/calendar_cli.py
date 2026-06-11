#!/usr/bin/env python3
"""Simple calendar CLI.

Usage:
  python calendar_cli.py                 # current month
  python calendar_cli.py -y 2026 -m 6    # June 2026
  python calendar_cli.py --weekstart sun # weeks start on Sunday
"""

import argparse
import calendar
import datetime
import sys


def main():
    parser = argparse.ArgumentParser(description="Print a month calendar.")
    parser.add_argument('-y', '--year', type=int, default=datetime.date.today().year, help='Year (e.g. 2026)')
    parser.add_argument('-m', '--month', type=int, choices=range(1,13), default=datetime.date.today().month, help='Month (1-12)')
    parser.add_argument('-w', '--weekstart', choices=['mon','sun'], default='mon', help='Week start: mon or sun')
    args = parser.parse_args()

    firstweekday = calendar.MONDAY if args.weekstart == 'mon' else calendar.SUNDAY
    cal = calendar.TextCalendar(firstweekday=firstweekday)

    try:
        output = cal.formatmonth(args.year, args.month)
    except Exception:
        print('Invalid year/month', file=sys.stderr)
        sys.exit(1)

    print(output)


if __name__ == '__main__':
    main()