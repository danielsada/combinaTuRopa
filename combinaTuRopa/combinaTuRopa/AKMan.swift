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
    
    
    //Nuevo Commit
    var titles = ["Swimming","prueba"]
    
    @IBOutlet weak var pickerView: AKPickerView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        
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
        return 0
    }
    
    /*
     
     Image Support
     -------------
     Please comment '-pickerView:titleForItem:' entirely and
     uncomment '-pickerView:imageForItem:' to see how it works.
     
     */
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
        return UIImage(named: "hombre")!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        if pickerView.tag == 1{
            print("Your favorite city is \(self.titles[item])")
        }
    }
    
    /*
     
     Label Customization
     -------------------
     You can customize labels by their any properties (except for fonts,)
     and margin around text.
     These methods are optional, and ignored when using images.
     
     */
    
    /*
     func pickerView(pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
     label.textColor = UIColor.lightGrayColor()
     label.highlightedTextColor = UIColor.whiteColor()
     label.backgroundColor = UIColor(
     hue: CGFloat(item) / CGFloat(self.titles.count),
     saturation: 1.0,
     brightness: 0.5,
     alpha: 1.0)
     }
     
     func pickerView(pickerView: AKPickerView, marginForItem item: Int) -> CGSize {
     return CGSizeMake(40, 20)
     }
     */
    
    /*
     
     UIScrollViewDelegate Support
     ----------------------------
     AKPickerViewDelegate inherits UIScrollViewDelegate.
     You can use UIScrollViewDelegate methods
     by simply setting pickerView's delegate.
     
     */
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }
    
}
