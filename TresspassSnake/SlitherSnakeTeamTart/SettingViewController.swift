//
//  SettingViewController.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/15.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit

struct MyVariables {
    static var color = UIColor(
        red: 0.5,
        green: 0.5,
        blue: 0.5,
        alpha: 1.0)
    static var red = CGFloat(0.5)
    static var green = CGFloat(0.5)
    static var blue = CGFloat(0.5)
    static var mode = 1
}

class SettingViewController: UIViewController {

    @IBOutlet weak var circle: UIImageView!
    
    @IBOutlet weak var square: UIImageView!
    
    @IBOutlet weak var snakecolor: UIImageView!
    
   
    
    @IBOutlet weak var mode1: UIButton!
    
    
    @IBOutlet weak var mode2: UIButton!
    var color: UIColor!
    
    @IBOutlet weak var redcolor: UISlider!
    @IBOutlet weak var bluecolor: UISlider!
    @IBOutlet weak var greencolor: UISlider!
    
    @IBOutlet weak var colorsetting: UISegmentedControl!
    
    @IBAction func redcolorchange(sender: AnyObject) {
        displayColors()
    }
    
 
    @IBAction func greencolorchange(sender: AnyObject) {
        displayColors()

    }
    
    @IBAction func bluecolorchange(sender: AnyObject) {
        displayColors()

    }
    
    @IBAction func choosemode1(sender: AnyObject) {
        
        circle.image = circle.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        circle.tintColor = UIColor(
            red: MyVariables.red,
            green: MyVariables.green,
            blue: MyVariables.blue,
            alpha: 1.0)
        
    }
    
    
    
    @IBAction func changemode2(sender: AnyObject) {
        MyVariables.mode = 2
        square.image = square.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        square.tintColor = UIColor(
            red: MyVariables.red,
            green: MyVariables.green,
            blue: MyVariables.blue,
            alpha: 1.0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SETTING view did load")
        print(MyVariables.red)
        print(MyVariables.green)
        print(MyVariables.blue)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    
    func displayColors() -> UIColor{
        MyVariables.red = CGFloat(redcolor.value)
        MyVariables.blue = CGFloat(bluecolor.value)
        MyVariables.green = CGFloat(greencolor.value)
        MyVariables.color = UIColor(
            red: MyVariables.red,
            green: MyVariables.green,
            blue: MyVariables.blue,
            alpha: 1.0)

        
        snakecolor.image = snakecolor.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        snakecolor.tintColor = UIColor(
            red: MyVariables.red,
            green: MyVariables.green,
            blue: MyVariables.blue,
            alpha: 1.0)
        
            return MyVariables.color
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("SettingprepareForSegue did load")
        if segue.identifier == "MySegueID" {
        let secondVC2 = segue.destinationViewController as! GameViewController
        secondVC2.SnakeColor = displayColors()
        print(displayColors())}
        }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
