# Setup

1. `cd ~`
2. `git init`
3. `touch init`
4. `git add init`
5. `git commit -m Init`
    5a. `git config global user.email "email"`
    5b. `git config global user.name "name"`
6. `git remote add master https://github.com/Markussss/dotfiles`
7. `git branch --set-upstream-to=master/master master`
8. `git pull --rebase`
9. `git reset --hard HEAD~1`
10. `git submodule init`
11. `git submodule update --recursive`

