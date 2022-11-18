# Rationale ✏️
This sets up a simple python repository with a few handy tools to make Python development (a little) smoother.

# Getting stared 🚀 
## Prerequisites 🧱
To get the most out of this repository you should need to install
* [VScode editor](https://code.visualstudio.com/Download)
* [Python 3.7+](https://www.python.org/)
* [Poetry for python](https://python-poetry.org/)
* [Docker and docker-compose](https://www.docker.com/)*

_Docker and docker compose is only necessary if one plans to utilize VSCode devcontainers_

## Project structure 🧭
The structure is fairly simple. 

1. Editor settings are in ```.vscode/settings.json``` referencing ```setup.cfg``` as the ground truth.
2. Dependencies are defined ```pyproject.toml``` which replaces ```requirements.txt``` AND the ```setup.py```
3. Githooks are installed with ```.pre-commit-config.yaml``` to keep garbage out of the git tree.
4. The  content of ```.devcontainer/``` is autodetected by VSCode and can spin up containerized environment
```bash 
├── README.md 
├── .vscode (1)
├── .devcontainer (4)
├── python_package 
├── tests
├── pyproject.toml (2)
├── poetry.lock (2)
├── .gitignore
├── .pre-commit-config.yaml (3)
└── setup.cfg (1)
```
## Dependencies and builing 🕸️
Instead of installing packages with pip ```pip```, keeping track of them with ```requirements.txt``` and build with ```setup.py``` this project utilize ```poetry``` bundled with 
```pyproject.toml```. Poetry is both a build and dependecy tool which in many ways compare with ``` npm```.

### Install the project
When a ```pyproject.toml``` is present the project can be installed by running
```bash
poetry install
``` 
This will create a virtual environment, install all dependencies and dev-tools to this environment and add the source folder to the ```PYTHONPATH```.

_[VSCode is compatible with poetry and will detect the created environement](https://devblogs.microsoft.com/python/python-in-visual-studio-code-april-2021-release/#support-for-poetry-environments)_

### Locking down dependencies
The power of poetry is resolving dependecy conflicts and locking these down. This way a working version of the project can be installed across environments.

When adding or removing dependencies from the project a ```poetry.lock``` file is generated/altered. This file **should** be checked into the repository. 

The most useful commands are:
```bash
poetry add <PACKAGE NAME> # Add a new dependency
poetry remove <PACKAGE NAME> # Remove dependency
poetry update # Update all dependencies 
```

### Building
Using ```pip``` and ```setup.py``` requires a manual job to keep the dependencies in sync. Since ```poetry``` replaces both the project can easly be build running 

```bash
poetry build
```
The ```pyproject.toml``` file is also compatible with pip and one can easily install the project running 
```bash
pip install .
```
## Linting 🔎
### Linting in VSCode
VSCode support the python language with really good intellisense support through the Python extension(s). Lately there have also been created extensions for the most popular linters. These can also be used by installing them in the environment (we will in fact do both).

For an enhanced coding experience:
* [Black](https://black.readthedocs.io/en/stable/) will autoformat the code (on save)
* [Isort](https://pycqa.github.io/isort/) will reorder the imports (on save)
* [Flake8](https://flake8.pycqa.org/en/latest/#) enforces pep8 coding standard
* [Pylint](https://pylint.pycqa.org/en/latest/) removes pesky bugs
* [Pydocstyle](http://www.pydocstyle.org/en/stable/) make sure we write docstrings
* [Autodocstring](https://marketplace.visualstudio.com/items?itemName=njpwerner.autodocstring) Helps us create docstring templates (and have type hint support)



## Testing 👷
## Devcontainer 🛸