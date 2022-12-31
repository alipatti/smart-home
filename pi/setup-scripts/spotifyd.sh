# --------------
# SPOTIFYD SETUP
# --------------


sudo -v # validate as sudo

echo "Enter your Spotify credentials."
read -p 'Username: ' SPOTIFY_USERNAME
read -sp 'Password: ' SPOTIFY_PASSWORD

echo "Enter the name for your speaker."
read -p 'Speaker name: ' SPEAKER_NAME

echo "Installing spotifyd..."
wget "https://github.com/Spotifyd/spotifyd/releases/download/v0.3.4/spotifyd-linux-armv6-slim.tar.gz" && # download
    tar xzf spotifyd-linux-armv6*.tar.gz &&                                                                         # unpack
    sudo cp ./spotifyd /usr/bin/spotifyd                                                                 # add to bin

echo "Creating launch service..."
# create launch service file
sudo touch /etc/systemd/user/spotifyd.service 
curl "https://raw.githubusercontent.com/Spotifyd/spotifyd/master/contrib/spotifyd.service" | sudo tee /etc/systemd/user/spotifyd.service 

# enable launch service at launch
sudo loginctl enable-linger $(whoami)
systemctl --user enable spotifyd.service


echo "Creating configuration file..."
# create config file
CONFIG_FILE=~/.config/spotifyd/spotifyd.conf
mkdir -p ~/.config/spotifyd/
touch $CONFIG_FILE

# write to the file
printf "[global]\n" >$CONFIG_FILE
printf "username = \"$SPOTIFY_USERNAME\"\n" >>$CONFIG_FILE # spotify username
printf "password = \"$SPOTIFY_PASSWORD\"\n" >>$CONFIG_FILE # spotify password
printf "device_name = \"$SPEAKER_NAME\"\n" >>$CONFIG_FILE  # name shown in spotify connect menu

echo "Cleaning up..."
rm spotifyd-linux-armv6*
rm spotifyd

echo "Starting spotifyd..."
systemctl --user start spotifyd.service

echo "done!"
