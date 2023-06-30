//
//  ContentViewModel.swift
//  vn.htk.watchapp Watch App
//
//  Created by Viet Nguyen on 6/30/23.
//

import Foundation

struct ContentViewModel {
    static private let arrQuotes: [ContentModel] = [
        ContentModel(words: "If you are going through hell, keep going.", author: "Winston Churchill"),
        ContentModel(words: "If you build it, they will come.", author: "Joe Jackson (character)"),
        ContentModel(words: "If you want something done right, do it yourself.", author: "Charles-Guillaume Étienne"),
        ContentModel(words: "If you want something said, ask a man; if you want something done, ask a woman.", author: "Margaret Thatcher"),
        ContentModel(words: "Love your Enemies, for they tell you your Faults.", author: "Poor Richard’s Almanack, 1756"),
        ContentModel(words: "He that falls in love with himself will have no rivals.", author: "Poor Richard’s Almanack, 1739"),
        ContentModel(words: "“There never was a good war or a bad peace.”", author: "Letter to Sir Joseph Banks, president of the Royal Society of London, July 1783. Also cited in a letter to Quincy, Sr., American merchant, planter and politician, September 1783.")
    ]
    
    static public var quote: ContentModel? {
        let modelRand = arrQuotes.randomElement()
        return modelRand
    }
}

struct ContentModel {
    let words: String
    let author: String
}
