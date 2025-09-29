# Setting up Python in VSCode

## Rationale ✏️

This sets up a simple python repository with a few handy tools to make Python development (a little) smoother.

## Getting started 🚀

### Prerequisites 🧱

To get the most out of this setup you need to install

* [VSCode editor](https://code.visualstudio.com/Download)
* [uv: Python packaging](https://docs.astral.sh/uv/getting-started/installation/)
* [Docker (Optional)](https://docs.docker.com/engine/install/)

>_Docker_ with _docker-compose_ is only necessary if one plans to utilize VSCode _devcontainers_

## Project structure 🧭

The structure is fairly simple. In this section we focus on the files directly related to setting up/configuring the development environment.

1. Editor settings are in ```.vscode/settings.json``` referencing ```pyproject.toml``` as the ground truth.
2. Dependencies are defined in ```pyproject.toml``` and locked with ```uv.lock``` which replaces ```requirements.txt``` AND ```setup.py```.
3. Git hooks are configured in ```.pre-commit-config.yaml``` (executed via `prek`) to keep garbage out of the git tree.
4. The content of ```.devcontainer/``` is auto detected by VSCode and can spin up a containerized environment.

> Supported Python: `>=3.10` (Docker devcontainer currently pins 3.13). Use a matching interpreter locally for parity.

```bash
├── README.md
├── .vscode
|   └── settings.json (1)  
├── .devcontainer (4)
├── python_package
├── tests
├── pyproject.toml (2)
├── uv.lock (2)
├── .gitignore
└── .pre-commit-config.yaml (3)
```

## Dependencies and building 🕸️

Instead of installing packages with ```pip```, keeping track of them with ```requirements.txt``` and building with ```setup.py```, this project uses ```uv``` bundled with ```pyproject.toml``` and ```uv.lock```. UV is both a build and dependency tool which in many ways is comparable with ```npm```.

>If you haven't already - here is the [guide to install UV](https://docs.astral.sh/uv/getting-started/installation/)

### Installing the project

When the project is defined by a ```pyproject.toml``` it can easily be installed and synced with the ```uv``` CLI. This will create a virtual environment, install all dependencies and dev-tools to this environment and add the source folder to the ```PYTHONPATH```.

```bash
uv sync
```

```pyproject.toml``` is compatible with ```pip``` and can still be installed by running:

```bash
pip install .
```

### Locking down dependencies

The true power of ```uv``` lies in resolving dependency conflicts and locking these down. This way an identical working version of the project can be installed across environments.

When adding or removing dependencies from the project a ```uv.lock``` file is generated/altered. This file **should** be checked into the repository.  

>The ```pyproject.toml``` file can be edited directly or altered with the ```uv``` CLI. [The CLI documentation can be found here](https://docs.astral.sh/uv/reference/cli)

### Building

Since ```pyproject.toml``` replaces ```setup.py```, the project can easily be built by running:

```bash
uv build
```

UV will then build wheels and by default add them to a ```dist``` folder in the project root.

## Linting 🔎

### Autoformatting in VSCode

### Linting in VSCode

VSCode supports the Python language with really good intellisense support through the Python extension(s). Lately there have also been created extensions for the most popular linters. These can also be used by installing them in the Python environment (we will in fact do both).

For an enhanced coding experience:

* [Ruff](https://docs.astral.sh/ruff/) - linting and formatting implemented in blistering fast Rust (replacing flake8, isort, black and pydocstyle).
* [Pylint](https://pylint.pycqa.org/en/latest/) - deeper design/static analysis (runs pre-push via hook)
* [Autodocstring](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) Helps us create docstring templates (and have type hint support)

The configuration of the linters are set in ```pyproject.toml```. The linters are also managed by ```.vscode/settings.json```.

>For VSCode these linters are actual extensions with bundled executables and _should_ be faster than invoking linters installed with the Python interpreter. To use the linters installed with the interpreter, set  
```importStrategy``` to ```fromEnvironment```.

### Linting with prek

_Migration note:_ We replaced the `pre-commit` CLI with the faster drop‑in alternative `prek`; the config file (`.pre-commit-config.yaml`) remains the same.

Linting (and other code quality measures) are enforced by [prek](https://github.com/j178/prek) — a faster drop‑in replacement for [pre-commit](https://pre-commit.com/#intro). It uses the same ```.pre-commit-config.yaml``` format. Hooks run either before `commit` or on `pre-push` depending on their configuration.

>Think of these git hooks (managed by `prek`) as a lightweight local CI pipeline enforcing agreed coding styles & safety checks. Configuration lives in `.pre-commit-config.yaml` (same schema as pre-commit).

To install / refresh the git hooks defined in `.pre-commit-config.yaml`:

```bash
uv tool install prek  # no-op if already installed via devcontainer
prek install           # sets up .git/hooks/*
```

The hooks are now installed and most of them will be run every time you try to ```commit``` to your local branch. A few are ```on push``` only.

Useful `prek` commands:
```bash
prek run                 # run all hooks on staged files
prek run --all-files     # run all hooks on the whole repo
prek run ruff ruff-format  # run a subset
```

If you really need to check in some code and a hook (via `prek`) blocks you, you can bypass once (not recommended):

```bash
git commit -m "commit message" --no-verify
```

#### Hooks (prek consuming `.pre-commit-config.yaml`)

| Name           | Explanation                                                                 |
|----------------|-----------------------------------------------------------------------------|
| ruff           | Lints Python code and applies automatic fixes using Ruff, driven by your `pyproject.toml` config. |
| ruff-format    | Formats Python code according to Ruff’s formatting rules, using your project config.           |
| pylint         | Runs Pylint static analysis on your Python files (using `pyproject.toml` for settings).       |
| pytest-check   | Executes your test suite with pytest to ensure no tests are broken before pushing.            |
| uv-lock        | Validates the integrity and correctness of your `pyproject.toml` lock file.                   |
| deptry         | Detects unused or missing dependencies in your Python project.                                 |
| vulture        | Detects unused (dead) code                                                                     |
| detect-secrets | Scans your codebase for potential secret tokens or credentials before pushing.               |


#### Some extra words about Detect-secrets
To prevent accidental commits of sensitive information, we use [detect-secrets](https://github.com/Yelp/detect-secrets) with `prek` (pre-commit compatible hook). These are usually passwords, tokens or other credentials that you don't want public.

Detect-Secrets will prevent pushes to remote repository if a secret has been checked in. Detect-secrets checks the content of the repository towards
```.secrets.baseline```.

If a new potential secret is added we can rescan the repositroy to add lines of code we want to allow to push.

Create the baseline file the first time - audit this carefully.

```bash
detect-secrets scan > .secrets.baseline
```

If the ```.secrets.baseline``` file needs updating you can do

```bash
detect-secrets scan --baseline .secrets.baseline > .secrets.baseline
```

## Testing 👷

The Python extension in VSCode comes with support of several testing frameworks. Here the choice fell on ```pytest``` and ```pytest-cov``` (the coverage plugin for ```pytest```).

### Configuring pytest

Pytest is configured via `[tool.pytest]` in `pyproject.toml` (tests path). `.vscode/settings.json` enables auto discovery on save.

### Running tests

To run the tests in VSCode you can either:

#### Run tests from the GUI

...by going to the ```tests``` pane or opening an actual test file like ```package_test.py``` and going to a specific test. Next to the test an icon should appear that one can click to run the specific test! This requires that the tests are discovered.

>Tests should have been auto discovered by VSCode - but if they're not showing - try running
> ```Python: Configure Tests``` in the VSCode command palette 🎨.

#### Run tests from the command line

Tests can always be run in the terminal by typing:

```bash
uv run pytest tests
```

### Debugging tests

One of the nicest features with VSCode and testing is the ability to easily debug tests. In the world of test driven development (TDD) this is really useful!

To debug a specific test - right-click the "Run" icon next to the test and select ```debug test``` from the drop-down. Add a breakpoint in the test and step through your code!

### Coverage

Test coverage is currently not well supported in VSCode. Although there are a few extensions available (a bit less than 1m downloads). In this setup we choose to do coverage the old-fashioned way!

This means generating a coverage report using [coverage](https://coverage.readthedocs.io/en/7.0.1/).

#### Generate a coverage report

To generate a coverage report run the following command in the terminal:

```bash
uv run pytest --cov-report term-missing --cov=python_package tests
```

To generate an interactive coverage report in html simply run:

```bash
uv run pytest --cov-report html --cov=python_package tests
```
Open `htmlcov/index.html` in a browser.

## Devcontainer 🛸

Devcontainers are one of the most powerful features of VSCode. Instead of going around "helping" everyone with environment-related issues we can package everything into a docker-container and spin it up!
Did an intentional or unintentional change happen to your environment? No worries - check in intentional changes and distribute faster than I can say "git commit" or rebuild the entire environment with a click of a button!

The devcontainer files sit in ```.devcontainer``` folder and consist of

```bash
├── Dockerfile (1)
├── devcontainer.json (2)
├── docker-compose.yaml (3)
├── postCreateCommand.sh (4)
└── postStartCommand.sh (5)
```
1. The Dockerfile that defines the environment. Build your own or there is [a variety to choose from here](https://hub.docker.com/_/microsoft-vscode-devcontainers)
2. ```devcontainer.json``` - The file that configures the environment!
3. ```docker-compose.yaml``` - I have chosen to extend ```.devcontainer.json``` with a docker-compose file. This allows easily extending the environment with supporting services such as a database or a S3 mock.
4. ```postCreateCommand.sh``` is a script that is run after the environment is built the first time (installs `prek` & hooks, syncs deps).
5. ```postStartCommand.sh``` runs each container start (sync / idempotent setup tasks).

> The devcontainer pre-installs uv + prek and performs a frozen sync on start; local hosts only need `uv sync` + `prek install` once.

[Follow this excellent guide to get going!](https://code.visualstudio.com/docs/devcontainers/containers)

There is not much more to add other than:

1. Open the repository root!
2. Windows users - you **must** use this in context of WSL2. It's both faster, simpler and less error-prone! ([and strongly recommended!](https://code.visualstudio.com/docs/devcontainers/containers#_open-a-wsl-2-folder-in-a-container-on-windows))
3. Press ```ctrl/command+shift+p``` and type ```"open folder in container"```
4. Sit back and relax while the environment is spun up 🚀🚀🚀!
