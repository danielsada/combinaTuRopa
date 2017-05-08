//
//  ViewControllerTuOutfit.swift
//  combinaTuRopa
//
//  Created by Mario Lagunes on 07/05/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit

class ViewcControllerTuOutfit: UIViewController {
    
    var gorra = ""
    var camisa = ""
    var pantalon = ""
    var zapato = ""
    
    @IBOutlet weak var zapatosLbl: UILabel!
    
    @IBOutlet weak var cabezaLbl: UILabel!
    
    @IBOutlet weak var troncoSuperiorLbl: UILabel!
 
    @IBOutlet weak var piernas: UILabel!
    
    @IBOutlet weak var piernasLbl: UILabel!
 
    
    override func viewDidLoad() {
        print(gorra)
        print(pantalon)
        print(camisa)
        
        cabezaLbl.text = gorra
        troncoSuperiorLbl.text = camisa
        piernasLbl.text = pantalon
        zapatosLbl.text = zapato
    }
}
