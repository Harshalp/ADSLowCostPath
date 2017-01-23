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
    
    @IBOutlet weak var labelPathTraversed: UILabel!
    
    @IBOutlet weak var labelExample: UILabel!
    
    
    func resetView() {
     
        self.tvMatrix.resignFirstResponder()
        
        self.labelExample.text = " Expected Input:\n 5,4,1,2,8,6\n 6,1,8,2,7,4\n 5,9,3,9,1,5\n 8,1,1,3,2,6\n 3,7,2,1,2,3"
        
        self.tvMatrix.text = ""
        self.tvMatrix.alpha = 0.05
        
        self.labelPathSucceeded.text = "Traverse Completed"
        self.labelPathCost.text = "Cost"
        self.labelPathTraversed.text = "Path"
    }
    
    //MARK:- Button Actions
    @IBAction func clearAction(_ sender: UIButton) {
        
        resetView()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        
        self.tvMatrix.resignFirstResponder()
        
        let inputString = self.tvMatrix.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if let matrix = Matrix(input: inputString) {
        
            let bestCost = matrix.findBestCost()
        
            self.labelPathCost.text = "\(bestCost.gridCostUptoMaximum)"
            
            if bestCost.traversedCompletePath {
                
                self.labelPathSucceeded.text = "Yes"
            }
            else {
                self.labelPathSucceeded.text = "No"
            }
            
            var pathString = String(describing: bestCost.costPathUptoMaximum)
            pathString = pathString.replacingOccurrences(of: "[", with: "")
            pathString = pathString.replacingOccurrences(of: "]", with: "")
            
            self.labelPathTraversed.text = pathString
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
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.bringSubview(toFront: self.tvMatrix)
        resetView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        self.tvMatrix.alpha = 1.0
        
        return true
    }
}

