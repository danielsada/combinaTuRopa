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
    
    let segundoControlador: ViewcControllerTuOutfit = ViewcControllerTuOutfit()
    
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
        //prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
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
    var titles = [String]()
    var camisas = [String]()
    var pantalones = [String]()
    var zapatos = [String]()
    var pantalon = ""
    var camisa = ""
    var gorra = ""
    var zapato = ""
    let descTitles = ["Gorra estilo M color Rojo","Gorra estilo J color Gris","Gorra estilo E color Rosa","Gorra estilo B color Verde","Gorra estilo A color Azul","Gorra estilo D color Amarillo"]
    let descCamisas = ["Playera tipo Q sin acabado color azul","Playera tipo Q con acabado color azul","Playera tipo BY color cielo","Playera tipo BYA color aguamarina","Playera tipo CT color violeta","Playera tipo B color rosa","Playera tipo M color naranja","Playera X con acabado color verde","Playera Z con acabado color morado","Player sin cuello tipo JHK color oro"]
    let descPantalones = ["Jeans fit color azul","Pants con acabado color gris","Jeans X color aguamarina","Jeans E color café","Jeans I color morado","Jeans SS color verde","Jeans SASA color violeta"]
    
    @IBOutlet weak var pickerViewPiernas: AKPickerView!
    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var pickerViewCuerpo: AKPickerView!
   
    @IBOutlet weak var pickerViewPies: AKPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in 1...6{
            titles.append("gorra"+String(index))
        }
        for index in 1...10{
            camisas.append("playera"+String(index))
        }
        for index in 1...7{
            pantalones.append("pants"+String(index))
        }
        for index in 1...6{
            zapatos.append("zapatos"+String(index))
        }
        topPlayera.constant = CGFloat(adjustTop(size: UIScreen.main.bounds.size))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerViewCuerpo.delegate = self
        self.pickerViewCuerpo.dataSource = self
        self.pickerViewPiernas.delegate = self
        self.pickerViewPiernas.dataSource = self
        self.pickerViewPies.dataSource = self
        self.pickerViewPies.delegate = self

        
        
        self.pickerView.pickerViewStyle = .wheel
        self.pickerViewCuerpo.pickerViewStyle = .wheel
        self.pickerViewPiernas.pickerViewStyle = .wheel
        self.pickerViewPies.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
        self.pickerView.reloadData()
        self.pickerViewCuerpo.reloadData()
        self.pickerViewPiernas.reloadData()
        self.pickerViewPies.reloadData()
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
        else if pickerView.tag==4{
            return self.zapatos.count
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
        else if pickerView.tag==4{
            return UIImage(named: self.zapatos[item])!
        }
        return UIImage(named: "hombre")!
    }
    
    // MARK: - AKPickerViewDelegate
    
    /*func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showDetail"){
            let segundoControlador = segue.destination as! ViewcControllerTuOutfit
            
            segundoControlador.gorra = descTitles[pickerView.selectedItem]
            segundoControlador.camisa = descCamisas[pickerViewCuerpo.selectedItem]
            segundoControlador.pantalon = descPantalones[pickerViewPiernas.selectedItem]
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }
    
}
