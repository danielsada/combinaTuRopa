//
//  ViewControllerSeleccionHM.swift
//  combinaTuRopa
//
//  Created by Familia on 20/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerSeleccionHM: UIViewController{
    //Boton Mujer
    @IBAction func botonMujer(_ sender: Any) {
    }
    
    //Boton Hombre
    @IBAction func botonHombre(_ sender: Any) {

    }

    @IBOutlet weak var btnMujer: UIButton!
    
    @IBOutlet weak var btnHombre: UIButton!
    
    //Animated Button
    func animatedButton(){
        btnHombre.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        btnMujer.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            self.btnHombre.transform = .identity
        }) { (finished) in
            self.animatedButton()
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
            self.btnMujer.transform = .identity
        }) { (finished) in
            self.animatedButton()
        }

        
        
    }
    
    
    //Only portrait
    
    override func viewDidLoad(){
        animatedButton()
        
    }
 

}
