//
//  ViewController.swift
//  Text Editor
//
//  Created by Иван Осипов on 18/8/22.
//

import UIKit

enum ValueNumberOfLines: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case zero = 0
}

class ViewController: UIViewController {
    
    let valueTextColor = [("white", UIColor.white),
                          ("blue", UIColor.blue),
                          ("green", UIColor.green)
    ]
    
    let valueFontName = ["Helvetica", "Zapfino"]
    
    
    
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Я - текст."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2
        slider.maximumValue = 60
        slider.value = 16
        slider.addTarget(self, action: #selector(sliderAction), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTextButton))
        
        view.addSubview(label)
        view.addSubview(slider)
        view.addSubview(pickerOfLines)
        view.addSubview(pickerOfTextColor)
        view.addSubview(pickerOfFontName)
        
        setupConstraints()
    }
    
    @objc func addTextButton() {
        alert(title: "Введите текст", message: nil)
    }
    
    @objc func sliderAction() {
        label.font = UIFont(name: "", size: CGFloat(slider.value))
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.heightAnchor.constraint(equalToConstant: 150),
            label.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slider.centerYAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            pickerOfLines.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            pickerOfLines.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerOfLines.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfLines.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            pickerOfTextColor.centerYAnchor.constraint(equalTo: pickerOfLines.centerYAnchor),
            pickerOfTextColor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pickerOfTextColor.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfTextColor.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            pickerOfFontName.topAnchor.constraint(equalTo: pickerOfLines.bottomAnchor, constant: 10),
            pickerOfFontName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerOfFontName.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45),
            pickerOfFontName.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}

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

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return ValueNumberOfLines.allCases.count
        case 1:
            return valueTextColor.count
        case 2:
            return valueFontName.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return "\(ValueNumberOfLines.allCases[row].rawValue)"
        case 1:
            return valueTextColor[row].0
        case 2:
            return valueFontName[row]
        default: return "1"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            label.numberOfLines = ValueNumberOfLines.allCases[row].rawValue
        case 1:
            label.textColor = valueTextColor[row].1
        case 2:
            label.font = UIFont(name: valueFontName[row], size: CGFloat(slider.value))
        default: break
        }
    }
    
    
}


