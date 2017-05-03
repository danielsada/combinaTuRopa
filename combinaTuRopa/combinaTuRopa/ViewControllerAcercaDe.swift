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
    @IBOutlet weak var jessicaLabel: UILabel!
    

    @IBAction func danielBtn(_ sender: Any) {
        danielLabel.text = "A01169735\n ISC\n A01169735@itesm.mx\n"
        danielLabel.backgroundColor = UIColor(white:1,alpha:0.25)
        
    }
   
    @IBAction func brandonBtn(_ sender: Any) {
        brandonLabel.text = "A01375640\n ISC\n A01375640@itesm.mx\n"
        brandonLabel.backgroundColor = UIColor(white:1,alpha:0.25)
    }
    
    @IBAction func marioBtn(_ sender: Any) {
        marioLabel.text = "A01374648\n ISC\nA01374648@itesm.mx\n"
        marioLabel.backgroundColor = UIColor(white:1,alpha:0.25)
    }
    
    @IBAction func btnAndres(_ sender: Any) {
        andresLabel.text = "A01169639\n ISC\n A01169639@itesm.mx\n"
        andresLabel.backgroundColor = UIColor(white:1,alpha:0.25)
    }
    @IBAction func btnJessica(_ sender: Any) {
        
    }
    @IBAction func btnJess(_ sender: Any) {
        jessicaLabel.text = "Modelo"
        jessicaLabel.backgroundColor = UIColor(white:1,alpha:0.25)
    }
}
