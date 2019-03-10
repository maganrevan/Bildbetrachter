//
//  ViewController.swift
//  Bildbetrachter
//
//  Created by Magnus Kruschwitz on 10.03.19.
//  Copyright © 2019 Magnus Kruschwitz. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var bildAnzeige: NSImageView!
    @IBOutlet weak var bildName: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func btnChooseClicked(_ sender: Any) {
        //den Dialog erzeugen
        let meinDialog: NSOpenPanel = NSOpenPanel()
        //die Standardtaste setzen
        meinDialog.prompt = "Öffnen"
        //es sollen nur Grafikdateien angezeigt werden
        meinDialog.allowedFileTypes = NSImage.imageTypes //wurde etwas ausgewählt?
        if meinDialog.runModal() == NSApplication.ModalResponse.OK {
            let meineDatei = meinDialog.url?.path
            bildName.stringValue = meineDatei!
            //das Bild über die eigene Methode laden
            btnOpenClicked(sender)
        }
    }
    
    @IBAction func btnOpenClicked(_ sender: Any) {
        if bildName.stringValue.isEmpty{
            stackModal(headline: "Leerer Inhalt",content: "Die Pfadangaben sind leer, bitte geben Sie eine Pfadangabe ein.")
            return
        }
        
        if let meinBild = NSImage(contentsOfFile: bildName.stringValue) {
             bildAnzeige.image = meinBild
        }
        else{
            stackModal(headline: "Fehler", content:"Die Grafik konnte nicht geladen werden. Bitte prüfen Sie Ihre Eingabe.")
        }
        
       
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    func stackModal(headline: String, content: String){
        let showModal : NSAlert = NSAlert()
        showModal.messageText = headline
        showModal.informativeText = content
        showModal.runModal()
    }
    
}

