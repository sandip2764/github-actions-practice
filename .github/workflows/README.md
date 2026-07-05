# GitHub Actions - Beginner Notes 🚀

## What is GitHub Actions?

**GitHub Actions** is GitHub's built-in automation service.

It allows you to automatically perform tasks whenever an event happens in your repository.

Examples:

* Someone pushes code
* A Pull Request is created
* A release is published
* A schedule (cron) is triggered
* A workflow is started manually

Instead of doing these tasks yourself, GitHub Actions does them automatically.

---

# What is CI/CD?

CI/CD stands for:

* **CI** = Continuous Integration
* **CD** = Continuous Delivery / Continuous Deployment

## Continuous Integration (CI)

Continuous Integration means developers frequently merge their code into the main branch.

Every time code is pushed, an automated process can:

* Download the code
* Build the project
* Run tests
* Check code quality
* Report success or failure

Example:

```text
Developer
      │
git push
      │
      ▼
GitHub Actions
      │
      ├── Build
      ├── Test
      └── Report Result
```

---

## Continuous Delivery (CD)

After the application passes all tests, it is prepared for deployment.

A person can approve the deployment.

Example:

```text
Build
   │
Tests Passed
   │
Manual Approval
   │
Deploy
```

---

## Continuous Deployment

Everything is automated.

When tests pass successfully, the application is deployed automatically without human approval.

```text
Push
  │
Build
  │
Tests
  │
Deploy Automatically
```

---

# What is a Pipeline?

A **Pipeline** is the complete automated process that takes your code from development to deployment.

Example pipeline:

```text
Code Push
     │
Checkout Code
     │
Install Dependencies
     │
Run Tests
     │
Build Application
     │
Deploy
```

A pipeline contains multiple stages executed in order.

---

# What is a Workflow?

A **Workflow** is a YAML file that defines automation.

Every workflow is stored inside:

```text
.github/
└── workflows/
    └── workflow-name.yml
```

Example:

```yaml
name: Hello Workflow

on:
  push:
    branches:
      - main
```

A repository can have multiple workflows.

Example:

```text
.github/workflows/

build.yml

test.yml

deploy.yml

docker.yml
```

Each workflow has a different responsibility.

---

# Workflow Structure

```text
Workflow
   │
   ├── Event (on)
   │
   ├── Jobs
   │
   └── Steps
```

---

# What is an Event?

An event tells GitHub **when** to start a workflow.

Examples:

```yaml
on:
  push:
```

```yaml
on:
  pull_request:
```

```yaml
on:
  workflow_dispatch:
```

```yaml
on:
  schedule:
```

---

# What is a Job?

A **Job** is a collection of related steps.

Example:

```yaml
jobs:

  build:

  test:

  deploy:
```

Each job runs on its own runner.

Jobs can run:

* Sequentially
* In parallel
* Depending on other jobs

---

# What is a Runner?

A **Runner** is the machine that executes your workflow.

GitHub provides hosted runners like:

```yaml
runs-on: ubuntu-latest
```

Other options include:

```yaml
runs-on: windows-latest
```

```yaml
runs-on: macos-latest
```

You can also create your own self-hosted runner.

---

# What are Steps?

A **Step** is a single task inside a job.

Example:

```yaml
steps:

- run: pwd

- run: ls

- run: echo "Hello"
```

A job contains multiple steps.

---

# What is `run`?

`run` executes shell commands on the runner.

Example:

```yaml
steps:

- run: pwd

- run: ls -la

- run: mkdir demo

- run: touch hello.txt
```

Think of `run` as opening a terminal and typing commands yourself.

---

# What is `uses`?

`uses` executes an existing GitHub Action instead of running shell commands.

Example:

```yaml
steps:

- uses: actions/checkout@v4
```

GitHub downloads and executes that Action for you.

---

# What is an Action?

An **Action** is reusable code that performs a specific task.

Instead of writing everything from scratch, you can reuse actions created by GitHub or the community.

Examples:

```yaml
- uses: actions/checkout@v4
```

Downloads your repository onto the runner.

```yaml
- uses: actions/setup-node@v4
```

Installs Node.js.

```yaml
- uses: actions/setup-python@v5
```

Installs Python.

```yaml
- uses: docker/login-action@v3
```

Logs in to Docker Hub or another container registry.

---

# Why do we need `actions/checkout`?

When a runner starts, it is an empty machine.

Without checkout:

```text
Runner

(No project files)
```

After:

```yaml
- uses: actions/checkout@v4
```

Your repository is downloaded.

Now commands like:

```yaml
- run: ls

- run: cat README.md
```

work correctly because the project files are available.

---

# Basic Workflow Example

```yaml
name: Hello GitHub Actions

on:
  push:
    branches:
      - main

jobs:
  create-file:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - run: touch hello.txt

      - run: echo "Hello from GitHub Actions!" > hello.txt

      - run: cat hello.txt

      - run: ls -la
```

---

# Understanding the Flow

```text
Developer
     │
git push
     │
     ▼
GitHub
     │
Triggers Workflow
     │
Creates Runner
     │
Downloads Repository
(actions/checkout)
     │
Runs Step 1
     │
Runs Step 2
     │
Runs Step 3
     │
Workflow Finished
```

---

# Folder Structure

```text
my-project/

.github/
└── workflows/
    └── hello.yml

README.md

Dockerfile

app.py
```

GitHub only detects workflow files placed inside:

```text
.github/workflows/
```

---

# Common GitHub Actions Keywords

| Keyword   | Purpose                                         |
| --------- | ----------------------------------------------- |
| `name`    | Workflow name                                   |
| `on`      | Event that triggers the workflow                |
| `jobs`    | Groups of work                                  |
| `runs-on` | Runner operating system                         |
| `steps`   | Individual tasks                                |
| `run`     | Execute shell commands                          |
| `uses`    | Execute an existing GitHub Action               |
| `with`    | Pass inputs to an Action                        |
| `env`     | Define environment variables                    |
| `needs`   | Make one job depend on another                  |
| `if`      | Run a job or step only when a condition is true |

---

# Summary

* GitHub Actions automates software workflows.
* CI verifies code changes automatically.
* CD delivers or deploys applications after successful verification.
* A pipeline is the complete automation process.
* A workflow is a YAML file that defines automation.
* A workflow contains one or more jobs.
* A job contains one or more steps.
* A runner is the machine that executes the jobs.
* `run` executes shell commands.
* `uses` executes reusable GitHub Actions.
* `actions/checkout` downloads your repository onto the runner.
* Workflow files must be stored inside `.github/workflows/`.
