sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.10 python3.10-distutils python3.10-venv -y
sudo apt install ruby-full -y
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
nvm install --lts



rm ~/.bash_aliases
cp ./.bash_aliases ~/.bash_aliases

echo "alias la=\"ls -a\"" >> .bashrc
echo "activfunction() { \"/home/$USER/envs/\$1/bin/activate \";}" >> ~/.bashrc
echo "alias activate='activfunction'" >> ~/.bashrc
echo "alias vim=\"~/.config/nvim/nvim.appimage\"" >> ~/.bashrc 

mkdir ~/envs
python3.10 -m venv ~/envs/nvim

mkdir ~/.config
mkdir ~/.config/nvim
cp ./nvim/* ~/.config/nvim
chmod ua+x ~/.config/nvim/nvim.appimage

echo "let g:python3_host_prog=\"/home/$USER/envs/nvim/bin/python3\"" >> ~/.config/nvim/init.vim

npm install --location=global neovim
sudo gem install neovim


cp -r ./fonts /home/$USER/.fonts
