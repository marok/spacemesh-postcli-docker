#!/usr/bin/env python3

import argparse
import dropbox
import sys

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog='Access token generator for Dropbox')
    parser.add_argument("-r", "--refresh-token", required=True)
    parser.add_argument("-a", "--app-key", required=True)
    args = parser.parse_args()

    with dropbox.Dropbox(oauth2_refresh_token=args.refresh_token, app_key=args.app_key) as dbx:
        dbx.check_and_refresh_access_token()
        sys.stdout.write(dbx._oauth2_access_token)
