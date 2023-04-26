//
//  NoteDetailViewController.swift
//  appNotes
//
//  Created by Mohan K on 01/03/23.
//

import UIKit

class NoteDetailViewController: UIViewController,  UITextFieldDelegate {
    
    @IBOutlet weak var select: UICollectionView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clrBtn: UIButton!
   
    var placeholderLabel: UILabel!
    var colours = [String]()
    var notes: NoteWrite?
    var id = [Int].self
    var selectedColor : String?
    
    public var completion: ((_ titleText:String, _ bodyText:String, _ color:ColoursType) ->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colours = ["red",
                   "tint",
                   "darkGray",
                   "cyan",
                   "gray",
                   "black",
                   "blue",
                   "magenta",
                   "green",
                   "white"]
        titleTextField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(didupdate))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "pin", style: .done, target: self, action: #selector(didupdate))
        self.titleTextField.delegate = self
        self.bodyTextView.delegate = self
                self.bodyTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender: )))

        setupView()
        select.isHidden = true
        placeholderLabel = UILabel()
        placeholderLabel.text = "Note"
        placeholderLabel.font = .italicSystemFont(ofSize: (bodyTextView.font?.pointSize)!)
               placeholderLabel.sizeToFit()
        bodyTextView.addSubview(placeholderLabel)
               placeholderLabel.frame.origin = CGPoint(x: 5, y: (bodyTextView.font?.pointSize)! / 2)
               placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !bodyTextView.text.isEmpty

    }
    
    func setupView() {
        select.delegate = self
        select.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.select.reloadData()

        }
    }
   
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func didupdate() {
        if let text = titleTextField.text , !text.isEmpty, !bodyTextView.text!.isEmpty {
            completion?(text, bodyTextView.text!, ColoursType(rawValue: selectedColor ?? "white")!)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        bodyTextView.resignFirstResponder()
        return true
    }
    
    @IBAction func somefunc(_ sender: UIButton) {
        
    }
    
    @IBAction func colourspick(_ sender: UIButton) {
        
        UIView.transition(with: select, duration: 0.5, options: .curveEaseIn) {
            self.select.isHidden = !self.select.isHidden
            self.select.layoutIfNeeded()
        }
    
    }
    
    @IBAction func someOption(_ sender: Any) {
   
    }
    
}

extension NoteDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colours.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! cellCollectionViewCell
        cell.contentView.backgroundColor = UIColor(named: colours[indexPath.row])
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let color = colours[indexPath.row]
        selectedColor = color
            self.view.backgroundColor = UIColor(named: color)
            bodyTextView.textColor = UIColor(named: color)
            titleTextField.textColor = UIColor(named: color)
            if color == "red" {
                bodyTextView.textColor = .white
                titleTextField.textColor = .white
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "tint" {
                titleTextField.textColor = .black
                bodyTextView.textColor = .black
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "darkGray" {
                titleTextField.textColor = .black
                bodyTextView.textColor = .black
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "cyan" {
                bodyTextView.textColor = .white
                titleTextField.textColor = .white
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "gray" {
                titleTextField.textColor = .black
                bodyTextView.textColor = .black
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "black" {
                bodyTextView.textColor = .white
                titleTextField.textColor = .white
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "blue" {
                bodyTextView.textColor = .white
                titleTextField.textColor = .white
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "magenta" {
                titleTextField.textColor = .black
                bodyTextView.textColor = .black
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "green" {
                bodyTextView.textColor = .white
                titleTextField.textColor = .white
                self.view.backgroundColor = UIColor(named: color)

            }
            else if color == "white" {
                titleTextField.textColor = .black
                bodyTextView.textColor = .black
                self.view.backgroundColor = UIColor(named: color)

            }
            else {
                self.view.backgroundColor = UIColor(named: color)
            }
        
       
    }
    
}

extension NoteDetailViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = !bodyTextView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = !bodyTextView.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = true
    }
}

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}
