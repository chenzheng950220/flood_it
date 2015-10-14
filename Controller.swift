//
//  Controller.swift
//  Flood It
//
//  Created by Zheng Chen on 2015-09-21.
//  Copyright © 2015 Zheng Chen. All rights reserved.
//

import Foundation

// Main Controller of this game
public class Controller : GameNotification{
    var td: View?; // Text Display for debugging purpose
    var g = Game();
    var vc: ViewController?; // Linked to ViewController
    var move_left = 0; // Moves left in the game
    
    public override init() {
        // Contructor do nothing
        // Have to call initialSize before using
        super.init();
    }
    
    // Initialize the size of this controller
    public func initialSize(n: Int) {
        td = TextDisplay(n: n);
        g.initial(n, gamenotification: self)
    }
    
    // Link the ViewController with Controller
    func initial(view_controller: ViewController) {
        vc = view_controller;
    }
    
    // Called by ViewController when user make the change in the game
    public func change(change: String) {
        g.change(NSNumberFormatter().numberFromString(change)!.integerValue);
        td!.printGrid();
    }
    
    // Notify display makes the change accordingly
    public override func notify(r: Int, c: Int, state: Int) {
        td!.notify(r, c: c, ch: state);
        vc!.notify(r, c: c, ch: state);
    }
    
    // Randomly giving value to grids
    public func random_init() {
        var state = 0;
        for var i=0; i < g.gridSize; ++i {
            for var j=0; j < g.gridSize; ++j {
                state = Int(arc4random_uniform(5));
                g.initial(i,c: j,change: state);
                td!.notify(i, c: j, ch: state);
                vc!.notify(i, c: j, ch: state);
            }
        }
        td!.printGrid();
    }
    
    public func isWon() -> Bool {
        return g.isWon();
    }
    
}
