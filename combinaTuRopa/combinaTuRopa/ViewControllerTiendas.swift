//
//  ViewControllerTiendas.swift
//  combinaTuRopa
//
//  Created by Mario Lagunes Nava on 22/03/17.
//  Copyright © 2017 EquipoRMRoman4. All rights reserved.
//

import UIKit

class ViewControllerTiendas: UITableViewController{
    var dir = ""
    let arrTiendas = ["Suburbia", "Zara", "Liverpool", "C&A", "Palacio de Hierro", "Nike", "Adidas", "Privalia", "Flexi", "Pirma"]
    
    let arrDirecciones = ["Av El Rosario No.1025, Azcapotzalco, El Rosario, 02430 Ciudad de México, CDMX","Av. Ruiz cortunes No. 255, Col. las margaritas, 52977 Mexico, Méx.","Plaza Las Galerias Atizapan, Av Adolfo Ruiz Cortines 255, Margaritas, 52977 Cd López Mateos, Méx.","Forum Buenavista Centro Comercial, Eje 1 Nte. 259, Buenavista, 06350 Ciudad de México, CDMX","Plaza Satélite, Cto Centro Comercial 2251, Cd. Satélite, 53100 Naucalpan de Juárez, Méx.","Calz. Vallejo 1051A, Lindavista Vallejo III Secc, 07750 Ciudad de México, CDMX","Enrique Bricker Plaza Galerías Atizapan, Av. Adolfo Ruiz Cortines 255, Mexico Nuevo, 52977 Cd López Mateos, Méx.","Colonia San Miguel Chapultepec Delegación Miguel Hidalgo, México, D.F.","Parque Lindavista, Colector 13, 280, Gustavo A.Madero, Magdalena de las Salinas, 07760 Ciudad de México, CDMX","Carretera Lago De Guadalupe, Av Lago de Guadalupe s/n, San Pedro Barrientos, 54010 Tlalnepantla, Méx."]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTiendas.count
    }
    
    /*func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        <#code#>
    }*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = arrTiendas[indexPath.row]
        celda.detailTextLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
        celda.detailTextLabel?.text = arrDirecciones[indexPath.row]
        return celda
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*let segundoControlador = segue.destination as! ViewControllerMapa
        dir = arrDirecciones[(table.indexPathForSelectedRow?.row)!]
        segundoControlador.dir = dir*/
        
        if segue.identifier == "mapa" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = arrDirecciones[indexPath.row]
                let controller = segue.destination as! ViewControllerMapa
                controller.dir = object
            }
        }
    }
}
