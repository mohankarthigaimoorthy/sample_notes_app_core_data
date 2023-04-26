//
//  coloredCollectionViewCell.swift
//  appNotes
//
//  Created by Mohan K on 03/03/23.
//

import UIKit

class coloredCollectionViewCell: UICollectionViewCell {
    
    var notes: NoteWrite?
   
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
}
