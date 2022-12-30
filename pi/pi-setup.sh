# --------------
# GENERAL SETUP
# --------------

# update apt
sudo apt-get update

# ----------------
# HOMEBRIDGE SETUP
# ----------------

# (taken from: https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian)

# Add the Homebridge Repository GPG key:
curl -sSfL https://repo.homebridge.io/KEY.gpg | sudo gpg --dearmor | sudo tee /usr/share/keyrings/homebridge.gpg >/dev/null

# Add the Homebridge Repository to the system sources:
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee /etc/apt/sources.list.d/homebridge.list >/dev/null

# Install Homebridge:
sudo apt-get install homebridge

# --------------
# SPOTIFYD SETUP
# --------------

sudo apt-get install spotifyd

# TODO configure spotifyd
