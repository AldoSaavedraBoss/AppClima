//
//  ViewController.swift
//  Clima
//
//  Created by marco rodriguez on 07/10/21.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{

    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var condicionImageIV: UIImageView!
    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    var latitud: CLLocationDegrees = 0
    var longitud: CLLocationDegrees = 0
    
    
    @IBAction func BotonGPS(_ sender: UIButton) {
        
        climaManager.buscarPorGPS(lat: latitud, lon: longitud)
        
    }
    @IBOutlet weak var fondoIV: UIImageView!
    //Crear el obj climaManager
    
    
    var climaManager = ClimaManager()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        buscarTextField.delegate = self
        climaManager.delegado = self
    }

    @IBAction func buscarAccionBtn(_ sender: UIButton) {
        print(buscarTextField.text)
        buscarTextField.text = ""
        ciudadLabel.text = buscarTextField.text
        
    }
    
    
}

extension ViewController: ClimaManagerDelegate{
    func actualizarClima(clima: ClimaModelo) {
        print("Temperatura: \(clima.temperaturaCelcius)")
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(clima.temperaturaCelcius)
            self.ciudadLabel.text = String(clima.nombreCiudad)
            self.condicionImageIV.image = UIImage(named: "\(clima.condicionClima[0])")
            self.fondoIV.image = UIImage(named: "\(clima.condicionClima[1])")
        }
    }
    
    func Error(error: Error) {
        
    }
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let ubicacion = locations.last{
            locationManager.stopUpdatingLocation()
            latitud = ubicacion.coordinate.latitude
            longitud = ubicacion.coordinate.longitude
            print("latitud: \(latitud)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error al obtener la ubicacion")
    }
}

extension ViewController: UITextFieldDelegate{
    // Activa el boton de buscar del teclado virtual
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
         //Ocultar el teclado virtual cuando el usuario presiona el boton
         buscarTextField.endEditing(true)
         
         print(buscarTextField.text)
         ciudadLabel.text = buscarTextField.text
         buscarTextField.text = ""
         return true
     }
     
     //Notifica al VC cuando el usuario dejo de editar
     func textFieldDidEndEditing(_ textField: UITextField) {
         //Realizar la busqueda en la API
         if let ciudad = buscarTextField.text {
             climaManager.buscarClima(nombreCiudad: ciudad)
         }
        
        /*func obtenerIcono(clima: ClimaModelo){
            let icono = clima.condicionClima
            climaManager.buscarIcono(icon: icono)
        }*/
        
        
     }
     
     
     
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         //Validar que el campo de texto no este vacio
         if buscarTextField.text != "" {
             return true
         } else {
             buscarTextField.placeholder = "Escribe algo"
             return false
         }
     }
    
}
