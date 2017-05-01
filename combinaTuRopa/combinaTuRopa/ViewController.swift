//
//  ViewController.swift
//  combinaTuRopa
//
//  Created by Daniel Sada on 2/12/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 //Boton 
    
   /* @IBAction func bounce(_ sender: Any) {
        let button = sender as! UIButton
        let bounds = button.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 30, options: .curveEaseInOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width : bounds.size.width + 60, height: bounds.size.height)
        }) { (success:Bool) in
            if success == true {
                button.bounds = bounds
            }
        }
    }*/
    
    @IBOutlet weak var button: UIButton!
    
    func animatedButton(){
        button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.20, initialSpringVelocity: 4.0, options: .allowUserInteraction, animations: {
            self.button.transform = .identity
        }) { (finished) in
            self.animatedButton()
        }
        
        
    }
    
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animatedButton()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

