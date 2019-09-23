//
//  Python3Lexer.swift
//  SourceEditor
//
//  Created by Stefan Wijnja on 27/07/2018.
//  Based on SwiftLexer.swift by Louis D'hauwe.
//  Copyright © 2018 Silver Fox. All rights reserved.
//

import Foundation

public class LaTeXLexer: SourceCodeRegexLexer {
	
	public init() {
		
	}
	
	lazy var generators: [TokenGenerator] = {
		
		var generators = [TokenGenerator?]()
		// Functions
		//generators.append(regexGenerator("\\bprint(?=\\()", tokenType: .identifier))
        
		generators.append(regexGenerator("(?<=[^a-zA-Z])\\d+", tokenType: .number))
		
		generators.append(regexGenerator("\\.\\w+", tokenType: .identifier))
		
        var keywords: [String] = []
        let typeList = ["part", "chapter", "section", "subsection", "subsubsection", "paragraph", "subparagraph", "include", "input", "documentclass", "begin"]
        
        for type in typeList {
            keywords.append("\\\\\(type)\\{([\\w\\s\\.\\/]+)\\}")
        }
        
		generators.append(keywordGenerator(keywords, tokenType: .keyword))
		
		// Line comment
        generators.append(regexGenerator("%(.*)", tokenType: .comment))
		
		// Block comment or multi-line string literal


		// Editor placeholder
		var editorPlaceholderPattern = "(<#)[^\"\\n]*"
		editorPlaceholderPattern += "(#>)"
		generators.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

		return generators.compactMap( { $0 })
	}()
	
	public func generators(source: String) -> [TokenGenerator] {
		return generators
	}
	
}
