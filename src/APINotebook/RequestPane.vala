

class RequestPane : Gtk.Box {
    Gtk.Entry entry;
    Gtk.Button send_button;
    public signal void response (string data, string url);
    public RequestPane() {
        entry =  new Gtk.Entry() { margin=12};
        send_button = new Gtk.Button.with_label("SEND") { margin = 12 };
        pack_start(entry, true, true);
        pack_end(send_button, false, false);
        entry.valign = Gtk.Align.START;
        send_button.valign = Gtk.Align.START;
        send_button.clicked.connect (sendRequest);
        entry.activate.connect(sendRequest);
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
}