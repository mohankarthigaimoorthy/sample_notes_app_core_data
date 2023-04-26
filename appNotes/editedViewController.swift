//
//  editedViewController.swift
//  appNotes
//
//  Created by Mohan K on 02/03/23.
//

import UIKit

protocol EditDelegate{
    func updates(_ notted : NoteWrite)
}

class editedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textTit: UITextField!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var collection: UICollectionView!
  
    public var Notetitle: String = ""
    public var noted : String = ""
    
    var placeholderLabel: UILabel!
    var notes : NoteWrite?
    var delegate : EditDelegate?
    var id = [Int].self
    var paint = [String]()
    var ColorSelecr : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paint = ["red",
                 "tint",
                 "darkGray",
                 "cyan",
                 "gray",
                 "black",
                 "blue",
                 "magenta",
                 "green",
                 "white"]
        textTit.text = Notetitle
        details.text = noted
        self.textTit.delegate = self
        self.details.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(NoteEdit))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "pin", style: .done, target: self, action: #selector(NoteEdit))
        tapped()
        placeholderLabel = UILabel()
        placeholderLabel.text = "Note"
        placeholderLabel.font = .italicSystemFont(ofSize: (details.font?.pointSize)!)
               placeholderLabel.sizeToFit()
        details.addSubview(placeholderLabel)
               placeholderLabel.frame.origin = CGPoint(x: 5, y: (details.font?.pointSize)! / 2)
               placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !details.text.isEmpty

    }

    func tapped() {
        collection.delegate = self
        collection.dataSource = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.collection.reloadData()
        }
    }
 
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textTit.resignFirstResponder()
        details.resignFirstResponder()
        return true
    }
    
    @objc private func NoteEdit() {
        delegate?.updates(NoteWrite(title: textTit.text ?? "", body: details.text ?? "", creationDate: Date(), dateString: "", id: notes?.id ?? 0, color: .gray, isEdited: true, isPinned: false))
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Option(_ sender: UIButton) {
        
    }
    
    @IBAction func coloured(_ sender: UIButton) {
        UIView.transition(with: collection, duration: 0.5, options: .curveEaseIn) {
            self.collection.isHidden = !self.collection.isHidden
            self.collection.layoutIfNeeded()
        }
    }
    
    @IBAction func addFunc(_ sender: UIButton) {
   
    }
    
}

extension UITextView {
    func addButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)
        toolBar.setItems([flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
}

extension editedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paint.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! paintCollectionViewCell
        cell.backgroundColor = UIColor(named: paint[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let painted = paint[indexPath.row]
        
      
            self.view.backgroundColor = UIColor(named: painted)
        textTit.textColor = UIColor(named: painted)
        details.textColor = UIColor(named: painted)
        
        if painted == "red" {
            textTit.textColor = .white
            details.textColor = .white
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "tint" {
            textTit.textColor = .black
            details.textColor = .black
            self.view.backgroundColor = UIColor(named: painted)
            
        }
        else if painted == "darkGray" {
            textTit.textColor = .black
            details.textColor = .black
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "cyan" {
            textTit.textColor = .white
            details.textColor = .white
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "gray" {
            textTit.textColor = .black
            details.textColor = .black
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "black" {
            textTit.textColor = .white
            details.textColor = .white
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "blue" {
            textTit.textColor = .white
            details.textColor = .white
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "magenta" {
            textTit.textColor = .black
            details.textColor = .black
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "green" {
            textTit.textColor = .white
            details.textColor = .white
            self.view.backgroundColor = UIColor(named: painted)
        }
        else if painted == "white" {
            textTit.textColor = .black
            details.textColor = .black
            self.view.backgroundColor = UIColor(named: painted)
        }
        else {
            self.view.backgroundColor = UIColor(named: painted)

        }
    }
}

extension editedViewController : UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel?.isHidden = !details.text.isEmpty
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel?.isHidden = !details.text.isEmpty
    }
}
