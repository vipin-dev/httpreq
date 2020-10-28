

class RequestPane : Gtk.Box {
    Gtk.Entry entry;
    Gtk.Button send_button;
    Gtk.Box param_container;
    public signal void response (string data, string url);
    public RequestPane() {
        orientation = Gtk.Orientation.VERTICAL;

        // add maintools
        var mainTools = new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        entry =  new Gtk.Entry() { margin=12};
        send_button = new Gtk.Button.with_label("SEND") { margin = 12 };
        mainTools.pack_start(entry, true, true);
        mainTools.pack_end(send_button, false, false);

        // main tool functionalities.
        entry.valign = Gtk.Align.START;
        send_button.valign = Gtk.Align.START;
        send_button.clicked.connect (sendRequest);
        entry.activate.connect(sendRequest);
        pack_start(mainTools, false, true);

        var subTools = new Gtk.Box( Gtk.Orientation.VERTICAL,0);
        subTools.valign = Gtk.Align.START;
        subTools.halign = Gtk.Align.FILL;
        var subToolSwitcher = new Gtk.StackSwitcher() {
            margin = 12
        };
        subToolSwitcher.valign = Gtk.Align.START;
        subToolSwitcher.halign = Gtk.Align.CENTER;
        var stack = new Gtk.Stack(){
            margin = 12
        };
        param_container = new Gtk.Box(Gtk.Orientation.VERTICAL,0);
        param_container.pack_start(generateParamRow());
        stack.add_titled(param_container, "Params", "Params");
        stack.add_titled(new Gtk.Label("hello2"), "Authorization", "Authorization");
        stack.add_titled(new Gtk.Label("hello"), "Headers", "Headers");
        stack.add_titled(new Gtk.Label("hello2"), "Body", "Body");
        subToolSwitcher.set_stack(stack);
        subTools.pack_start(subToolSwitcher);
        subTools.pack_end(stack);
        pack_start(subTools, true, true);
    }
    public void sendRequest() {
        print("Sending response..");
        try {
            // Create a session:
            Soup.Session session = new Soup.Session ();
    
            // Request a file:
            Soup.Request request = session.request (entry.text);
            InputStream stream = request.send ();
            // Print the content:
            DataInputStream data_stream = new DataInputStream (stream);
            string? line;
            string output = "";
            print("Receiving stream...");
            while ((line = data_stream.read_line ()) != null) {
                output = output + line + "\n";
            }
            response(output, entry.text);
        } catch (Error e) {
            stderr.printf ("Error: %s\n", e.message);
        }
    }

    public Gtk.Box generateParamRow () {
        var row = new Gtk.Box(Gtk.Orientation.HORIZONTAL,0);
        var check = new Gtk.CheckButton() { margin = 4};
        var key = new Gtk.Entry() { margin = 4};
        var value = new Gtk.Entry() { margin = 4};
        var edited = false;
        key.changed.connect(() => {
            print("changed..");
            if(!edited){
                param_container.add(generateParamRow());
                param_container.show_all();
                edited = true;
            }
          
        });
        row.pack_start(check);
        row.pack_start(key,true);
        row.pack_start(value, true);
        return row;
    }

}
