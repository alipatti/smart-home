# --------------
# SPOTIFYD SETUP
# --------------

CONFIG_FILE=~/.config/spotifyd/spotifyd.conf

sudo -v # validate as sudo

echo "Enter your Spotify credentials."
read -p 'Username: ' SPOTIFY_USERNAME
read -sp 'Password: ' SPOTIFY_PASSWORD

echo "Enter the name for your speaker."
read -p 'Speaker name: ' SPEAKER_NAME

echo "Installing spotifyd..."
wget "https://github.com/Spotifyd/spotifyd/releases/download/v0.3.4/spotifyd-linux-armv6-slim.tar.gz" && # download
    tar xzf spotifyd-*.tar.gz &&                                                                         # unpack
    sudo cp ./spotifyd /usr/bin/spotifyd                                                                 # add to bin

echo "Creating launch service..."
curl "https://raw.githubusercontent.com/Spotifyd/spotifyd/master/contrib/spotifyd.service"
>/etc/systemd/user/spotifyd.service

echo "Creating configuration file..."
printf "[global]\n" >$CONFIG_FILE
printf "username = \"$SPOTIFY_USERNAME\"\n" >>$CONFIG_FILE # spotify username
printf "password = \"$SPOTIFY_PASSWORD\"\n" >>$CONFIG_FILE # spotify password
printf "device_name = \"$SPEAKER_NAME\"\n" >>$CONFIG_FILE  # name shown in spotify connect menu

echo "Starting spotifyd..."
spotifyd

echo "done!"
