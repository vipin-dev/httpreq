# project name and programming language
project('com.github.vipin-dev.httpreq', 'vala', 'c')

# Create a new executable, list the files we want to compile, list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/main.vala',
    'src/window.vala',
    'src/APINotebook/APINotebook.vala',
    'src/APINotebook/RequestPane.vala',
    'src/APINotebook/ResponsePane.vala',
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('libsoup-2.4'),
        dependency('gtksourceview-4'),
        dependency('webkit2gtk-4.0'),
        dependency('granite'),
        dependency('libhandy-1')
    ],
    install: true
)

# Install our .desktop file so the Applications Menu will see it
install_data(
    join_paths('data', 'httpreq.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications'),
    rename: meson.project_name() + '.desktop'
)

# Install our .appdata.xml file so AppCenter will see it
install_data(
    join_paths('data', 'httpreq.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo'),
    rename: meson.project_name() + '.appdata.xml'
)