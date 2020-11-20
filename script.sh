source ~/.nvm/nvm.sh
ls
pwd
which node
node -v
yarn -v

nvm alias default node
nvm use default

pwd
which node
node -v
yarn -v

node_modules/.bin/eslint electron/** --ext .js