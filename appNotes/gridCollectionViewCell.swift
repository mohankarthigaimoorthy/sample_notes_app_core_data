//
//  gridCollectionViewCell.swift
//  appNotes
//
//  Created by Mohan K on 04/03/23.
//

import UIKit

class gridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textone: UILabel!
    @IBOutlet weak var texttwo: UILabel!
    @IBOutlet weak var textthree: UILabel!
    @IBOutlet weak var tappedPin: UIButton!
   
    var notes: NoteWrite?
    
    private func loadNotes() -> [NoteWrite] {
          return []
      }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configuration(with note: NoteWrite)
    {
        textone.text = note.title
        textthree.text = formatDate(note.creationDate)
        texttwo.text = note.body
        
        if note.isEdited == true {
            textthree.text = formatDate(note.creationDate) + "(edited)"
        }
        else {
            textthree.text = formatDate(note.creationDate)
        }
        if note.isPinned == true {
            tappedPin.alpha = 1
            tappedPin.setImage(UIImage(systemName: "pin.fil"), for: .normal)
        }
        else {
            tappedPin.alpha = 0
            tappedPin.setImage(  UIImage(systemName: "pin"), for: .normal)
          
        }
        
        textone.textColor = UIColor(named: note.color.fontColor)
        texttwo.textColor = UIColor(named: note.color.fontColor)
        textthree.textColor =  UIColor(named: note.color.fontColor)
        
        contentView.backgroundColor = UIColor(named: note.color.backgroundColor)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    @IBAction func btnPin(_ sender: Any) {

    }
    
}
