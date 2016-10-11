//
//  MultipleViewController.swift
//  SlitherSnakeTeamTart
//
//  Created by 赵泽宇 on 16/10/11.
//  Copyright © 2016年 Tart. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipleViewController: UIViewController, MCBrowserViewControllerDelegate,UITextFieldDelegate, UITableViewDelegate {
    
        
   
    @IBOutlet var fields: [TextField]!
   
    
    var currentPlayer:String!
    
    //var appDelegate:AppDelegate!
    var messagesArray: [Dictionary<String, String>] = []
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.mpcHandler.setupPeerWithDisplayName(UIDevice.currentDevice().name)
        appDelegate.mpcHandler.setupSession()
        appDelegate.mpcHandler.advertiseSelf(true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MultipleViewController.peerChangedStateWithNotification(_:)), name: "MPC_DidChangeStateNotification", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MultipleViewController.handleReceivedDataWithNotification(_:)), name: "MPC_DidReceiveDataNotification", object: nil)
        
        //setupField()
        //fields.delegate = self
        currentPlayer = "x"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func connectWithPlayer(sender: AnyObject) {
        if appDelegate.mpcHandler.session != nil{
            appDelegate.mpcHandler.setupBrowser()
            appDelegate.mpcHandler.browser.delegate = self
            
            self.presentViewController(appDelegate.mpcHandler.browser, animated: true, completion: nil)
            
        }

    }
    
    
    
    func peerChangedStateWithNotification(notification:NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo.objectForKey("state") as! Int
        
        if state != MCSessionState.Connecting.rawValue{
            self.navigationItem.title = "Connected"
        }
        
    }
    
    func handleReceivedDataWithNotification(notification:NSNotification){
        let userInfo = notification.userInfo! as Dictionary
        let receivedData:NSData = userInfo["data"] as! NSData
        
        //let message = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        
        let message = try! NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
        
        
        
        
        
        let senderPeerId:MCPeerID = userInfo["peerID"] as! MCPeerID
        let senderDisplayName = senderPeerId.displayName

            var field:Int? = message.objectForKey("field")?.integerValue
            var player:String? = message.objectForKey("player") as? String
            
            if field != nil && player != nil{
                fields[field!].player = player
                fields[field!].settPlayer(player!)
        }
        
        
    }
    
   func fieldTapped (recognizer:UITextField){
        let tappedField  = recognizer.textInputView as! TextField
        
        tappedField.settPlayer(currentPlayer)
        
        let messageDict = ["field":tappedField.tag, "player":currentPlayer]
        //skip the error here
        let messageData = try! NSJSONSerialization.dataWithJSONObject(messageDict, options: NSJSONWritingOptions.PrettyPrinted)
        
        //var error:NSError?
        
        do {
            try! appDelegate.mpcHandler.session.sendData(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable)
        } catch let error as NSError?{
            print("error: \(error!.localizedDescription)")
        }
        //try! appDelegate.mpcHandler.session.sendData(messageData, toPeers: appDelegate.mpcHandler.session.connectedPeers, withMode: MCSessionSendDataMode.Reliable) as! NSError
        
        
        
        //if error != nil{
        //    print("error: \(error?.localizedDescription)")
        //}
    
        
        
    }

    /**func setupField (){
        
            let gestureRecognizer = UITextField(target: self, action: #selector(MultipleViewController.fieldTapped(_:)))
        
        let gR = UITextField(MultipleViewController.fieldTapped(_:))
            fields
    }**/
    
    /**func resetField(){
        for index in 0 ... fields.count - 1{
            fields[index].image = nil
            fields[index].activated = false
            fields[index].player = ""
        }
        
        currentPlayer = "x"
    }**/

    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        appDelegate.mpcHandler.browser.dismissViewControllerAnimated(true, completion: nil)
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
