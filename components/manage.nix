{
  authentik-src,
  authentikComponents,
  makeWrapper,
  runCommandLocal,
}:

runCommandLocal "authentik-manage"
  {
    nativeBuildInputs = [ makeWrapper ];
    buildInputs = [ authentikComponents.pythonEnv ];
  }
  ''
    mkdir -vp $out/bin
    cp -v ${authentik-src}/manage.py $out/bin/manage.py

    patchShebangs $out/bin
    wrapProgram $out/bin/manage.py \
      --prefix PYTHONPATH : ${authentikComponents.staticWorkdirDeps}
  ''
