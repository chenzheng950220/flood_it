//
//  TextDisplay.swift
//  Flood It
//
//  Created by Zheng Chen on 2015-09-18.
//  Copyright © 2015 Zheng Chen. All rights reserved.
//

import Foundation

public class TextDisplay : View {
    var theDisplay = Array<Array<Int>>();
    
    public override init(n: Int) {
        super.init(n: n);
        for i in 0 ... gridSize {
            theDisplay.append(Array<Int>());
            for _ in 0 ... gridSize {
                theDisplay[i].append(0);
            }
        }
        
    }
    
    public override func notify(r: Int, c: Int, ch: Int) {
        if ((r >= 0) && (c >= 0) && (r < gridSize) && (c < gridSize)) {
            theDisplay[r][c] = ch;
        }
    }
    
    public override func printGrid() {
        for var i=0; i < gridSize; ++i {
            for var j=0; j < gridSize; ++j {
                print("\(theDisplay[i][j])", terminator: "");
            }
            print("");
        }
        print("\n");
    }
    
}
