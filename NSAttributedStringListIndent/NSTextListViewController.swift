//
//  ViewController.swift
//  NSAttributedStringListIndent
//
//  Created by http://zhgchg.li on 2024/5/29.
//

import UIKit

class NSTextListViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let textListLevel1 = NSTextList(markerFormat: .decimal, startingItemNumber: 1)
        let textListLevel2 = NSTextList(markerFormat: .circle, startingItemNumber: 1)
        
        let listLevel1ParagraphStyle = NSMutableParagraphStyle()
        listLevel1ParagraphStyle.textLists = [textListLevel1]
        
        let listLevel2ParagraphStyle = NSMutableParagraphStyle()
        listLevel2ParagraphStyle.textLists = [textListLevel1, textListLevel2]
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "\t\(textListLevel1.marker(forItemNumber: 1)).\tList Level 1 - 1 StringStringStringStringStringStringStringStringStringStringStringString\n", attributes: [.paragraphStyle: listLevel1ParagraphStyle]))
        attributedString.append(NSAttributedString(string: "\t\(textListLevel1.marker(forItemNumber: 2))\tList Level 1 - 2\n", attributes: [.paragraphStyle: listLevel1ParagraphStyle]))
        attributedString.append(NSAttributedString(string: "\t\(textListLevel1.marker(forItemNumber: 3))\tList Level 1 - 3\n", attributes: [.paragraphStyle: listLevel1ParagraphStyle]))
        attributedString.append(NSAttributedString(string: "\t\(textListLevel2.marker(forItemNumber: 1))\tList Level 2 - 1\n", attributes: [.paragraphStyle: listLevel2ParagraphStyle]))
        attributedString.append(NSAttributedString(string: "\t\(textListLevel2.marker(forItemNumber: 2))\tList Level 2 - 2 StringStringStringStringStringStringStringStringStringStringStringString\n", attributes: [.paragraphStyle: listLevel2ParagraphStyle]))
        attributedString.append(NSAttributedString(string: "\t\(textListLevel1.marker(forItemNumber: 4))\tList Level 1 - 4\n", attributes: [.paragraphStyle: listLevel1ParagraphStyle]))
        
        textView.attributedText = attributedString
    }
}
