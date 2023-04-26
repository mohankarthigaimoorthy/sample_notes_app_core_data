//
//  colorPickerViewController.swift
//  appNotes
//
//  Created by Mohan K on 03/03/23.
//
//
//import UIKit
//
//class colorPickerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    
//    var tag: Int = 0
//    var color: UIColor = UIColor.gray
//    var delegate: ViewController? = nil
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        // Do any additional setup after loading the view.
//    }
//    
//
//    func hexStringUIColor (_ hex:String) -> UIColor {
//        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//       
//        if (cString.hasPrefix("#")) {
//            cString.remove(at: cString.startIndex)
//        }
//        
//        if (cString.count != 6) {
//            return UIColor.gray
//        }
//        var rgbValue:UInt32 = 0
//        Scanner(string: cString).scanHexInt32(&rgbValue)
//        
//        return UIColor(
//            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
//            alpha: CGFloat(1.0)
//            )
//    }
//
//    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 16
//    }
//    
//    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = UIColor.clear
//        cell.tag = tag
//        tag = tag + 1
//        return cell
//    }
//    
//    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        var colorPaleette: Array<String>
//        
//        let path = Bundle.main.path(forResource: "colorPalette", ofType: "plist")
//        
//        let pListArray = NSArray(contentsOfFile: path!)
//        
//        if let colorPalettePlistFile = pListArray
//        {
//            colorPaleette = colorPalettePlistFile as! [String]
//            
//            let cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath)! as  UICollectionViewCell
//            let hexString = colorPaleette[cell.tag]
//            color = hexStringUIColor(hexString)
//            
////            self.tableView.identifier.backgroundColor = color
////            self.collectionView(UICollectionView, cellForItemAt: indexPath) = color
//            self.view.backgroundColor = color
//            cell.selectedBackgroundView!.backgroundColor = color
//            delegate?.setButtonColor(color)
//        }
//    }
//}
