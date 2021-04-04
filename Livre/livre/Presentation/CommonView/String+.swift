//
//  String+.swift
//  BookStory
//
//  Created by 김혜빈 on 2021/01/21.
//

import UIKit

extension String {
    // MARK: Html 문법대로 라벨에 표시하는 메서드
    func htmlEscapedAttributedString(font: UIFont, colorHex: String, lineSpacing: CGFloat) -> NSAttributedString {
        let style = """
                    <style>
                    p.normal {
                      line-height: \(lineSpacing);
                      font-size: \(font.pointSize)px;
                      font-family: \(font.familyName);
                      color: \(colorHex);
                    }
                    </style>
        """
        let modified = String(format:"\(style)<p class=normal>%@</p>", self)
        do {
            guard let data = modified.data(using: .unicode) else {
                return NSAttributedString(string: self)
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attributed
        } catch {
            return NSAttributedString(string: self)
        }
    }
    
    func removeHtml() -> String {
        var text = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        if text.contains("&#x0D;") { text = text.replacingOccurrences(of: "&#x0D;", with: "\n", options: .regularExpression, range: nil) }
        if text.contains("&quot;") { text = text.replacingOccurrences(of: "&quot;", with: "\"", options: .regularExpression, range: nil) }
        if text.contains("&lt;") {
            text = text.replacingOccurrences(of: "&lt;", with: "<", options: .regularExpression, range: nil)
            text = text.replacingOccurrences(of: "&gt;", with: ">", options: .regularExpression, range: nil)
        }
        return text
    }
    
    func removeBracket() -> String {
        if !self.contains("(") { return self}
        let index = self.firstIndex(of: "(")!
        return String(self[self.startIndex..<index])
    }
}
