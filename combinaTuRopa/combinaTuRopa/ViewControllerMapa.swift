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
    let maxRange = 10000.0;
    let reachability = Reachability()!
    var identifier = 0
    var tienda = ""
    var dir = ""
    var coordenadas = ""
    var nameBrands = [String]()
    var slogans = [String]()
    var arrAnnotation = [MKPointAnnotation]()
    let gps = CLLocationManager()
    var posicion = CLLocation()
    //let direcciones: ViewControllerTiendas = ViewControllerTiendas()
    
    @IBOutlet weak var tiendaLabel: UILabel!
    @IBOutlet weak var imagenMapa: UIImageView!
    
    @IBOutlet weak var mapa: MKMapView!
    
    @IBOutlet weak var tableTiendas: UITableView!
    
    
    override func viewDidLoad() {
        monitorearRed()
        nameBrands.append("Mostrar todas")
        slogans.append(" ")
        /*****/
        descargarJsonTiendas(dir:"https://combinaturopa.stamplayapp.com/api/cobject/v1/stores?per_page=250")
        /*****/
        
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func agregarAnnotation(tienda: String, dir: String, coor: [Double]){
        let annotation = MKPointAnnotation()
        annotation.title = tienda
        annotation.subtitle = dir
        annotation.coordinate = CLLocationCoordinate2D(latitude: coor[1],longitude: coor[0])
        arrAnnotation.append(annotation)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameBrands.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = nameBrands[indexPath.row]
        var i = 0
        if name.contains("Mostrar todas"){
            for ann in arrAnnotation{
                mapa.addAnnotation(ann)
            }
        }
        else{
            for _ in arrAnnotation{
                if (arrAnnotation[i].title?.contains(name))!{                    let d = measure(lat1: posicion.coordinate.latitude,lon1: posicion.coordinate.longitude,lat2: arrAnnotation[i].coordinate.latitude,lon2: arrAnnotation[i].coordinate.longitude)
                    if(d<maxRange){
                        mapa.addAnnotation(arrAnnotation[i])
                        //print(d)
                    }else{
                        mapa.removeAnnotation(arrAnnotation[i])
                    }
                }
                else{
                    mapa.removeAnnotation(arrAnnotation[i])
                    }
                i+=1
            }
            //print(mapa.annotations.count)
            if (mapa.annotations.count==1){
                mostrarAlerta(mensaje:"No hay tiendas cercanas \n Prueba otra marca")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = nameBrands[indexPath.row]
        celda.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
        celda.detailTextLabel?.text = slogans[indexPath.row]
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
        if arrAnnotation.count == 0{
            print("ERROR")
        }
        else{
            for notation in arrAnnotation{
                mapa.addAnnotation(notation)
            }
        }
    }
    
     func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.posicion = userLocation.location!
        mapa.setCenter(posicion.coordinate, animated: true)
    }
    
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
        //self.posicion = locations.last!
        //Tamaño inicial del mapa
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            print("Error al descargar... \(error.debugDescription)")
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //let avance = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        
    }
    
    func descargarJsonTiendas(dir: String){
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
                if identifier == 0{
                    identifier+=1
                    parsearJson(datos: datos)
                }
                else{
                    parsearOtroJson(datos:datos)
                }
            } else {
                print("Error en la descarga: \(respuesta.statusCode)")
            }
        } catch {
            
        }
    }

    
    func parsearJson(datos: Data){
        var i = 0
        if let json=try? JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! [String:Any]{
            if json["data"] != nil{
                let items = json["data"] as! [[String:Any]]
                for _ in items{
                    let item = items[i]
                    let geo = item["_geolocation"] as! [String:Any]
                    let coord = geo["coordinates"] as! [Double]
                    tienda = item["nombre"]! as! String
                    dir = item["direccion"]! as! String
                    agregarAnnotation(tienda: tienda, dir: dir, coor: coord)
                    i+=1
                }
            }
            else{
                mostrarAlerta(mensaje: "No se encontró la tienda")
            }
            DispatchQueue.main.async{
                self.configurarMapa()
            }
            descargarJsonTiendas(dir:"https://combinaturopa.stamplayapp.com/api/cobject/v1/brands?per_page=250")
        }
        
    }
    func parsearOtroJson(datos: Data){
           var i = 0
        if let json=try? JSONSerialization.jsonObject(with: datos, options: .mutableContainers) as! [String:Any]{
            if json["data"] != nil{
                let items = json["data"] as! [[String:Any]]
                for _ in items{
                    let item = items[i]
                    let name = item["name"] as! String
                    nameBrands.append(name)
                    if item["slogan"] != nil{
                        let slogan = item["slogan"] as! String
                        slogans.append(slogan)
                    }
                    else{
                        slogans.append(" ")
                    }
                    i+=1
                }
            }
        }
        DispatchQueue.main.async{
            self.tableTiendas.reloadData()
        }
    }
    
    func monitorearRed(){
        reachability.whenReachable={
            reachibility in
            DispatchQueue.main.async {
                if self.reachability.isReachableViaWiFi{
                    print("Conectado WIFI")
                }
                else{
                    print("Conectado 4G")
                }
            }
        }
        reachability.whenUnreachable = {
            reachability in
            DispatchQueue.main.async {
                print("Sin conexión")
            }
        }
        do{
            try reachability.startNotifier()
        }
        catch{
            print("error en el motiroreo de red")
        }
    }
    
    func measure(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double{  // generally used geo measurement function
        let R = 6378.137; // Radius of earth in KM
        let dLat = lat2 * Double.pi / 180 - lat1 * Double.pi / 180
        let dLon = lon2 * Double.pi / 180 - lon1 * Double.pi / 180
        let a = sin(dLat/2) * sin(dLat/2) +
            cos(lat1 * Double.pi / 180) * cos(lat2 * Double.pi / 180) *
            sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = R * c
        return d * 1000 // meters
    }
    
    func mostrarAlerta(mensaje: String){
        let alerta = UIAlertController(title: "Aviso", message: mensaje, preferredStyle: .alert)
        let btnAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alerta.addAction(btnAceptar)
        present(alerta, animated: true, completion: nil)
    }

    

}
