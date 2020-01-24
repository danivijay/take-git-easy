# take-git-easy

Designed for teams that have no idea when their features will go live. This workflow requires 4 stacks to be fully functional

1. `local` stack for developer testing
1. Disposable `qa` stack for testing
1. `release` stack for integration testing
1. `master` stack for production

## Stacks

### local

- **always take from master**
- prefixed with 
    - `feature/` : for full-fledged features - if some bug found while **qa** testing, please fix it here and re-merge 
    - `bugfix/` : for bug fixes, **only if corresponding feature is merged to master** - **IF AND ONLY IF** merging multiple features created a new bug, create a new **bugfix** from **release**, otherwise make changes in **feature** and re-merge 
    - `hotfix/` : you messed up your production build, this should merge immediately to master to make things work again, **ALWAYS reverse-merge to release once merged to master**. I repeat, **ALWAYS**.
- merge to **qa** for testing
- merge to **release** for integration testing
- **NO REVERSE MERGES EXCEPT FROM MASTER**, in case of integration errors (only if the issue caused because of more than one feature of that particular release), create a `bugfix` from **release**

### qa

- for testing, **ONLY** for features that cannot be tested in **Local**
- **always take from master**
- prefixed with `qa/`
- **DO NOT** merge this branch directly to **release** (or **master**, obviously)
- **DO NOT** reverse merge this branch to **local** branches
- if all features are tested, create a new brach and **delete** the existing one. Communication is your key.
- naming scheme - if a **qa** branch already available for current **release** `qa/<release-version>.<qa-version + 1>`. 
    - Eg: if no **qa** branch available for current release, and **release** version is 2 name as `qa/2.1` 
    - Eg: if **release** is **2** and **qa** is **1** (ie, current **qa** is `qa/2.1`), name as `qa/2.2`
- **DO NOT** reverse merge **release** or **master**, create a new one from master instead whenever testing is complete

### release

- for integration testing
- **always take from master**
- prefixed with `release/`
- **ONLY** merge **local** branches that already tested
- **NEVER** merge **qa**
- **DO NOT** reverse merge this to **Local** branches
- naming schema: `<release-version + 1>`
- merge to master once integration testing is complete
- **whenever merges to master, CREATE A NEW RELEASE, and don't use the existing one**

### master

- for production
- **ONLY** merge either **release** or **hotfix**

## feat-maker script

A simple script to easily create local branches

1. Fetches git repo
2. Checkout to master
3. Pull master
4. Create local branch from feature id and name of your choice

#### How to use

1. Download `tge-feat-maker.sh` and place it in root of your repo
2. Run `bash ./tge-feat-maker.sh` from your repo
3. follow instructions
