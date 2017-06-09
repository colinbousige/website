#!/bin/bash  

# Set the English locale for the `date` command.
export LC_TIME=en_US.UTF-8

# The commit message.
MESSAGE="Site rebuild $(date)"

git add .
git commit -m "$MESSAGE"
git push -u origin master
Rscript blogdownbuild.R
cd public
pwd
git add .
git commit -m "$MESSAGE"
# git push -u origin master


# #!/bin/bash  

# # Set the English locale for the `date` command.
# export LC_TIME=en_US.UTF-8

# # GitHub username.
# USERNAME=colinbousige

# # The commit message.
# MESSAGE="Site rebuild $(date)"

# msg() {
#     printf "\033[1;32m :: %s\n\033[0m" "$1"
# }

# msg "Pulling down the \`master\` branch into \`public\` to help avoid merge conflicts"
# git subtree pull --prefix=public \
#     git@github.com:colinbousige/colinbousige.github.io.git origin master -m "Merge origin master"

# msg "Building the website"
# Rscript blogdownbuild.R

# msg "Pushing the updated \`public\` folder to the \`$SOURCE\` branch"
# git add public
# git commit -m "$MESSAGE"
# git push origin "$SOURCE"

# msg "Pushing the updated \`public\` folder to the \`master\` branch"
# git subtree push --prefix=public \
#     git@github.com:$USERNAME/$USERNAME.github.io.git master