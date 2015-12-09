//
//  ViewController.swift
//  tapper
//
//  Created by Simon Thomas on 09/12/2015.
//  Copyright © 2015 Simon Thomas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    // Variables
    var maxTaps: Int = 0
    var currentTaps: Int = 0
    var timer = NSTimer()
    var elapsedTime = 0
    var timerRunning = false
    
    // Outlets
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var howManyTapsTxt: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var quitBtn: UIButton!
    
    @IBOutlet weak var tapBtn: UIButton!
    @IBOutlet weak var tapsLbl: UILabel!
    
    // For dismissing keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onCoinTapped(sender: UIButton!) {
        currentTaps++       // Increment number of taps
        updateTapsLbl()
        
        // Start Timer
        if timerRunning == false {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
            timerRunning = true
        }

        
        
        if isGameOver() {
            // Stop timer
            timer.invalidate()
            
            // Show alert
            var endAlert = UIAlertController(title: "Game Over", message: "\(maxTaps) Presses Complete in \(elapsedTime) Seconds! Well done!", preferredStyle: UIAlertControllerStyle.Alert)
            
            endAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                self.timerRunning = false
                self.restartGame()
            }))
            
            presentViewController(endAlert, animated: true, completion: nil)
            
            // Restart Game
            //restartGame()
        }
        
    }
    
    @IBAction func onQuit(sender: UIButton!) {
        restartGame()
    }
    
    @IBAction func onPlayBtnPressed(sender: UIButton!) {
        
        if howManyTapsTxt.text != nil && howManyTapsTxt.text != "" {
            // Hide UI Elements
            logoImg.hidden = true
            playBtn.hidden = true
            howManyTapsTxt.hidden = true
            
            tapBtn.hidden = false
            tapsLbl.hidden = false
            quitBtn.hidden = false
            
            maxTaps = Int(howManyTapsTxt.text!)!
            currentTaps = 0
            
            
            updateTapsLbl()
        }
    }
    
    func isGameOver() -> Bool {
        if currentTaps >= maxTaps {
            return true
        } else {
            return false
        }
    }
    
    func restartGame() {
        maxTaps = 0
        elapsedTime = 0
        howManyTapsTxt.text = ""
        
        logoImg.hidden = false
        playBtn.hidden = false
        howManyTapsTxt.hidden = false
        
        tapBtn.hidden = true
        tapsLbl.hidden = true
        quitBtn.hidden = true
    }
    
    func updateTapsLbl() {
        tapsLbl.text = "\(currentTaps) Taps"
    }
    
    func updateCounter() {
        elapsedTime++
    }
}

