//
//  ViewController.swift
//  LowCostPathMatrix
//
//  Created by harshal_s on 1/18/17.
//  Copyright © 2017 Harshal Pandhe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tvMatrix: UITextView!
    
    @IBOutlet weak var labelPathSucceeded: UILabel!
    
    @IBOutlet weak var labelPathCost: UILabel!
    
    @IBOutlet weak var tvLowCostPath: UITextView!
    
    @IBAction func submitAction(_ sender: Any) {
        
        self.tvMatrix.resignFirstResponder()
        
        let inputString = self.tvMatrix.text
        if let matrix = Matrix(input: inputString!) {
        
            let bestCost = matrix.findBestCost()
        
            self.labelPathCost.text = "\(bestCost.gridCostUptoMaximum)"
            
            if bestCost.traversedCompletePath {
                
                self.labelPathSucceeded.text = "Yes"
            }
            else {
                self.labelPathSucceeded.text = "No"
            }
            
            self.tvLowCostPath.text = String(describing: bestCost.costPathUptoMaximum)
        }
        else {
            
            let alert = UIAlertController(title: "Error", message: "Invalid Matrix", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tvMatrix.text = "5,4,1,2,8,6\n6,1,8,2,7,4\n5,9,3,9,1,5\n8,1,1,3,2,6\n3,7,2,1,2,3"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.isEqual(self.tvMatrix) {
            
            self.tvMatrix.text = ""
            
            return true
        }
        
        return false
    }

}

