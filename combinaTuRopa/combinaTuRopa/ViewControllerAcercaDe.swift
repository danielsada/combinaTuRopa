//
//  ViewControllerAcercaDe.swift
//  combinaTuRopa
//
//  Created by Mario Lagunes Nava on 02/05/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit

class ViewcControllerAcercaDe: UIViewController {
    
    @IBOutlet weak var danielLabel: UILabel!
    @IBOutlet weak var brandonLabel: UILabel!
    @IBOutlet weak var marioLabel: UILabel!
    @IBOutlet weak var andresLabel: UILabel!
    
    @IBAction func danielBtn(_ sender: Any) {
        danielLabel.text = "A01169735\n ISC\n A01169735@itesm.mx\n"
    }
   
    @IBAction func brandonBtn(_ sender: Any) {
        brandonLabel.text = "A01375640\n ISC\n A01375640@itesm.mx\n"
    }
    
    @IBAction func marioBtn(_ sender: Any) {
        marioLabel.text = "A01374648\n ISC\n A01374648@itesm.mx\n"
    }
    
    @IBAction func andresBtn(_ sender: Any) {
        andresLabel.text = "A01169639\n ISC\n A01169639@itesm.mx\n"
    }
    
}
