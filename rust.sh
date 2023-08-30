# to be run manually, for now

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

cargo install cargo-binstall
cargo install cargo-machete
# or
# wget https://github.com/cargo-bins/cargo-binstall/releases/latest/download/cargo-binstall-aarch64-apple-darwin.zip
# unzip cargo-binstall-aarch64-apple-darwin.zip
# mv cargo-binstall $HOME/.cargo/bin
# rm cargo-binstall-aarch64-apple-darwin.zip

cargo binstall cargo-watch
cargo binstall cargo-nextest --secure
