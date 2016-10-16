//
//  ViewController.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/11.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var textField: UITextField!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Single View did load")
        print(MyVariables.red)
        print(MyVariables.green)
        print(MyVariables.blue)

        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        let secondVC = segue.destination as! GameViewController
        secondVC.PlayerName = textField.text!
        print("Single prepareForSegue View did load")
        print(MyVariables.color)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
