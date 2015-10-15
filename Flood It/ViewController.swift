//
//  ViewController.swift
//  Flood It
//
//  Created by Zheng Chen on 2015-09-18.
//  Copyright © 2015 Zheng Chen. All rights reserved.
//

import UIKit

// The Graphic View and Controller of this application
class ViewController: UIViewController {
    
    var c: Controller?;
    var size = 0; // read size from user input
    var inGame = false; // #t if game is started
    @IBOutlet var GameStatus: UILabel! // Status bar of game
    /*
    gridArr represents all the grid in graphic display:
    0   j     ..... j*(i-1)
    1   j+1   ..... j*(i-1)+1
    2   j+2   ..... j*(i-1)+2
    ... ..... ..... .......
    j-1 2*j-1 ..... j*i-1
    */
    var gridArr = Array<UIView>();
    
    @IBOutlet weak var SizeText: UITextField! // Waiting for user input
    @IBOutlet var GameDisplay: UIView! // Game graphic display
    
    // Start the game by this button
    @IBAction func StartButton(sender: UIButton) {
        //Reading number from input and init Controller&textDisplay
        let sizeNumberHelper = NSNumberFormatter().numberFromString(SizeText.text!);
        if (sizeNumberHelper == nil) {
            return;
        }
        let sizeNumber = sizeNumberHelper!.integerValue;
        inGame = true;
        size = sizeNumber;
        c = Controller();
        c!.initialSize(sizeNumber);
        c!.initial(self);
        c!.move_left = sizeNumber/2*3;
        GameStatus.text = "Game Started! \(c!.move_left) moves left.";
        

        // Init Graphic Display here
        for var i=0; i < sizeNumber; ++i {
            for var j=0; j < sizeNumber; ++j {
                let frame = CGRectMake(GameDisplay.bounds.width*CGFloat(i)/CGFloat(sizeNumber), GameDisplay.bounds.height*CGFloat(j)/CGFloat(sizeNumber), GameDisplay.bounds.width/CGFloat(sizeNumber), GameDisplay.bounds.height/CGFloat(sizeNumber));
                let container = UIView.init(frame: frame);
                GameDisplay.addSubview(container);
                // Add the container to the array
                gridArr.append(container);
            }
        }
        
        // Give random value for the game
        c!.random_init();
    }
    
    // Control game using those five buttons. No reaction if game is not started.
    @IBAction func ColourButton(sender: UIButton) {
        if (inGame) {
            let digit = sender.currentTitle!;
            c!.change(digit);
            --c!.move_left;
        }
        if (c!.isWon() == true) {
            GameStatus.text = "You win!";
            inGame = false;
        }
        else if (c!.move_left == 0) {
            GameStatus.text = "Game Over!";
            inGame = false;
        }
        else {
            GameStatus.text = "\(c!.move_left) moves left!";
        }
    }
    
    // Notify graphic display to make change accordingly
    func notify(r: Int, c: Int, ch: Int) {
        if (ch == 0) {
            gridArr[c*size+r].backgroundColor = UIColor.blueColor();
        }
        if (ch == 1) {
            gridArr[c*size+r].backgroundColor = UIColor.purpleColor();
        }
        if (ch == 2) {
            gridArr[c*size+r].backgroundColor = UIColor.redColor();
        }
        if (ch == 3) {
            gridArr[c*size+r].backgroundColor = UIColor.yellowColor();
        }
        if (ch == 4) {
            gridArr[c*size+r].backgroundColor = UIColor.greenColor();
        }
    }
    
    // After view loaded, enable clearsOnBeginEditing to make text disappear when user start editing
    override func viewDidLoad() {
        SizeText.clearsOnBeginEditing = true;
    }

}

