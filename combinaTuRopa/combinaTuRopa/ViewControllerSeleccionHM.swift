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
        let button = sender as! UIButton
        let bounds = button.bounds
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 30, options: .curveEaseInOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x - 10, y: bounds.origin.y, width : bounds.size.width + 60, height: bounds.size.height + 20)
        }) { (success:Bool) in
            if success == true {
                UIView.animate(withDuration: 0.5, animations: {
                    button.bounds = bounds
                })
                
            }
        }

    }
    
    //Boton Hombre
    @IBAction func botonHombre(_ sender: Any) {
        let button = sender as! UIButton
        let bounds = button.bounds
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 30, options: .curveEaseInOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width : bounds.size.width + 60, height: bounds.size.height + 20)
        }) { (success:Bool) in
            if success == true {
                UIView.animate(withDuration: 0.5, animations: { 
                    button.bounds = bounds
                })
                
            }
        }

    }
    
    
    
}
