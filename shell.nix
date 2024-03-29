with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    ruby_3_1
    git
    tig
    sqlite
    redis
    oniguruma
  ];
  shellHook = ''
	export GEM_HOME=$(pwd)/.ruby
	export PATH=$(pwd)/.ruby/bin:$PATH
    '';
}
