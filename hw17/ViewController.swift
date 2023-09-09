//
//  ViewController.swift
//  hw17
//
//  Created by Dastan on 09.09.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Password"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter Password..."
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Generate"
        button.configuration?.titleAlignment = .center
        button.addTarget(self, action: #selector(generatorButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicatorView.color = .black
        return activityIndicatorView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.backgroundColor = .yellow
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(generateButton)
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        
        passwordLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordLabel.snp.bottom).offset(-50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        generateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom).offset(-100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(passwordLabel.snp.top).offset(80)
        }
    }
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }

        var password: String = ""

        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
            DispatchQueue.main.async { [weak self] in
                self?.passwordLabel.text = password
            }
        }
        
        DispatchQueue.main.async {
            self.passwordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }

    @objc func generatorButtonPressed() {
        activityIndicator.startAnimating()
        guard let inputText = passwordTextField.text else { return }
        DispatchQueue.global().async { [weak self] in
            self?.bruteForce(passwordToUnlock: inputText)
        }
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

func indexOf(character: Character, _ array: [String]) -> Int {
    return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
    return index < array.count ? Character(array[index])
                               : Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
    var str: String = string

    if str.count <= 0 {
        str.append(characterAt(index: 0, array))
    }
    else {
        str.replace(at: str.count - 1,
                    with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))

        if indexOf(character: str.last!, array) == 0 {
            str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
        }
    }

    return str
}

