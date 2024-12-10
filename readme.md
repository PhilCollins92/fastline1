# voir détails du build d'une image 
docker build --progess=plain 

# Configurer GitHub Container Registry
Activer GitHub Container Registry
Vérifiez que votre dépôt est public ou que vous disposez d'un Personal Access Token (PAT) pour un dépôt privé.
Créez un PAT avec les scopes suivants :
write:packages
read:packages
delete:packages
repo (si c'est pour un dépôt privé)

# Connectez-vous au GitHub Container Registry en utilisant votre nom d'utilisateur et votre PAT.
echo "GITHUB_PAT" | docker login ghcr.io -u GITHUB_USERNAME --password-stdin

# Taguer l'image Docker
Taguez l'image pour qu'elle soit compatible avec GitHub Container Registry. Le format est le suivant:
ghcr.io/<USERNAME>/<REPOSITORY>:<TAG> 
example: docker tag fastline-app ghcr.io/votre-utilisateur/fastline:latest