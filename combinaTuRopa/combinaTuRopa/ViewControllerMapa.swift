//
//  ViewControllerMapa.swift
//  combinaTuRopa
//
//  Created by Mario Lagunes Nava on 22/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewControllerMapa: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate,URLSessionDownloadDelegate{
    var tienda = ""
    var dir = ""
    let arrTiendas = ["Suburbia", "Zara", "Liverpool", "C&A", "Palacio de Hierro", "Nike", "Adidas", "Privalia", "Flexi", "Pirma"]
    let gps = CLLocationManager()
    var posicion = CLLocation()
    let annotation = MKPointAnnotation()
    

    let arrDirecciones = ["Av El Rosario No.1025, Azcapotzalco, El Rosario, 02430 Ciudad de México, CDMX","Av. Ruiz cortunes No. 255, Col. las margaritas, 52977 Mexico, Méx.","Plaza Las Galerias Atizapan, Av Adolfo Ruiz Cortines 255, Margaritas, 52977 Cd López Mateos, Méx.","Forum Buenavista Centro Comercial, Eje 1 Nte. 259, Buenavista, 06350 Ciudad de México, CDMX","Plaza Satélite, Cto Centro Comercial 2251, Cd. Satélite, 53100 Naucalpan de Juárez, Méx.","Calz. Vallejo 1051A, Lindavista Vallejo III Secc, 07750 Ciudad de México, CDMX","Enrique Bricker Plaza Galerías Atizapan, Av. Adolfo Ruiz Cortines 255, Mexico Nuevo, 52977 Cd López Mateos, Méx.","Colonia San Miguel Chapultepec Delegación Miguel Hidalgo, México, D.F.","Parque Lindavista, Colector 13, 280, Gustavo A.Madero, Magdalena de las Salinas, 07760 Ciudad de México, CDMX","Carretera Lago De Guadalupe, Av Lago de Guadalupe s/n, San Pedro Barrientos, 54010 Tlalnepantla, Méx."]
    

    
    let direcciones: ViewControllerTiendas = ViewControllerTiendas()
    
    @IBOutlet weak var tiendaLabel: UILabel!
    @IBOutlet weak var imagenMapa: UIImageView!
    
    @IBOutlet weak var mapa: MKMapView!
    override func viewDidLoad() {
        
        /*****/
        annotation.title = "Hola"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 19.5812355,longitude: -99.2163089)
        /*****/
        super.viewDidLoad()
        configurarMapa()
        
        /***/
        mapa.addAnnotation(annotation)
        /**/
        
        descargarJsonTiendas()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTiendas.count
    }
    
    /*func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
     <#code#>
     }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = arrTiendas[indexPath.row]
        celda.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
        celda.detailTextLabel?.text = arrDirecciones[indexPath.row]
        return celda
    }
    
    
    private func configurarMapa(){
        mapa.delegate = self
        gps.delegate = self
        gps.desiredAccuracy = kCLLocationAccuracyBest
        gps.requestWhenInUseAuthorization()
        let centro = CLLocationCoordinate2DMake(posicion.coordinate.latitude, posicion.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegionMake(centro, span)
        mapa.region = region
    }
    
     func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let posicion = userLocation.location!
        mapa.setCenter(posicion.coordinate, animated: true)
    }
    
    /**/
   
    /**/
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status : \(status)")
        if status == .authorizedWhenInUse{
            //Hay permiso, iniciar actualizaciones
            gps.startUpdatingLocation()
        }
        else if status == .denied{
            gps.stopUpdatingLocation()
            print("Puedes habilitar el gps en ajustes")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.posicion = locations.last!
        //Tamaño inicial del mapa
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Error al descargar... \(error.debugDescription)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let avance = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        
    }
    
    func descargarJsonTiendas(){
        let dir = "https://combinaturopa.stamplayapp.com/api/cobject/v1/stores"
        if let url = URL(string: dir) {
            let config = URLSessionConfiguration.default
            let sesion = URLSession(configuration: config, delegate: self, delegateQueue: nil)
            let tareaTexto = sesion.downloadTask(with: url)
            tareaTexto.resume()
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let datos = try Data.init(contentsOf: location, options: .alwaysMapped)
            let respuesta = downloadTask.response as! HTTPURLResponse
            if (respuesta.statusCode == 200) {
                parsearJson(datos: datos)
            } else {
                print("Error en la descarga: \(respuesta.statusCode)") }
        } catch {
        } }

    
    func parsearJson(datos: Data){
        if let json=try? JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! [String:Any]{
            
            if json["data"] != nil{
                let items = json["data"] as! [[String:Any]]
                for data in items{
                    print(data)
                }
            }
            else{
                print("No se encontró ISBN")
            }
        }
        
    }

    
    
    /*
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
    }*/
    
    

}
