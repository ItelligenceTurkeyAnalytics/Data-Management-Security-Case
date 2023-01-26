Before pushing you need to create a key and add that key to repo.  
Also yml is not pushing currently it conntects via different user and that user can't access to public access key. And we couldn't find the user that runner access to. So it is staying manuel for a while.  
  
git init  
git add .  
git remote set-url origin shh connection  
git commit -m "Automated commit of updated data schema"  
git push --force origin master  
  
