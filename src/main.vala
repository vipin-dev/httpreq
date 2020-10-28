int main (string[] args) {
	var app = new Gtk.Application ("com.github.vipin-dev.httpreq", ApplicationFlags.FLAGS_NONE);

	app.startup.connect(()=> {
		Hdy.init();
	});
	app.activate.connect (() => {
		var win = app.active_window;
		if (win == null) {
			win = new HTTPRq.Window (app);
			var notebooks = new Granite.Widgets.DynamicNotebook();
            var notebook = new APINotebook();
            notebooks.new_tab_requested.connect(()=> {
                notebooks.insert_tab(new Granite.Widgets.Tab("Untitled",null, new APINotebook()),1);
            });
			notebooks.insert_tab(new Granite.Widgets.Tab("Untitled",null, notebook),0);
			notebooks.vexpand = true;

	
			var titlebar = new Hdy.HeaderBar();
			titlebar.margin_bottom = 0;
			titlebar.add(new Gtk.Label("HTTPRq"));
			titlebar.valign = Gtk.Align.START;

			var container = new Gtk.Box(Gtk.Orientation.VERTICAL,0);
			container.add(titlebar);
			container.add(notebooks);
            win.add(container);
            win.show_all();
		}
		var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();

        gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
        });
		win.present ();
	});

	return app.run (args);
}
