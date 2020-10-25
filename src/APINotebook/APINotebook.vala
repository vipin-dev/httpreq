class APINotebook : Gtk.Paned {
    public APINotebook() {
        orientation = Gtk.Orientation.VERTICAL;
        var requestPane = new RequestPane();
        var responsePane = new ResponsePane();
        var text_view = new Gtk.TextView ();
        text_view.editable = false;
        text_view.cursor_visible = false;

        var scroll = new Gtk.ScrolledWindow (null, null);
        scroll.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        scroll.add (text_view);
        requestPane.response.connect((data, url) => {
            responsePane.set_response(data, url);
        });
        add1(requestPane);
        add2(responsePane);
    }
    
}



