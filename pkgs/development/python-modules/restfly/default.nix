{ lib
, arrow
, buildPythonPackage
, fetchFromGitHub
, pytest-datafiles
, pytest-vcr
, pytestCheckHook
, python-box
, requests
}:

buildPythonPackage rec {
  pname = "restfly";
  version = "1.4.5";

  src = fetchFromGitHub {
    owner = "stevemcgrath";
    repo = pname;
    rev = version;
    sha256 = "sha256-wWFf8LFZkwzbHX545tA5w2sB3ClL7eFuF+jGX0fSiSc=";
  };

  propagatedBuildInputs = [
    requests
    arrow
    python-box
  ];

  checkInputs = [
    pytest-datafiles
    pytest-vcr
    pytestCheckHook
  ];

  disabledTests = [
    # Test requires network access
    "test_session_ssl_error"
  ];

  pythonImportsCheck = [ "restfly" ];

  meta = with lib; {
    description = "Python RESTfly API Library Framework";
    homepage = "https://github.com/stevemcgrath/restfly";
    license = with licenses; [ mit ];
    maintainers = with maintainers; [ fab ];
  };
}
