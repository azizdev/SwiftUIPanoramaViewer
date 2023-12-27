//
//  EularAngleConverter.swift
//  SwiftUIPanoramaViewer Package
//
//  Created by Kevin Mullins on 3/31/22.
//

import Foundation

// Handles turning a SceneKit camera's eular angles into a 360 degree rotation offset.
class EularAngleConverter {
    
    // MARK: - Enumerations
    enum Quadrant {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    
    // MARK: - Properties
    private var quad:Quadrant = .topLeft
    private var lastAngle:Float = 0.0
    
    // MARK: - Functions
    func reset() {
        quad = .topLeft
        lastAngle = 0.0
    }
    
    func eularToDegrees(_ angle:Float) -> Float {
        // Calculate the initial angle which will fall into two chunks (0...90) & (90...180)
        // with two "magic" numbers 90 and -90.
        let rawAngle = (angle * 180.0) / Float(Double.pi)
        let angleRounded = round(rawAngle)
        var degrees = angleRounded
        
        // If less than zero adjust the number to be positive.
        if degrees < 0.0 {
            degrees += 180.0
        }
        
        // Generate the initial output angle.
        var outputAngle: Float = 0.0
        
        // Handle debouncing the rotation.
        if angleRounded != lastAngle {
            // Handle the debounced angle changing.
            if angleRounded == 90.0 {
                // Handle swinging past the top and bottom sides of the sphere.
                if quad == .topRight {
                    quad = .bottomRight
                } else if quad == .bottomRight {
                    quad = .topRight
                }
                
                // Adjust the right side magic number.
                outputAngle = 270
            } else if angleRounded == -90.0 {
                // Handle swinging past the top and bottom sides of the sphere.
                if quad == .topLeft {
                    quad = .bottomLeft
                } else if quad == .bottomLeft {
                    quad = .topLeft
                }
                
                // Adjust the left side magic number.
                outputAngle = 90
            } else if degrees >= 0 && degrees <= 89 {
                // Handle being on the left side of the sphere and the possibility of swinging from the left to the right side.
                switch quad {
                case .topLeft:
                    outputAngle = degrees
                case .topRight:
                    quad = .topLeft
                case .bottomLeft:
                    outputAngle = 180 - degrees
                case .bottomRight:
                    quad = .bottomLeft
                }
            } else if degrees >= 89 && degrees <= 180 {
                // Handle being on the right side of the sphere and the possibility of swinging from the left to the right side.
                switch quad {
                case .topLeft:
                    quad = .topRight
                case .topRight:
                    outputAngle = 175 + degrees
                case .bottomLeft:
                    quad = .bottomRight
                case .bottomRight:
                    outputAngle = 360 - degrees
                }
            }
        } else {
            // Handle non debounced values.
            if angleRounded == 90 {
                // Adjust the right side magic number.
                outputAngle = 270
            } else if angleRounded == -90 {
                // Adjust the left side magic number.
                outputAngle = 90
            } else if degrees >= 0 && degrees <= 89 {
                // Handle being on the left side of the sphere.
                if quad == .bottomLeft {
                    outputAngle = 180 - degrees
                } else {
                    outputAngle = degrees
                }
            } else if degrees >= 89 && degrees <= 180 {
                // Handle being on the right side of the sphere.
                if quad == .bottomRight {
                    outputAngle = 360 - degrees
                } else {
                    outputAngle = 175 + degrees
                }
            }
        }
        
        // Save the last angle.
        lastAngle = angleRounded
        
        // Return the computed degrees of rotation.
        return outputAngle
    }
}
