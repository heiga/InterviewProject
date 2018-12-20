//
//  FirstViewController.swift
//  InterviewProject
//
//  Created by Phillip Hoang on 2018-11-27.
//  Copyright © 2018 IC Heart Technologies. All rights reserved.
//

import UIKit

class AlphaViewController: UIViewController {
    var resultLabel: UILabel?
    var inputTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.navigationItem.title = "First Tab"
        
        let bar = tabBarController?.navigationController
        bar?.navigationBar.prefersLargeTitles = true
        bar?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupView() {
        let label = UILabel()
        label.text = "Custom Input"
        label.textAlignment = .center
        label.font = label.font.withSize(32)
        
        inputTextField = UITextField()
        guard let inputTextField = inputTextField else {return}
        //inputTextField.text = "Put custom input here"
        inputTextField.placeholder = "Put custom input here"
        //nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        //nameTextField.layer.borderWidth = 1
        inputTextField.borderStyle = .line
        inputTextField.font = inputTextField.font?.withSize(24)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        inputTextField.leftView = paddingView
        inputTextField.leftViewMode = .always
        
        resultLabel = UILabel()
        guard let resultLabel = resultLabel else {return}
        resultLabel.text = "Result:"
        resultLabel.textAlignment = .center
        resultLabel.font = label.font.withSize(24)
        resultLabel.numberOfLines = 0
        
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        
        let buttonInsets = UIEdgeInsetsMake(16, 16, 16, 16)
        
        let testButton = UIButton()
        testButton.contentEdgeInsets = buttonInsets
        testButton.setTitle("Static Test", for: .normal)
        testButton.backgroundColor = UIColor.darkGray
        testButton.addTarget(self, action: #selector(staticTest(sender:)), for: .touchUpInside)
        
        let customInputButton = UIButton()
        customInputButton.contentEdgeInsets = buttonInsets
        customInputButton.setTitle("Custom Test", for: .normal)
        customInputButton.backgroundColor = UIColor.darkGray
        customInputButton.addTarget(self, action: #selector(customTest(sender:)), for: .touchUpInside)
        
        scrollView.addSubview(inputTextField)
        scrollView.addSubview(label)
        scrollView.addSubview(resultLabel)
        
        self.view.addSubview(scrollView)
        self.view.addSubview(testButton)
        self.view.addSubview(customInputButton)
        
        testButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        testButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 64)
        
        customInputButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        customInputButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 64)
        
        scrollView.autoPinEdge(toSuperviewEdge: .top)
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        scrollView.autoPinEdge(toSuperviewEdge: .right)
        scrollView.autoPinEdge(.bottom, to: .top, of: testButton, withOffset: -16)
        
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        label.autoPinEdge(toSuperviewEdge: .left)
        label.autoPinEdge(toSuperviewEdge: .right)
        label.autoAlignAxis(toSuperviewAxis: .vertical)
        
        inputTextField.autoPinEdge(.top, to: .bottom, of: label, withOffset: 16)
        inputTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        inputTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        inputTextField.autoAlignAxis(toSuperviewAxis: .vertical)
        inputTextField.sizeToFit()
        
        resultLabel.autoPinEdge(.top, to: .bottom, of: inputTextField, withOffset: 48)
        resultLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        resultLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        resultLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func staticTest(sender: UIButton!) {
        guard let resultLabel = resultLabel else {
            return
        }
        
        resultLabel.text = Calculator.runAddTests()
    }
    
    @objc func customTest(sender: UIButton!) {
        guard let customInput = inputTextField?.text else {
            return
        }
        guard let resultLabel = resultLabel else {
            return
        }
        
        let formattedString = customInput.replacingOccurrences(of: "\\n", with: "\n")
        
        var stringToPrint = ""
        stringToPrint = Calculator.addInputOutputToString(string: stringToPrint, input: formattedString)
        
        resultLabel.text = stringToPrint
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
