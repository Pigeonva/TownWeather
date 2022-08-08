//
//  ViewController.swift
//  TownWeather
//
//  Created by Артур Фомин on 08.08.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    let backgrounImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.image = UIImage(named: K.background)
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.tintColor = UIColor(named: K.modeColor)
        button.setImage(UIImage(named: K.locationButtonImage), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(locationPressed), for: .touchUpInside)
        
        return button
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.tintColor = UIColor(named: K.modeColor)
        button.setImage(UIImage(named: K.sarchButtonImage), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        
        return button
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter city name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: K.placeholderColor)])
        textField.font = UIFont(name: K.fontName, size: 20)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor(named: K.modeColor)
        textField.textColor = UIColor(named: K.tintColor)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    let firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        imageView.image = UIImage(systemName: "sun.min")
        imageView.tintColor = UIColor(named: K.modeColor)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        label.font = UIFont(name: K.fontName, size: 100)
        label.text = "30 C"
        
        return label
    }()
    
    let feelsTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        label.font = UIFont(name: K.fontName, size: 40)
        label.text = "35 C"
        
        return label
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.font = UIFont(name: K.fontName, size: 50)
        label.text = "Kazan"
        
        return label
    }()
    
    let secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .trailing
        stack.distribution = .fill
        
        return stack
    }()
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgrounImageView)
        
        firstStackView.addArrangedSubview(locationButton)
        firstStackView.addArrangedSubview(textField)
        firstStackView.addArrangedSubview(searchButton)
        
        secondStackView.addArrangedSubview(weatherImageView)
        secondStackView.addArrangedSubview(temperatureLabel)
        secondStackView.addArrangedSubview(feelsTemperatureLabel)
        secondStackView.addArrangedSubview(cityLabel)
        
        view.addSubview(firstStackView)
        view.addSubview(secondStackView)
        createConstraints()
        
        textField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
    }
    
    //MARK: - @objc methods
    
    @objc func locationPressed(sender: UIButton!) {
        
        print("location button tapped")
    }
    
    func createConstraints() {
        
        // imageView constraints
        
        NSLayoutConstraint(item: backgrounImageView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgrounImageView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgrounImageView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        NSLayoutConstraint(item: backgrounImageView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0).isActive = true
        
        // search and locatin buttons constraints
        
        NSLayoutConstraint(item: searchButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
        
        NSLayoutConstraint(item: locationButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 50).isActive = true
        
        // firstStackView constraints
        
        NSLayoutConstraint(item: firstStackView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1,
                           constant: 20).isActive = true
        
        NSLayoutConstraint(item: firstStackView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -20).isActive = true
        
        NSLayoutConstraint(item: firstStackView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1,
                           constant: 64).isActive = true
        
        // weatherImageView contraints
        
        NSLayoutConstraint(item: weatherImageView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 150).isActive = true
        
        NSLayoutConstraint(item: weatherImageView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1,
                           constant: 150).isActive = true
        
        // secondStackView constraints
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1,
                           constant: -20).isActive = true
        
        NSLayoutConstraint(item: secondStackView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: firstStackView,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 100).isActive = true
    }
    
    
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    @objc func searchPressed(sender: UIButton!) {
        
        textField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Enter city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let cityName = self.textField.text else {return}
            weatherManager.fetchWeather(cityName: cityName)
        
        self.textField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.tempString
            self.weatherImageView.image = UIImage(systemName: weather.weatherName)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        
        locationManager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        weatherManager.fetchWeather(lat: lat, lon: lon)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
    }
}
