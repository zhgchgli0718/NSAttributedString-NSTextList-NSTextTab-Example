//
//  NSTextTabViewController.swift
//  NSAttributedStringListIndent
//
//  Created by http://zhgchg.li on 2024/5/31.
//

import UIKit

class NSTextTabViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let attributedStringFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let iterator = ListItemIterator(font: attributedStringFont)
        
        //
        let listItem = ListItem(type: .decimal, text: "", subItems: [
            ListItem(type: .circle, text: "List Level 1 - 1 StringStringStringStringStringStringStringStringStringStringStringString", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 2", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 3", subItems: [
                ListItem(type: .circle, text: "List Level 2 - 1", subItems: []),
                ListItem(type: .circle, text: "List Level 2 - 2 fafasffsafasfsafasas\tfasfasfasfasfasfasfasfsafsaf", subItems: [])
            ]),
            ListItem(type: .circle, text: "List Level 1 - 4", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 5", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 6", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 7", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 8", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 9", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 10", subItems: []),
            ListItem(type: .circle, text: "List Level 1 - 11", subItems: [])
        ])
        let listItemIndent = ListItemIterator.ListItemIndent(preIndent: 8, sufIndent: 8)
        textView.attributedText = iterator.start(item: listItem, type: .decimal, indent: listItemIndent)
    }
}

private extension UIFont {
    func widthOf(string: String) -> CGFloat {
        return (string as NSString).size(withAttributes: [.font: self]).width
    }
}

private struct ListItemIterator {
    let font: UIFont
    
    struct ListItemIndent {
        let preIndent: CGFloat
        let sufIndent: CGFloat
    }
    
    func start(item: ListItem, type: NSTextList.MarkerFormat, indent: ListItemIndent) -> NSAttributedString {
        let textList = NSTextList(markerFormat: type, startingItemNumber: 1)
        return item.subItems.enumerated().reduce(NSMutableAttributedString()) { partialResult, listItem in
            partialResult.append(self.iterator(parentTextList: textList, parentIndent: indent.preIndent, sufIndent: indent.sufIndent, item: listItem.element, itemNumber: listItem.offset + 1))
            return partialResult
        }
    }
    
    private func iterator(parentTextList: NSTextList, parentIndent: CGFloat, sufIndent: CGFloat, item: ListItem, itemNumber:Int) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        
        
        // e.g. 1.
        var itemSymbol = parentTextList.marker(forItemNumber: itemNumber)
        switch parentTextList.markerFormat {
        case .decimal, .uppercaseAlpha, .uppercaseLatin, .uppercaseRoman, .uppercaseHexadecimal, .lowercaseAlpha, .lowercaseLatin, .lowercaseRoman, .lowercaseHexadecimal:
            itemSymbol += "."
        default:
            break
        }
        
        // width of "1."
        let itemSymbolIndent: CGFloat = ceil(font.widthOf(string: itemSymbol))
        
        let tabStops: [NSTextTab] = [
            .init(textAlignment: .left, location: parentIndent),
            .init(textAlignment: .left, location: parentIndent + itemSymbolIndent + sufIndent)
        ]

        let thisIndent = parentIndent + itemSymbolIndent + sufIndent
        paragraphStyle.headIndent = thisIndent
        paragraphStyle.tabStops = tabStops
        paragraphStyle.defaultTabInterval = 28
        
        let thisTextList = NSTextList(markerFormat: item.type, startingItemNumber: 1)
        //
        return item.subItems.enumerated().reduce(NSMutableAttributedString(string: "\t\(itemSymbol)\t\(item.text)\n", attributes: [.paragraphStyle: paragraphStyle, .font: font])) { partialResult, listItem in
            partialResult.append(self.iterator(parentTextList: thisTextList, parentIndent: thisIndent, sufIndent: sufIndent, item: listItem.element, itemNumber: listItem.offset + 1))
            return partialResult
        }
    }
}

private struct ListItem {
    var type: NSTextList.MarkerFormat
    var text: String
    var subItems: [ListItem]
}
