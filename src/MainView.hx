package ;

import haxe.ui.containers.VBox;
import haxe.ui.events.MouseEvent;
import haxe.ui.containers.dialogs.OpenFileDialog;

@:build(haxe.ui.ComponentBuilder.build("assets/main-view.xml"))
class MainView extends VBox {
    var dlg = new OpenFileDialog({
      readContents: true,
      multiple: false,
      extensions: [{label: "Necrovale Save", extension: "sav"}]
    }); 

    public function new() {
        super();
        dlg.onDialogClosed = function(e) {

          trace(e.data);
        }
        button1.onClick = function(e) {
            dlg.show();
        }
    }
}
