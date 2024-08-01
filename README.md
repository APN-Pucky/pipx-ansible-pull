# pipx-ansible-pull

Virtualenvs for ansible-pull with pipx.

## Why?

- lock versions of ansible and its dependencies
- checksummed packaged to be sure nothing changed


## Setup

Add a `pyproject.toml` to your git repo that you want to use with ansible-pull.
Versions can be adjusted as needed.
We are using poetry here, but others should work as well.
```toml
[tool.poetry]
name = "pipx-ansible-pull"
version = "0.0.0"
description = ""
authors = ["Alexander Puck Neuwirth <alexander@neuwirth-informatik.de>"]
readme = "README.md"
repository = "https://github.com/APN-Pucky/pipx-ansible-pull"
packages = [{include = "READEME.md"}]

[tool.poetry.dependencies]
python = "^3.10"
ansible = "^9.4.0"

[tool.poetry.scripts]
pipx-ansible-pull = "ansible.cli.pull:main"

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```

After generating a lock file with `poetry lock` you have all dependencies fixed and can run it with `pipx`

```
pipx run --no-cache --spec git+https://github.com/APN-Pucky/pipx-ansible-pull.git@master ansible-pull -C master --inventory hosts --url https://github.com/APN-Pucky/pipx-ansible-pull.git site.yaml
```

or use the `pipx-ansible-pull` script from this repo to mimic the `ansible-pull` command.

```
pipx-ansible-pull -C master --inventory hosts --url https://github.com/APN-Pucky/pipx-ansible-pull.git site.yaml
```

## FAQ

- Why `--no-cache`?
  - This is to ensure that the latest version is always used. This is important for development and testing. While it disables pipx caching (venv creation), it is not a problem for the pip cache (package fetching).
