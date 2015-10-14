//
//  Game.swift
//  Flood It
//
//  Created by Zheng Chen on 2015-09-18.
//  Copyright © 2015 Zheng Chen. All rights reserved.
//

import Foundation

public class GameNotification {
    public func notify(r: Int, c: Int, state: Int) {
        print("This should never be called!");
        print("GameNotification.notify(r,c,state)");
    }
}

// Main Game class
public class Game {
    var theGrid = Array<Cell?>(); // The array of "invisible grid"
    var colours = [0,0,0,0,0]; // Statistics of number of 5 colours
    var notification = GameNotification();
    public var gridSize: Int;
    
    // ctor
    public init() {
        gridSize = 0;
    }
    
    // Called by Controller to notify game change
    public func notify(r: Int, c: Int, oldState: Int, newState: Int) {
        notification.notify(r, c: c, state: newState);
        --colours[oldState];
        ++colours[newState];
    }
    
    // Determine whether game is ended or not
    public func isWon() -> Bool {
        var filled = 0;
        var unfilled = 0;
        for var i=0; i < 5; ++i {
            if (colours[i] == 0) {
                ++unfilled;
            }
            else {
                ++filled;
            }
        }
        if ((filled == 1) && (unfilled == 4)) {
            return true;
        }
        else {
            return false;
        }
    }
    
    // Initialize the game, only got called during initialization
    public func initial(n: Int, gamenotification: GameNotification) {
        gridSize = n;
        self.notification = gamenotification;
        for var i=0; i < n*n; ++i {
            theGrid.append(Cell());
            theGrid[i]!.setCoords(i/n, c: i%n);
            theGrid[i]!.setGame(self);
        }
        for var i=0; i < n*n; ++i {
            if (i >= n) {
                // neighbour above
                theGrid[i]!.addNeighbour(theGrid[i-n]!);
            }
            if (i < n*(n-1)) {
                // neighbour below
                theGrid[i]!.addNeighbour(theGrid[i+n]!);
            }
            if ((i%n) > 0) {
                // neighbour left
                theGrid[i]!.addNeighbour(theGrid[i-1]!);
            }
            if ((i%n) < (n-1)) {
                // neighbour right
                theGrid[i]!.addNeighbour(theGrid[i+1]!);
            }
        }
    }
    
    // Change the colour of the grid
    public func change(c: Int) {
        theGrid[0]!.notify(c);
    }
    
    // Initialize the game, only called during initialization
    public func initial(r: Int, c: Int, change: Int) {
        if ((r >= 0) && (c >= 0) && (r < gridSize) && (c < gridSize)) {
            theGrid[r*gridSize+c]!.setState(change);
            theGrid[r*gridSize+c]!.setState(change);
            ++colours[change];
        }
    }
    
}
