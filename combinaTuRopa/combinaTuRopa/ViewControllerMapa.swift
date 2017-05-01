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
    var coordenadas = ""
    var arrTiendas = [String]()
    var arrCoordenadas = [String]()
    var arrDirecciones = [String]()
    let gps = CLLocationManager()
    var posicion = CLLocation()
    let annotation = MKPointAnnotation()
    
    

    
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
        var i=0
        if let json=try? JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! [String:Any]{
            
            if json["data"] != nil{
                let items = json["data"] as! [[String:Any]]
                for _ in items{
                    let item = items[i]
                    let geo = item["_geolocation"] as! [String:Any]
                    let coord = geo["coordinates"]!
                    DispatchQueue.main.async{
                        self.tienda = item["nombre"]! as! String
                        self.dir = item["direccion"]! as! String
                    }
                    arrTiendas.append(tienda)
                    arrCoordenadas.append("\(coord)")
                    arrDirecciones.append(dir)
                    
                    i += 1
                }
            }
            else{
                let alerta = UIAlertController(title: "Aviso", message: "NO SE ENCONTRÓ LA TIENDA.", preferredStyle: .alert)
                let btnAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                alerta.addAction(btnAceptar)
                present(alerta, animated: true, completion: nil)
            }
            print("Soy nombre: \(arrTiendas)")
            print("Soy geo: \(arrCoordenadas)")
            print("Soy dir: \(arrDirecciones)")
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
