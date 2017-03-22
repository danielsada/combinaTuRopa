//
//  ViewControllerMapa.swift
//  combinaTuRopa
//
//  Created by Mario Lagunes Nava on 22/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerMapa: UIViewController, CLLocationManagerDelegate{
    var tienda = ""
    
    var dir = ""
    
    let direcciones: ViewControllerTiendas = ViewControllerTiendas()
    
    @IBOutlet weak var tiendaLabel: UILabel!
    @IBOutlet weak var imagenMapa: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGPS()
        cargarImagen()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // *** Configurar GPS *** \\
        private let admGps = CLLocationManager() //ADMINISTRADOR DE LOCALIZACIÓN\\
        var posicion = CLLocation()  //Mandamos construir la posicion
    
        private func configurarGPS() {
            admGps.delegate = self // El delegado es este controlador
            admGps.desiredAccuracy = kCLLocationAccuracyBest // La mayor precisión
            admGps.requestWhenInUseAuthorization() // Pide permiso al usuario
        }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            admGps.startUpdatingLocation()
        }
        else{
            admGps.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR")
    }
    
    private func cargarImagen() {
        let direccion = "https://maps.googleapis.com/maps/api/staticmap?markers=\(dir)&zoom=14&size=400x400&sensor=true"
        print(direccion)
        DispatchQueue.global().async {
            let url = URL(string: direccion.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            let datosImg = try? Data(contentsOf: url!)
            // Actualizar la GUI, debe hacerlo en el thread principal
            DispatchQueue.main.async {
                if datosImg != nil {
                    self.imagenMapa.image = UIImage(data: datosImg!)
                }
            }
        }
    }
    
    

}
