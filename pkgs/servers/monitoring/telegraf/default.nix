{ lib
, buildGoModule
, fetchFromGitHub
, nixosTests
, testers
, telegraf
}:

buildGoModule rec {
  pname = "telegraf";
  version = "1.28.4";

  subPackages = [ "cmd/telegraf" ];

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "telegraf";
    rev = "v${version}";
    hash = "sha256-Z6BhMLpuK7j8yo3XGlu6DaTv6e+VMa9fft/KtWNprpc=";
  };

  vendorHash = "sha256-ebfch59JXJYxXcoIPc8XdkRugsjZ1pKCgvUXODSWTrw=";
  proxyVendor = true;

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/influxdata/telegraf/internal.Commit=${src.rev}"
    "-X=github.com/influxdata/telegraf/internal.Version=${version}"
  ];

  passthru.tests = {
    inherit (nixosTests) telegraf;
    version = testers.testVersion {
      package = telegraf;
    };
  };

  meta = with lib; {
    description = "The plugin-driven server agent for collecting & reporting metrics";
    homepage = "https://www.influxdata.com/time-series-platform/telegraf/";
    changelog = "https://github.com/influxdata/telegraf/blob/${src.rev}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 roblabla timstott zowoq ];
  };
}
