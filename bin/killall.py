#!/usr/local/bin/python3

# Kill all the processes obtained by the given pattern

import subprocess
import argparse
import sys

COMMAND_TEMPLATE = "kill -9 $(ps aux | grep '{pattern}' | awk '{{ print $2 }}')"

def get_parser():
    # type: () -> argparse.ArgumentParser
    """generate the command parser
    """
    parser = argparse.ArgumentParser(
        usage='%(prog)s [OPTIONS]',
        description="""
        Kill all the processes obtained by the given pattern
        """)
    parser.add_argument('-p', '--pattern', dest='pattern', help='pattern of the target process(es)')
    parser.add_argument('--dry-run', action='store_true', dest='dry-run',
                        help='dry run the generated command')
    return parser

def main(argv=sys.argv[1:]):
    """main program
    """
    parser = get_parser()
    try:
        args = parser.parse_args(argv)
    except SystemExit as err:
        return err.code
    d = vars(args)
    d = dict((k, v) for k, v in d.items() if not (v is None or v is False))
    return_code = 0
    try:
        cmd = COMMAND_TEMPLATE.format(pattern=d['pattern'])
        if 'dry-run' in d:
            print(f'Command will run: {cmd}')
        else:
            popen = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
                                     universal_newlines=True)
            for stdout_line in iter(popen.stdout.readline, ""):
                print(f'got line from subprocess: {stdout_line}')
            popen.stdout.close()
            return_code = popen.wait()
    except(KeyboardInterrupt, EOFError):
        print()
        print('[Interrupted.]')
        return_code = 130
    return return_code

if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
