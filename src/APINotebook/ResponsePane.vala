class ResponsePane : Gtk.Box {
    Gtk.SourceView text_view;
    Gtk.ScrolledWindow scroll;
    Gtk.Stack stack;
    Gtk.StackSwitcher stack_switcher;
    WebKit.WebView test_label;
    public ResponsePane() {
        orientation = Gtk.Orientation.VERTICAL;
        stack = new Gtk.Stack();
        stack_switcher = new Gtk.StackSwitcher() {
            margin = 12
        };

        stack_switcher.set_stack(stack);

        text_view = new Gtk.SourceView ();
        text_view.show_line_numbers = true;
        text_view.editable = false;
        text_view.cursor_visible = false;

        test_label = new WebKit.WebView ();
        scroll = new Gtk.ScrolledWindow (null, null);
        stack_switcher.valign = Gtk.Align.START;
        stack_switcher.halign = Gtk.Align.START;
        scroll.set_policy (Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC);
        scroll.add (text_view);
        stack.add_titled(scroll, "Source", "Source");
        stack.add_titled(test_label, "Preview", "Preview");
        pack_start(stack_switcher, false, false);
        pack_end(stack, true, true);
    }

    public void set_response(string response, string url) {
        text_view.buffer.text = response;
        test_label.load_html(response, url);
    }
}