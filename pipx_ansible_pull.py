import sys
import argparse
import subprocess

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-U', '--url', type=str, required=True, help='URL to pull from')
    parser.add_argument('-C', '--checkout', type=str, required=False, help='Branch or tag to checkout')
    parser.add_argument('rest_args', nargs=argparse.REMAINDER, help='Additional ansible-pull options')

    args = parser.parse_args()

    if not args.url:
        print("Error: URL is required")
        usage()

    checkout = f"@{args.checkout}" if args.checkout else ""
    url = args.url
    rest_args = args.rest_args

    command = ['pipx', 'run', '--no-cache', '--spec', f'git+{url}{checkout}', 'ansible-pull', '-U', url] + rest_args

    try:
        subprocess.run(command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while running ansible-pull: {e}")
        sys.exit(1)

if __name__ == '__main__':
    main()
