//
//  GraphView.swift
//  Gradulator
//
//  Created by Dalton Ng on 1/3/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
  
  private struct Constants {
    static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
    static let margin: CGFloat = 20.0
    static let topBorder: CGFloat = 60
    static let bottomBorder: CGFloat = 50
    static let colorAlpha: CGFloat = 0.3
    static let circleDiameter: CGFloat = 5.0
  }
  
  //1 - the properties for the gradient
  @IBInspectable var startColor: UIColor?
  @IBInspectable var endColor: UIColor?
  
  //Weekly sample data
  var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
  
  override func draw(_ rect: CGRect) {
    // Check if colours were set
    if startColor == nil {
        startColor = UIColor.red
    }
    if endColor == nil {
        endColor = UIColor.green
    }
    
    
    let width = rect.width
    let height = rect.height
    
    let path = UIBezierPath(roundedRect: rect,
                            byRoundingCorners: UIRectCorner.allCorners,
                            cornerRadii: Constants.cornerRadiusSize)
    path.addClip()
    
    //2 - get the current context
    let context = UIGraphicsGetCurrentContext()!
    let colors = [startColor?.cgColor, endColor?.cgColor]
    
    //3 - set up the color space
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    //4 - set up the color stops
    let colorLocations: [CGFloat] = [0.0, 1.0]
    
    //5 - create the gradient
    let gradient = CGGradient(colorsSpace: colorSpace,
                              colors: colors as CFArray,
                              locations: colorLocations)!
    
    //6 - draw the gradient
    var startPoint = CGPoint.zero
    var endPoint = CGPoint(x: 0, y: self.bounds.height)
    context.drawLinearGradient(gradient,
                               start: startPoint,
                               end: endPoint,
                               options: CGGradientDrawingOptions(rawValue: 0))
    
    //calculate the x point
    let margin = Constants.margin
    let columnXPoint = { (column:Int) -> CGFloat in
      //Calculate gap between points
      let spacer = (width - margin * 2 - 4) / CGFloat((self.graphPoints.count - 1))
      var x: CGFloat = CGFloat(column) * spacer
      x += margin + 2
      return x
    }
    
    // calculate the y point
    let topBorder: CGFloat = Constants.topBorder
    let bottomBorder: CGFloat = Constants.bottomBorder
    let graphHeight = height - topBorder - bottomBorder
    let maxValue = graphPoints.max()!
    let columnYPoint = { (graphPoint:Int) -> CGFloat in
      var y:CGFloat = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
      y = graphHeight + topBorder - y // Flip the graph
      return y
    }
    
    // draw the line graph
    UIColor.white.setFill()
    UIColor.white.setStroke()
    
    //set up the points line
    let graphPath = UIBezierPath()
    //go to start of line
    graphPath.move(to: CGPoint(x:columnXPoint(0), y:columnYPoint(graphPoints[0])))
    
    //add points for each item in the graphPoints array
    //at the correct (x, y) for the point
    for i in 1..<graphPoints.count {
      let nextPoint = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
      graphPath.addLine(to: nextPoint)
    }
    
    //Create the clipping path for the graph gradient
    
    //1 - save the state of the context (commented out for now)
    context.saveGState()
    
    //2 - make a copy of the path
    let clippingPath = graphPath.copy() as! UIBezierPath
    
    //3 - add lines to the copied path to complete the clip area
    clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y:height))
    clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
    clippingPath.close()
    
    //4 - add the clipping path to the context
    clippingPath.addClip()
    
    let highestYPoint = columnYPoint(maxValue)
    startPoint = CGPoint(x:margin, y: highestYPoint)
    endPoint = CGPoint(x:margin, y:self.bounds.height)
    
    context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
    context.restoreGState()
    
    //draw the line on top of the clipped gradient
    graphPath.lineWidth = 2.0
    graphPath.stroke()
    
    //Draw the circles on top of graph stroke
    for i in 0..<graphPoints.count {
      var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
      point.x -= Constants.circleDiameter / 2
      point.y -= Constants.circleDiameter / 2
      
      let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
      circle.fill()
    }
    
    //Draw horizontal graph lines on the top of everything
    let linePath = UIBezierPath()
    
    //top line
    linePath.move(to: CGPoint(x:margin, y: topBorder))
    linePath.addLine(to: CGPoint(x: width - margin, y:topBorder))
    
    //center line
    linePath.move(to: CGPoint(x:margin, y: graphHeight/2 + topBorder))
    linePath.addLine(to: CGPoint(x:width - margin, y:graphHeight/2 + topBorder))
    
    //bottom line
    linePath.move(to: CGPoint(x:margin, y:height - bottomBorder))
    linePath.addLine(to: CGPoint(x:width - margin, y:height - bottomBorder))
    let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
    color.setStroke()
    
    linePath.lineWidth = 1.0
    linePath.stroke()
  }
}
