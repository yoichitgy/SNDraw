//
//  SNPath.swift
//  SNDraw
//
//  Created by satoshi on 8/5/16.
//  Copyright © 2016 Satoshi Nakajima. All rights reserved.
//

import UIKit

public struct SNPath {
    static func pathFrom(elements:[SNPathElement]) -> CGPath {
        let path = CGPathCreateMutable()
        for element in elements {
            element.addToPath(path)
        }
        return path
    }
    
    static func polyPathFrom(elements:[SNPathElement]) -> CGPath {
        let path = CGPathCreateMutable()
        for element in elements {
            element.addToPathAsPolygon(path)
        }
        return path
    }
}

public protocol SNPathElement {
    func addToPath(path:CGMutablePath)
    func addToPathAsPolygon(path:CGMutablePath)
}

extension SNPathElement {
    public func addToPathAsPolygon(path:CGMutablePath) {
        addToPath(path)
    }
}

public struct SNMove:SNPathElement {
    let pt:CGPoint
    init(x:CGFloat, y:CGFloat) {
        pt = CGPointMake(x,y)
    }
    
    public func addToPath(path:CGMutablePath) {
        CGPathMoveToPoint(path, nil, pt.x, pt.y)
    }
}

public struct SNLine:SNPathElement {
    let pt:CGPoint

    public func addToPath(path:CGMutablePath) {
        CGPathAddLineToPoint(path, nil, pt.x, pt.y)
    }
}

public struct SNQuadCurve:SNPathElement {
    let cpt:CGPoint
    let pt:CGPoint
    init(cpx: CGFloat, cpy: CGFloat, x: CGFloat, y: CGFloat) {
        cpt = CGPointMake(cpx, cpy)
        pt = CGPointMake(x, y)
    }

    public func addToPath(path:CGMutablePath) {
        CGPathAddQuadCurveToPoint(path, nil, cpt.x, cpt.y, pt.x, pt.y)
    }

    public func addToPathAsPolygon(path:CGMutablePath) {
        CGPathAddLineToPoint(path, nil, cpt.x, cpt.y)
        CGPathAddLineToPoint(path, nil, pt.x, pt.y)
    }
}

