//
//  ViewController.swift
//  Text Editor
//
//  Created by Иван Осипов on 18/8/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    
    // Label outlets
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Я - текст по умолчанию."
        label.shadowColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelOfShadow: UILabel = {
        let label = UILabel()
        label.text = "Shadow"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelOfWorldWrap: UILabel = {
        let label = UILabel()
        label.text = "World wrap"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Slider outlet
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2
        slider.maximumValue = 60
        slider.value = 16
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    //Picker outlets
    
    private lazy var pickerOfLines: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 0
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var pickerOfTextColor: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var pickerOfFontName: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 2
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var pickerColorOfShadow: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 3
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var switchOfShadow: UISwitch = {
        let switchElem = UISwitch()
        switchElem.isOn = false
        switchElem.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
        switchElem.translatesAutoresizingMaskIntoConstraints = false
        switchElem.tag = 0
        return switchElem
    }()
    
    private lazy var switchOfWrap: UISwitch = {
        let switchElem = UISwitch()
        switchElem.isOn = false
        switchElem.addTarget(self, action: #selector(switchAction(sender:)), for: .valueChanged)
        switchElem.translatesAutoresizingMaskIntoConstraints = false
        switchElem.tag = 1
        return switchElem
    }()
    
    // MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTextButton)
        )
        
        tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: Methods
    
    @objc func addTextButton() {
        alert(title: "Введите текст", message: nil)
    }
    
    @objc func sliderAction() {
        label.font = label.font.withSize(CGFloat(slider.value))
    }
    
    @objc func switchAction(sender: UISwitch) {
        
        switch sender.tag {
        case 0:
            if sender.isOn {
                label.shadowOffset = CGSize(width: 2, height: 2)
            } else {
                label.shadowOffset = CGSize(width: 0, height: 0)
            }
        case 1:
            if sender.isOn {
                label.lineBreakMode = .byWordWrapping
            } else {
                label.lineBreakMode = .byTruncatingTail
            }
        default: break
        }
    }
    
}

// MARK: Extensions

extension ViewController {
    private func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.label.text = alert.textFields?.first?.text
        }
        alert.addTextField(configurationHandler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ViewController {
    
    private func setupSubviews() {
        view.addSubview(label)
        view.addSubview(labelOfShadow)
        view.addSubview(labelOfWorldWrap)
        
        view.addSubview(slider)
        
        view.addSubview(pickerOfLines)
        view.addSubview(pickerOfTextColor)
        view.addSubview(pickerOfFontName)
        view.addSubview(pickerColorOfShadow)
        
        view.addSubview(switchOfShadow)
        view.addSubview(switchOfWrap)
    }
                            
    private func setupConstraints() {
        
        // Label constraints
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.heightAnchor.constraint(equalToConstant: 120),
            label.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            labelOfShadow.widthAnchor.constraint(equalToConstant: 100),
            labelOfShadow.topAnchor.constraint(equalTo: pickerOfFontName.bottomAnchor, constant: 20),
            labelOfShadow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelOfWorldWrap.widthAnchor.constraint(equalToConstant: 100),
            labelOfWorldWrap.topAnchor.constraint(equalTo: labelOfShadow.bottomAnchor, constant: 20),
            labelOfWorldWrap.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
        //Slider constraints
        
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
        //Picker constraints
        
        NSLayoutConstraint.activate([
            pickerOfLines.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            pickerOfLines.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerOfLines.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfLines.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            pickerOfTextColor.centerYAnchor.constraint(equalTo: pickerOfLines.centerYAnchor),
            pickerOfTextColor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pickerOfTextColor.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfTextColor.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            pickerOfFontName.topAnchor.constraint(equalTo: pickerOfLines.bottomAnchor, constant: 10),
            pickerOfFontName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerOfFontName.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfFontName.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            pickerColorOfShadow.topAnchor.constraint(equalTo: pickerOfTextColor.bottomAnchor, constant: 10),
            pickerColorOfShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pickerColorOfShadow.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerColorOfShadow.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            switchOfShadow.centerYAnchor.constraint(equalTo: labelOfShadow.centerYAnchor),
            switchOfShadow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            switchOfWrap.centerYAnchor.constraint(equalTo: labelOfWorldWrap.centerYAnchor),
            switchOfWrap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return numberOfLineArray.count
        case 1:
            return textColorArray.count
        case 2:
            return fontNameArray.count
        case 3:
            return shadowColorArray.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(numberOfLineArray[row])"
        case 1:
            return textColorArray[row].0
        case 2:
            return fontNameArray[row]
        case 3:
            return shadowColorArray[row].0
        default: return "1"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            label.numberOfLines = numberOfLineArray[row]
        case 1:
            label.textColor = textColorArray[row].1
        case 2:
            label.font = UIFont(name: fontNameArray[row], size: self.label.font.pointSize)
        case 3:
            label.shadowColor = shadowColorArray[row].1
        default: break
        }
    }
    
    
}


