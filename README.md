bashrc
======

This is the central repo for quickly setup development environment, which contains the following
setup:

- `.bashrc`
- `$HOME/bin`

Usage
-----

- If you want to customize the shell only

  Include `helpers.sh` in your `.bashrc`:

          source /home/zeyuan/Documents/bashrc_helpers/helpers.sh

  Edit `helpers.sh` to tweak settings.

- If you want to use utilty scripts only, copy the scripts under ``bin`` to your ``bin`` directory and do:

  Linux:

        export PATH=$PATH:/home/your_user_name/bin

  OSX:

        export PATH=$PATH:/Users/your_user_name/bin