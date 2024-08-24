# Add all changes to the staging area
git add .
# Prompt the user for a commit message >> commit the message
$name = Read-Host -Prompt "Enter commit message"
git commit -m "$name"
# Push the changes to the master branch
git push origin master
