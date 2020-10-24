/*
* Copyright (c) 2011-2018 Your Organization (https://yourwebsite.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Author <info@vipindev.com>
*/


public class HTTPReq : Gtk.Application {
    public HTTPReq () {
        Object (
            application_id: "com.github.vipin-dev.httpreq",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "HTTPReq"
        };
        var notebook = new APINotebook();
        main_window.add(notebook);
        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new HTTPReq().run (args);
    }
}