//
//  EventDataLoader.swift
//  TracksterViewer
//
//  Created by Ziheng Chen on 8/24/19.
//  Copyright © 2019 Ziheng Chen. All rights reserved.
//

import Foundation

func readDataFromCSV(fileName:String) -> ([[String]],[[String]])? {
    guard let filepath = Bundle.main.path(forResource: fileName, ofType: "csv")
        else {
            return nil
    }
    do {
        let contents = try String(contentsOfFile: filepath, encoding: .utf8)
        
        var dataGenPart: [[String]] = []
        var dataCluster: [[String]] = []
        
        let rows = contents.components(separatedBy: "\n")
        for row in rows {
            var columns = row.components(separatedBy: ",")
            
            if columns[0] == "genpart" {
                columns.remove(at: 0)
                dataGenPart.append(columns)
            }
            if columns[0] == "cluster" {
                columns.remove(at: 0)
                dataCluster.append(columns)
            }
        }
        
        
        return (dataGenPart, dataCluster)
    } catch {
        print("File Read Error for file \(filepath)")
        return nil
    }
}
