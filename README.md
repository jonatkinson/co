# co

`co` is a tool to clone Github repositories quickly, with minimal typing.

## Setup

First, make the script executable and move it somewhere on your path.

    chmod +x co.sh
    sudo mv co.sh /usr/local/bin/co

Next, create a configuration file, and add any Github organisations which you are a member of, one per line:

    cat << EOF > $HOME/.config/co.conf
    jonatkinson
    giantmade
    jazzband
    EOF

## Usage

To clone a repository, use:

    co reponame

The first matching repository found in your organisations will be cloned. If you need to change the order of precedence, just adjust the order of the organisations in your configuration file.

To clone to a specific destination, use:

    co reponame -d destination/ 
    
To clone a specific branch, use:

    co reponame -b branch-name