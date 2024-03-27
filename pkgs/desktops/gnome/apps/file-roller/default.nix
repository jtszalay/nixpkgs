{ lib
, stdenv
, fetchurl
, fetchpatch
, desktop-file-utils
, gettext
, glibcLocales
, itstool
, libxml2
, meson
, ninja
, pkg-config
, python3
, wrapGAppsHook
, cpio
, glib
, gnome
, gtk4
, libadwaita
, libhandy
, json-glib
, libarchive
, libportal-gtk4
, nautilus
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "file-roller";
  version = "44";

  src = fetchurl {
    url = "mirror://gnome/sources/file-roller/${lib.versions.major finalAttrs.version}/file-roller-${finalAttrs.version}.tar.xz";
    sha256 = "WxwOai5951OSvUJFUMHlZD3Rz2wzP7HtanZBmilQeqQ=";
  };

  nativeBuildInputs = [
    desktop-file-utils
    gettext
    glibcLocales
    itstool
    libxml2
    meson
    ninja
    pkg-config
    python3
    wrapGAppsHook
  ];

  buildInputs = [
    cpio
    glib
    gtk4
    libadwaita
    libhandy
    json-glib
    libarchive
    libportal-gtk4
    nautilus
  ];

  postPatch = ''
    patchShebangs data/set-mime-type-entry.py
  '';

  passthru = {
    updateScript = gnome.updateScript {
      packageName = "file-roller";
      attrPath = "gnome.file-roller";
    };
  };

  meta = with lib; {
    homepage = "https://wiki.gnome.org/Apps/FileRoller";
    description = "Archive manager for the GNOME desktop environment";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = teams.gnome.members ++ teams.pantheon.members;
    mainProgram = "file-roller";
  };
})
