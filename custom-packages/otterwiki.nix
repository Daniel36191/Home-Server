{
  lib,
  python3Packages,
  fetchFromGitHub,
  fetchPypi,
}:
let
  werkzeug = fetchPypi {
    pname = "werkzeug";
    version = "3.1.5";
    hash = "";
  };
  flask-login = fetchPypi {
    pname = "flask-login";
    version = "0.6.3";
    hash = "";
  };
  flask-mail = fetchPypi {
    pname = "flask-mail";
    version = "0.10.0";
    hash = "";
  };
  sqlalchemy = fetchPypi {
    pname = "sqlalchemy";
    version = "2.0.36";
    hash = "";
  };
  flask-sqlalchemy = fetchPypi {
    pname = "flask-sqlalchemy";
    version = "3.1.1";
    hash = "";
  };
  flask = fetchPypi {
    pname = "flask";
    version = "3.1.1";
    hash = "";
  };
  jinja2 = fetchPypi {
    pname = "jinja2";
    version = "3.1.6";
    hash = "";
  };
  gitpython = fetchPypi {
    pname = "gitpython";
    version = "3.1.44";
    hash = "";
  };
  cython = fetchPypi {
    pname = "cython";
    version = "3.0.11";
    hash = "";
  };
  mistune = fetchPypi {
    pname = "mistune";
    version = "2.0.5";
    hash = "";
  };
  pygments = fetchPypi {
    pname = "pygments";
    version = "2.18.0";
    hash = "";
  };
  pillow = fetchPypi {
    pname = "pillow";
    version = "12.1.1";
    hash = "";
  };
  pyyaml = fetchPypi {
    pname = "pyyaml";
    version = "6.0.2";
    hash = "";
  };
  unidiff = fetchPypi {
    pname = "unidiff";
    version = "0.7.5";
    hash = "";
  };
  beautifulsoup4 = fetchPypi {
    pname = "beautifulsoup4";
    version = "4.12.3";
    hash = "";
  };
  pluggy = fetchPypi {
    pname = "pluggy";
    version = "1.5.0";
    hash = "";
  };
  regex = fetchPypi {
    pname = "regex";
    version = "2024.11.6";
    hash = "";
  };
  feedgen = fetchPypi {
    pname = "feedgen";
    version = "1.0.0";
    hash = "";
  };
in
python3Packages.buildPythonApplication (finalAttrs: {
  pname = "otterwiki";
  version = "2.17.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "redimp";
    repo = "otterwiki";
    tag = "v${finalAttrs.version}";
    hash = "sha256-BKkW6lfkLDYy3rXKPZaWythdGt2eP60xhKlkFnaHRTg=";
  };
  

  build-system = with python3Packages; [ setuptools ];

  dependencies = with python3Packages; [
    werkzeug
    flask-login
    flask-mail
    sqlalchemy
    flask-sqlalchemy
    flask
    jinja2
    gitpython
    cython
    mistune
    pygments
    pillow
    pyyaml
    unidiff
    beautifulsoup4
    pluggy
    regex
    feedgen
  ];
  doCheck = true;

  meta = {
    description = "A minimalistic wiki powered by python, markdown and git.";
    homepage = "https://github.com/redimp/otterwiki/";
    changelog = "https://github.com/redimp/otterwiki//releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
  };
})