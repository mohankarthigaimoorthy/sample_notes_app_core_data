//
//  ViewController.swift
//  appNotes
//
//  Created by Mohan K on 01/03/23.
//

import UIKit
import CoreData

struct NoteWrite {
    var title : String
    var body : String
    var creationDate: Date
    var dateString: String
    var id: Int
    var color: ColoursType
    var isEdited:Bool
    var isPinned: Bool
}

enum ColoursType : String {
    case red = "red"
    case tint = "tint"
    case darkGray = "darkGray"
    case cyan = "cyan"
    case gray = "gray"
    case black = "black"
    case blue = "blue"
    case magenta = "magenta"
    case green = "green"
    case white = "white"
    
    var backgroundColor : String {
        switch self {
        case .red :
            return "red"
        case .tint:
            return "tint"
        case .darkGray:
            return "daragray"
        case .cyan:
            return "cyan"
        case .gray:
            return "gray"
        case .black:
            return "black"
        case .blue:
            return "blue"
        case .green:
            return "green"
        case .magenta:
            return "maagenta"
        case .white:
            return "white"
        }
    }
    
    var fontColor : String {
        switch self {
        case .red :
            return "white"
        case .tint:
            return "black"
        case .darkGray:
            return  "black"
        case .cyan:
            return "white"
        case .gray:
            return  "black"
        case .black:
            return "white"
        case .blue:
            return "white"
        case .green:
            return  "black"
        case .magenta:
            return "white"
        case .white:
            return  "black"
        }
    }
    
}

class ViewController: UIViewController {
 
    @IBOutlet weak var temproary: UICollectionView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var color: UICollectionView!

//    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notes: [NoteWrite] = []
    var isGrid = false
    var id = [Int].self
    var pinnedNotes : [NoteWrite] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTable.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTabelViewCell")
        tableSetup ()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        let layout = ListGridCollectionViewLayout()
        temproary.collectionViewLayout = layout
        
        pinnedNotes = notes.sorted(by: {$0.isPinned && !$1.isPinned})
    }
    
   
    @IBAction func toggleView(_ sender: Any) {
        
        isGrid = !isGrid
        
        DispatchQueue.main.async {
            if self.isGrid == false {
                self.noteTable.isHidden = false
                self.temproary.isHidden = true
                self.noteTable.reloadData()
            } else {
                self.temproary.isHidden = false
                self.noteTable.isHidden = true
                self.temproary.reloadData()
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        noteTable.contentInset = .zero
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            noteTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height +  noteTable.rowHeight, right: 0)
        }
        
    }
    
    
    @IBAction func additional(_ sender: Any) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "not") as? NoteDetailViewController else { return }
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { [weak self] noteTitle, noted, selectedColor in
            guard let self = self else {return}
            self.navigationController?.popToRootViewController(animated: true)
            self.pinnedNotes.insert(NoteWrite(title: noteTitle, body: noted, creationDate: Date(), dateString: "", id: self.randomInt(min: 0, max: 20), color: selectedColor, isEdited: false, isPinned: false), at: 0)
            self.noteTable.isHidden = false
            self.noteTable.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableSetup () {
        noteTable.dataSource = self
        noteTable.delegate = self
        temproary.delegate = self
        temproary.dataSource = self
        
        DispatchQueue.main.async {
            self.noteTable.reloadData()
            self.temproary.reloadData()
        }
    }
    
    func randomInt(min: Int, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
   
    @IBAction func oPtional(_ sender: UIButton) {
        
    }
    
    
    @IBAction func palette(_ sender: UIButton) {
        if notes.firstIndex(where: {$0.id == 0}) != nil {
            self.view.backgroundColor = color.tintColor
            self.noteTable.reloadData()
        }
}
    
    @IBAction func functionals(_ sender: UIButton) {
        
        
    }
    
    
}
        
extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pinnedNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = noteTable.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
        let note = pinnedNotes[indexPath.row]
        cell.configure(with: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = pinnedNotes[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "edit") as? editedViewController else{return}
        vc.notes = note
        vc.title = "Edit"
        vc.Notetitle = note.title
        vc.noted = note.body
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self]  _, _, completionHandler in
            pinnedNotes.remove(at: indexPath.row)
            self.noteTable.reloadData()
         
            completionHandler(true)
            
        }
        deleteAction.backgroundColor = .systemCyan
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
    
        let note = pinnedNotes[indexPath.row]
        let title = note.isPinned ? "Unpin" : "Pin"
        let action = UIContextualAction(style: .normal, title: title) { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }
            var updatedNote = note
            updatedNote.isPinned.toggle()
            self.pinnedNotes[indexPath.row] = updatedNote
            self.pinnedNotes = self.pinnedNotes.sorted(by: {$0.isPinned && !$1.isPinned})
            self.noteTable.reloadData()
          
         }
        action.backgroundColor = note.isPinned ? .gray : .orange
        action.image = note.isPinned ? UIImage(systemName: "pin.fil") : UIImage(systemName: "pin")
        return UISwipeActionsConfiguration(actions: [action,deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
        return 150
    }
    
    
}

// MARK: - Dlegate Method EditViewController : -

extension ViewController: EditDelegate {
    func updates(_ notted: NoteWrite) {
        if let index = pinnedNotes.firstIndex(where: {$0.id == notted.id}) {
            pinnedNotes[index] = notted
            
        }
        DispatchQueue.main.async {
            self.noteTable.reloadData()
            self.temproary.reloadData()
        }
    }
}
        
        
// MARK: - Collection view delegates : -
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pinnedNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = temproary.dequeueReusableCell(withReuseIdentifier: "grided", for: indexPath) as! gridCollectionViewCell
        let note = pinnedNotes[indexPath.item]
        cell.configuration(with: note)
//        cell.backgroundColor = UIColor(named: notes[indexPath.item].color.rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let note = pinnedNotes[indexPath.item]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "edit") as? editedViewController else {return}
        vc.notes = note
        vc.title = "Edit"
        vc.Notetitle = note.title
        vc.noted = note.body
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2 - 10
        return CGSize(width: width, height: 150)
    }
}



// MARK: - commented codes : -

/*
 
 
     func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
         return .none
     }
 
     func setButtonColor (_ color: UIColor)
     {
         button.setTitleColor(color, for: UIControl.State())
     }
 
         temproary.register("gridCollectionViewCell", forCellWithReuseIdentifier: "grided")

 func colorView () {
         color.delegate = self
         color.dataSource = self
 
         DispatchQueue.main.async {
             self.color.reloadData()
         }
     }
 extension ViewController: UIColorPickerViewControllerDelegate {
     func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
         self.view.backgroundColor = viewController.selectedColor
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
             self.cancellable?.cancel()
             print(self.cancellable == nil)
         }
     }
 
     func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
         self.view.backgroundColor = viewController.selectedColor
         self.noteTable.backgroundColor = viewController.selectedColor
     }
 
 }
 
 extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return colours.count
     }
 
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = color.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! coloredCollectionViewCell
         cell.backgroundColor = colours[indexPath.row]
         return cell
 
     }
 
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: 50, height: 50)
     }
 }
 */
