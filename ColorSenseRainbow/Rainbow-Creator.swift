//
//  Rainbow-Creator.swift
//  Rainbow Creator UIColor & NSColor Extension
//
//  Created by Reid Gravelle on 2015-03-18.
//  Copyright (c) 2015 Northern Realities Inc. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

#if os(iOS)
    import UIKit
    public typealias Color = UIColor
#else
    import AppKit
    public typealias Color = NSColor
#endif


extension Color {
    /**
     Returns a color object representing the color with the given RGB component values and has the specified opacity.
     
     - parameter redValue: The red component of the color object, specified as a value between 0 and 255.
     - parameter greenValue: The green component of the color object, specified as a value between 0 and 255.
     - parameter blueValue: The blue component of the color object, specified as a value between 0 and 255.
     - parameter alphaValue: A CGFloat between 0.0 and 1.0 representing the opacity with a default value of 1.0.
     
     - returns: The color object
     */
    
    convenience init ( redValue: Int, greenValue: Int, blueValue: Int, alphaValue: CGFloat = 1.0 ) {
        
        let redFloat = CGFloat ( redValue ) / 255.0
        let greenFloat = CGFloat ( greenValue ) / 255.0
        let blueFloat = CGFloat ( blueValue ) / 255.0
        
        self.init ( red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaValue )
    }
    
    
    /**
     Returns a color object representing the color with the given RGB component values with an opacity (alpha) of 1.0.  Values below 0 will be treated as 0 and values above 1 will be treated as 1.
     
     - parameter red:   The red component of the color, specified between 0 and 1.
     - parameter green: The green component of the color, specified between 0 and 1.
     - parameter blue:  The blue component of the color, specified between 0 and 1.
     
     - returns: The color object.
     */
    
    convenience init ( red: CGFloat, green: CGFloat, blue: CGFloat ) {
        
        self.init ( red: red, green: green, blue: blue, alpha: 1.0 )
    }
    
    
    /**
     Returns a color object representing the color with the given RGB value passed in as a hexadecimal integer and has the specified opacity.
     
     - parameter hex: The red, green, and blue components that compromise the color combined into a single hexadecimal number.  Each component has two digits which range from 0 through to f.
     - parameter alphaValue: A CGFloat between 0.0 and 1.0 representing the opacity with a default value of 1.0.
     
     - returns: The color object
     */
    
    convenience init ( hex : Int, alpha : CGFloat = 1.0 ) {
        
        let red = ( hex >> 16 ) & 0xff
        let green = ( hex >> 08 ) & 0xff
        let blue = hex & 0xff
        
        self.init ( redValue: red, greenValue: green, blueValue: blue, alphaValue: alpha )
    }
    
    
    /**
     Returns a color object representing the color with the given RGB value passed in as a hexadecimal integer and has the specified opacity.
     
     - parameter hex: The red, green, and blue components that compromise the color combined into a single hexadecimal string.  Each component has two characters which range from 0 through to f.  The string may be optionally prefixed with a '#' sign.
     - parameter alphaValue: A CGFloat between 0.0 and 1.0 representing the opacity with a default value of 1.0.
     
     - returns: The color object
     */
    
    convenience init ( hexString : String, alpha : CGFloat = 1.0 ) {
        
        var hexIntValue : UInt32 = 0x000000
        
        let stringSize = hexString.characters.count
        
        
        if ( ( stringSize == 6 ) || ( stringSize == 7 ) ) {
            
            let range = NSMakeRange( 0, stringSize )
            let pattern = "#?[0-9A-F]{6}"
            
            do {
                let regex = try NSRegularExpression ( pattern: pattern, options: .CaseInsensitive)
                let matchRange = regex.rangeOfFirstMatchInString( hexString, options: .ReportProgress, range: range )
                
                if matchRange.location != NSNotFound {
                    var workingString = hexString
                    
                    if ( stringSize == 7 ) {
                        workingString = workingString.substringFromIndex( workingString.startIndex.advancedBy(1 ) )
                    }
                    
                    NSScanner ( string: workingString ).scanHexInt ( &hexIntValue )
                }
            } catch let error as NSError {
                print ( "Error creating regular expression to check validity of hex string \"\(hexString)\" - \(error.localizedDescription)" )
            }
        }
        
        
        self.init ( hex: Int( hexIntValue ), alpha: alpha )
    }
    
    
    /**
     Returns a color object representing the color with the given HSB component values and has the specified opacity.  No error checking is performed to ensure that numbers are within the expected bounds.  If a number is below the expected value it is treated as the expected value.  The same applies for the upper bound.
     
     - parameter hueDegrees: The hue component of the color object, specified as the number of degrees between 0 and 359.
     - parameter saturationPercent: The saturation component of the color object, specified as a percentage value between 0 and 100.
     - parameter brightnessPercent: The brightness component of the color object, specified as a percentage value between 0 and 100.
     - parameter alphaValue: A CGFloat between 0.0 and 1.0 representing the opacity with a default value of 1.0.
     
     - returns: The color object
     */
    
    convenience init ( hueDegrees: Int, saturationPercent: Int, brightnessPercent: Int, alpha: CGFloat = 1.0 ) {
        
        self.init ( calibratedHue: CGFloat ( Double ( hueDegrees ) / 360.0 ), saturation: CGFloat ( Double ( saturationPercent ) / 100.0 ), brightness: CGFloat ( Double ( brightnessPercent ) / 100.0 ), alpha: alpha )
    }
}

