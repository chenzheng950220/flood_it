//
//  Cell.swift
//  Flood It
//
//  Created by Zheng Chen on 2015-09-18.
//  Copyright © 2015 Zheng Chen. All rights reserved.
//

import Foundation

// Cell class of the game
public class Cell {
    var state: Int; // Current state
    var prevState: Int; // Previous state
    var numNeighbours: Int; // Number of neighbours
    var neighbours = Array<Cell?>(); // The array of actual neighbours
    var r: Int; // Coordinates r
    var c: Int; // Coordinates c
    var game: Game?;
    
    // Notify neighbours about the change of itself
    func notifyNeighbours() {
        for var i=0; i < numNeighbours; ++i {
            neighbours[i]!.notify(state, previous: prevState);
        }
    }
    
    // Notify game that grid is changing
    func notifyGame() {
        game!.notify(r, c: self.c, oldState: prevState, newState: state);
    }
    
    // ctor
    public init() {
        state = 0;  prevState = 0;  numNeighbours = 0;  r = 0;
        c = 0;  game = nil;
        for var i=0; i < 4; ++i {
            neighbours.append(nil);
        }
    }
    
    public func getState() -> Int {
        return self.state;
    }
    
    public func setState(change: Int) {
        self.prevState = self.state;
        self.state = change;
    }
    
    public func setCoords(r: Int, c: Int) {
        self.r = r;
        self.c = c;
    }
    
    public func setGame(g: Game) {
        self.game = g;
    }
    
    // Add neighbour to itself
    public func addNeighbour(neigh: Cell) {
        if (numNeighbours >= 4) {
            print("No neighbours can be added!");
            return;
        }
        neighbours[numNeighbours] = neigh;
        ++numNeighbours;
    }
    
    // Called by Game to notify the change from Controller
    public func notify(change: Int) {
        setState(change);
        notifyNeighbours();
        notifyGame();
    }
    
    // Called by Game to notify the change from Controller
    public func notify(current: Int, previous: Int) {
        if ((state == previous) && (state != current)) {
            setState(current);
            notifyNeighbours();
            notifyGame();
        }
    }
    
}

