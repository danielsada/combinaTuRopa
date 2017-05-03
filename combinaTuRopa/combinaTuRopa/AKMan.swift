//
//  AKMan.swift
//  combinaTuRopa
//
//  Created by Dancuso on 20/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//



import Foundation
import UIKit

class AKMan: UIViewController,AKPickerViewDataSource, AKPickerViewDelegate{
    
    //Bonton Carrito
    @IBAction func buttonShop(_ sender: Any) {
        let button = sender as! UIButton
        let bounds = button.bounds
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width : bounds.size.width + 50, height: bounds.size.height + 15)
        }) { (success:Bool) in
            if success == true {
                UIView.animate(withDuration: 0.3, animations: {
                    button.bounds = bounds
                })
            }
        }
    }
    //Bonton Camara
    @IBAction func buttonCamara(_ sender: Any) {
        let button = sender as! UIButton
        let bounds = button.bounds
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            button.bounds = CGRect(x: bounds.origin.x + 20, y: bounds.origin.y, width : bounds.size.width + 5, height: bounds.size.height + 5 )
        }) { (success:Bool) in
            if success == true {
                UIView.animate(withDuration: 0.3, animations: {
                    button.bounds = bounds
                })
            }
        }
 
    }
    func adjustTop(size: CGSize) -> Int {
        switch(size.width, size.height) {
        case (320, 480):                        // iPhone 4S in portrait
            return 20
        case (320, 568):                        // iPhone 5/5S in portrait
            return 24
        case (375, 667):                        // iPhone 6 in portrait
            return 50
        case (414, 736):                        // iPhone 6 Plus in portrait
            return 60
        default:
            print("W:\(size.width) H:\(size.height)")
            return 76
        }
        
    }
    
    @IBOutlet weak var topPlayera: NSLayoutConstraint!
    
    //Nuevo Commit
    var titles = ["gorra1","gorra2","gorra1"]
    var camisas = ["playera1","playera2","playera3"]
    var pantalones = ["pants1","pants2"]
    
    @IBOutlet weak var pickerViewPiernas: AKPickerView!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var pickerViewCuerpo: AKPickerView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        topPlayera.constant = CGFloat(adjustTop(size: UIScreen.main.bounds.size))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerViewCuerpo.delegate = self
        self.pickerViewCuerpo.dataSource = self
        self.pickerViewPiernas.delegate = self
        self.pickerViewPiernas.dataSource = self

        
        self.pickerView.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerView.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerView.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        if pickerView.tag == 1{
            return self.titles.count
        }
        else if pickerView.tag == 2{
            return self.camisas.count
        }
        else if pickerView.tag==3{
            return self.pantalones.count
        }
        return 0
    }
    

    /*
     func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
     if pickerView.tag == 1{
     return self.titles[item]
     }
     return ""
     
     }*/
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        if pickerView.tag == 1{
            return UIImage(named: self.titles[item])!
        }
        if pickerView.tag == 2{
            return UIImage(named: self.camisas[item])!
        }
        else if pickerView.tag==3{
            return UIImage(named: self.pantalones[item])!
        }

        return UIImage(named: "hombre")!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        if pickerView.tag == 1{
            print("Your favorite city is \(self.titles[item])")
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }
    
}
