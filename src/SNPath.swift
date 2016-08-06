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
        return elements.reduce(CGPathCreateMutable()) { (path, element) -> CGMutablePath in
            return element.addToPath(path)
        }
    }
    
    static func polyPathFrom(elements:[SNPathElement]) -> CGPath {
        return elements.reduce(CGPathCreateMutable()) { (path, element) -> CGMutablePath in
            return element.addToPathAsPolygon(path)
        }
    }
}

public protocol SNPathElement {
    func addToPath(path:CGMutablePath) -> CGMutablePath
    func addToPathAsPolygon(path:CGMutablePath) -> CGMutablePath
}

extension SNPathElement {
    public func addToPathAsPolygon(path:CGMutablePath) -> CGMutablePath {
        return addToPath(path)
    }
}

public struct SNMove:SNPathElement {
    let pt:CGPoint
    init(x:CGFloat, y:CGFloat) {
        pt = CGPointMake(x,y)
    }
    
    public func addToPath(path:CGMutablePath) -> CGMutablePath {
        CGPathMoveToPoint(path, nil, pt.x, pt.y)
        return path
    }
}

public struct SNLine:SNPathElement {
    let pt:CGPoint

    public func addToPath(path:CGMutablePath) -> CGMutablePath {
        CGPathAddLineToPoint(path, nil, pt.x, pt.y)
        return path
    }
}

public struct SNQuadCurve:SNPathElement {
    let cp:CGPoint
    let pt:CGPoint
    init(cpx: CGFloat, cpy: CGFloat, x: CGFloat, y: CGFloat) {
        cp = CGPointMake(cpx, cpy)
        pt = CGPointMake(x, y)
    }

    public func addToPath(path:CGMutablePath) -> CGMutablePath {
        CGPathAddQuadCurveToPoint(path, nil, cp.x, cp.y, pt.x, pt.y)
        return path
    }

    public func addToPathAsPolygon(path:CGMutablePath) -> CGMutablePath {
        CGPathAddLineToPoint(path, nil, cp.x, cp.y)
        CGPathAddLineToPoint(path, nil, pt.x, pt.y)
        return path
    }
}

public struct SNBezierCurve:SNPathElement {
    let cp1:CGPoint
    let cp2:CGPoint
    let pt:CGPoint
    init(cp1x: CGFloat, cp1y: CGFloat, cp2x: CGFloat, cp2y: CGFloat,x: CGFloat, y: CGFloat) {
        cp1 = CGPointMake(cp1x, cp1y)
        cp2 = CGPointMake(cp2x, cp2y)
        pt = CGPointMake(x, y)
    }

    public func addToPath(path:CGMutablePath) -> CGMutablePath {
        CGPathAddCurveToPoint(path, nil, cp1.x, cp1.y, cp2.x, cp2.y, pt.x, pt.y)
        return path
    }

    public func addToPathAsPolygon(path:CGMutablePath) -> CGMutablePath {
        CGPathAddLineToPoint(path, nil, cp1.x, cp1.y)
        CGPathAddLineToPoint(path, nil, cp2.x, cp2.y)
        CGPathAddLineToPoint(path, nil, pt.x, pt.y)
        return path
    }
}
