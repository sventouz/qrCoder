//
//  ViewController.swift
//  QRcoder
//
//  Created by higuchi の iMac on 2020/01/21.
//  Copyright © 2020 higuchi の iMac. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var inputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inputField.delegate = self
        
        inputField.placeholder = "Type something here."
        inputField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputField.resignFirstResponder()
        return true
    }
    
    @IBAction func generate(_ sender: Any) {
        
        let letter = inputField.text!
        
        guard let data = letter.data(using: .utf8) else {
            return
        }
        
        let qr = CIFilter(name: "CIQRCodeGenerator", parameters: ["inputMessage": data, "inputCorrectionLevel": "H"])!
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.transformed(by: sizeTransform)
        qrImageView.image = UIImage(ciImage: qrImage)
    }
}

extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}
