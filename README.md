# Rationale ✏️
# Getting stared 🚀 
## Prerequisites 🧱
To get the most out of this repository you should need to install
* [VScode editor]()
* [Python 3.7+]()
* [Poetry for python]()
* [Docker and docker-compose]() *
* [zsh shell and oh-my-zsh]() *
## Project structure 🧭
Lets have a look at the project structure. In short this is your usual python repository with a few modifications. In short we 

1. Have our settings in either ```.vscode/``` or ```setup.cfg```
2. Define package dependencies in ```pyproject.toml```which in turn resolves and locks the dependencies in ```poetry.lock```
3. Pre-commit helps (or forces) the developer to commit code that adhere to the (commonly agreed upon) rules in ```.pre-commit-config.yaml´´´
4. If we want we can spin up a docker environment to develop inside with the content of ```.devcontainer/```
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

## Dependencies 🕸️
## Linting 🔎
## Testing 👷
## Devcontainer 🛸