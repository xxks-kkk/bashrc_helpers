#!/usr/local/bin/python3

# A wrapper to test query v2 API

# Advantage: directly replace the `query` variable with any SQL string
#            to run the test. In command line, the SQL has to be in one-line
#            to ensure nothing wrong, which is cumbersome.

import subprocess
import sys
import os

MY_ENV = os.environ.copy()
COMMAND_TEMPLATE = """
aws timestream-query query-v2 --query-string "{}" --endpoint-url "https://gamma-query-cell2.timestream.us-west-2.amazonaws.com" --region  us-west-2
"""

query = """
SELECT region
FROM
  (VALUES
    ('abc')
  )
AS testtb(region)
"""

def main(argv=sys.argv[1:]):
    """main program
    """
    try:
        cmd = COMMAND_TEMPLATE.format(query)
        print(f'test query: {query}')
        popen = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
                                 universal_newlines=True, env=MY_ENV)
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
