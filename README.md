# Introduction
The transform.sh bash script, can transform the docker-compose.yml of appwrite so that we can have multiple instances of appwrite within one server. This could be used if somebody wants to have a stage and production on the same vm.

# Execute permission needs to be added (decide to which group you want to assign the permissions)
chmod +x filename: Grants by default execute permissions to all.
chmod u+x filename: Grant only the owner execute permission.
chmod g+x filename: Grant only the group execute permission.
chmod o+x filename: Grant others execute permission.

# Execute the bash script
Navigate to the directory and execute like this: ./transform.sh docker-compose.yml
This will add the changes to the same file. Now you should be able to host a second appwrite instance on the same machine.

