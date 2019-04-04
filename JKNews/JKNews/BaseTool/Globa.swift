//
//  Globa.swift
//  JKNews
//
//  Created by 欢瑞世纪 on 2019/3/27.
//  Copyright © 2019 欢瑞世纪. All rights reserved.
//

import Foundation
import UIKit
public func RGBCOLOR(_ r: Float, _ g: Float, _ b: Float) -> UIColor {
    return RGBACOLOR(r, g, b, 1)
}

public func RGBCOLOR(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
    return RGBACOLOR(Float(r), Float(g), Float(b), 1)
}

public func RGBACOLOR(_ r: Float, _ g: Float, _ b: Float, _ a: Float) -> UIColor {
    return UIColor(red: CGFloat(r / 255.0),
                   green: CGFloat(g / 255.0),
                   blue: CGFloat(b / 255.0),
                   alpha: CGFloat(a))
}

public func RGBACOLOR(_ r: Int, _ g: Int, _ b: Int, _ a: Float) -> UIColor {
    return RGBACOLOR(Float(r), Float(g), Float(b), a)
}

public func HEXCOLOR(_ value: Int)  -> UIColor {
    return RGBCOLOR(((value >> 16) & 0xFF), ((value >> 8) & 0xFF), (value & 0xFF))
}
