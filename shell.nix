with (import <nixpkgs> {});
mkShell {
  #buildInputs = [ tailwindcss static-web-server ];
  buildInputs = [ static-web-server ];
  shellHook = ''
    echo "Starting web server..."
    static-web-server -p 8000 --root www/
  '';
}
