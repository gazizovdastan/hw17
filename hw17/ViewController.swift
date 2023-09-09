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
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 30
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.borderStyle = .line
        return textField
    }()
    
    private lazy var generateButton: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        button.configuration?.title = "Generate"
        button.backgroundColor = .gray
        button.configuration?.titleAlignment = .center
        button.addTarget(self, action: #selector(generatorButtonPressed), for: touchUpInside)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicatorView.color = .red
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
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        generateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom).offset(-100)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.top).offset(10)
            make.leading.equalTo(passwordTextField.snp.trailing).offset(10)
        }
        
    }


}

