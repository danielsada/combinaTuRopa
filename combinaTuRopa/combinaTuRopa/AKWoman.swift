//
//  AKWoman.swift
//  combinaTuRopa
//
//  Created by Dancuso on 20/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import Foundation
import UIKit

class AKWoman: UIViewController,AKPickerViewDataSource, AKPickerViewDelegate{
    
    var camisa = ""
    var pantalon = ""
    var gorra = ""
    var zapatos = ""
    
    //Boton Carrito
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
    
    //Boton Camara
    @IBAction func bottonCamara(_ sender: Any) {
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
    
    @IBOutlet weak var pickerViewCuerpo: AKPickerView!
    
    @IBOutlet weak var pickerViewPiernas: AKPickerView!
    var titles = [""]
    var camisas = ["blusa1","blusa2", "blusa3"]
    var pants = ["pantsm1", "pantsm2", "pantsm3"]
    
    @IBOutlet weak var pickerView: AKPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
            return 0
        }
        if pickerView.tag == 2{
            return self.camisas.count
        }
        if pickerView.tag == 3{
            return self.pants.count
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
            return UIImage(named: "fondo")!
        }
        if pickerView.tag == 2{
            return UIImage(named: self.camisas[item])!
        }
        if pickerView.tag == 3{
            return UIImage(named: self.pants[item])!
        }
        return UIImage(named: "hombre")!
    }
    
    // MARK: - AKPickerViewDelegate
    
    /*func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        if pickerView.tag == 1{
            print("Your favorite city is \(self.titles[item])")
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDetailWoman"){
            let segundoControlador = segue.destination as! ViewControllerTuOutfitMujer
            gorra = titles[(pickerView.selectedItem)]
            camisa = camisas[(pickerViewCuerpo.selectedItem)]
            pantalon = pants[(pickerViewPiernas.selectedItem)]
            segundoControlador.gorra = gorra
            segundoControlador.camisa = camisa
            segundoControlador.pantalon = pantalon
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }

}
