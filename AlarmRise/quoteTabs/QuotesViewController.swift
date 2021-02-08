//
//  FirstViewController.swift
//  RiseAlarm
//
//  Created by Tiffany Cai on 5/16/20.
//  Copyright © 2020 Tiffany Cai. All rights reserved.
//

import AVFoundation
import UIKit
import CoreData

class QuotesViewController: UIViewController {

    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var buttonNewQuote: UIButton!
    @IBOutlet weak var buttonSaveQuote: UIButton!
    
    
    var audioPlayer: AVAudioPlayer?
    
    let quoteRequest = QuoteRequest()
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getQuote()
        
    }
    
    func getQuote() {
        
        quoteRequest.getQuote{ (result) in
            
            DispatchQueue.main.async {
                self.labelQuote.text = result.content
                self.labelAuthor.text = "\(result.author) once said..."
            }
        }
    }

    @IBAction func buttonNewQuoteTapped(_ sender: Any) {
        
        bounce(buttonNewQuote)
        playSound(sender: buttonNewQuote)
        quoteRequest.getQuote{ (result) in
            DispatchQueue.main.async {
                self.labelQuote.text = result.content
                self.labelAuthor.text = "\(result.author) once said..."
            }
        }
    }
        
    @IBAction func buttonSaveQuoteTapped(_ sender: UIButton) {
        
        bounce(buttonSaveQuote)
        playSound(sender: buttonSaveQuote)
        let newItem = QuoteEntity(context: DB.context)
        
        newItem.author = labelAuthor.text
        newItem.quote = labelQuote.text
        
        DB.saveData()
    }
    
    // MARK: animations
    
    
    
    
    //buttons bounce animation when tapped
    func bounce(_ sender: UIButton) {
        let theButton = sender
        let bounds = theButton.bounds
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3, options: .curveLinear, animations: {
            theButton.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 10, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                UIView.animate(withDuration: 0.5, animations: {
                    theButton.bounds = bounds
                    
                })
            }
        }
    }
    
    
    // MARK:- Sound effects

    func playSound(sender: UIButton) {
        
        buttonNewQuote.tag = 1
        buttonSaveQuote.tag = 2
        
        switch sender.tag {
            
        case 1:
            let pathToSound = Bundle.main.path(forResource: "pad_confirm", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }
            catch {
                print("sound broken. couldn't play sound for new quote button.")
            }
            
        case 2:
            let pathToSound = Bundle.main.path(forResource: "chime_bell_ding", ofType: "wav")!
            let url = URL(fileURLWithPath: pathToSound)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            }
            catch {
                print("sound broken. couldn't play sound for save quote button.")
            }
            
        default:
            return
        }
    }
    
    
    
}
