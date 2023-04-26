//
//  NoteTableViewCell.swift
//  appNotes
//
//  Created by Mohan K on 01/03/23.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlLabel : UILabel!
    @IBOutlet weak  var dateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var pinButton: UIButton!
   
    var noteFilePath: String!
    var notes : NoteWrite?
    
    private func loadNotes() -> [NoteWrite] {
          return []
      }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
   
    func configure(with note: NoteWrite) {
        titlLabel.text = note.title
        bodyLabel.text = note.body
        if note.isEdited == true {
            dateLabel.text = formatDate(note.creationDate) + " (edited)"
        } else {
            dateLabel.text = formatDate(note.creationDate)
        }
        if note.isPinned == true {
            pinButton.alpha = 1
            pinButton.setImage(UIImage(systemName: "pin.fil"), for: .normal)
        } else {
            pinButton.alpha = 0
            pinButton.setImage(UIImage(systemName: "pin"), for: .normal)
        }
        
        titlLabel.textColor = UIColor(named: note.color.fontColor)
        dateLabel.textColor = UIColor(named: note.color.fontColor)
        bodyLabel.textColor =  UIColor(named: note.color.fontColor)
        
        contentView.backgroundColor = UIColor(named: note.color.backgroundColor)
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
    @IBAction func togglePin(_ sender: Any) {

    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}
