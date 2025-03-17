//
//  AppIconPreview.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

import SwiftUI

/// A preview of what the app icon could look like
/// This can be used as a reference for creating the actual icon images
struct AppIconPreview: View {
    // Colors from the design specifications
    private let royalPurple = Color(red: 74/255, green: 42/255, blue: 103/255)
    private let medievalGold = Color(red: 229/255, green: 196/255, blue: 109/255)
    private let shadowPurple = Color(red: 58/255, green: 31/255, blue: 87/255)
    
    // Pixel grid size (higher number = more detailed)
    private let gridSize: Int = 16
    
    var body: some View {
        ZStack {
            // Background
            royalPurple
            
            // Castle structure (pixel art style)
            PixelArtCastle(gridSize: gridSize, castleColor: medievalGold, shadowColor: shadowPurple)
            
            // Border
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(medievalGold, lineWidth: 8)
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(16)
        .padding()
        .frame(maxWidth: 300, maxHeight: 300)
        .shadow(radius: 10)
    }
}

/// A pixel art castle for the app icon
struct PixelArtCastle: View {
    let gridSize: Int
    let castleColor: Color
    let shadowColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            let pixelSize = min(geometry.size.width, geometry.size.height) / CGFloat(gridSize)
            
            ZStack {
                // Castle base
                PixelRect(x: 3, y: 10, width: 10, height: 6, pixelSize: pixelSize, color: castleColor)
                
                // Castle shadow
                PixelRect(x: 3, y: 15, width: 10, height: 1, pixelSize: pixelSize, color: shadowColor)
                
                // Left tower
                PixelRect(x: 3, y: 6, width: 2, height: 4, pixelSize: pixelSize, color: castleColor)
                
                // Right tower
                PixelRect(x: 11, y: 6, width: 2, height: 4, pixelSize: pixelSize, color: castleColor)
                
                // Center tower
                PixelRect(x: 7, y: 4, width: 2, height: 6, pixelSize: pixelSize, color: castleColor)
                
                // Left tower top
                PixelRect(x: 2, y: 5, width: 4, height: 1, pixelSize: pixelSize, color: castleColor)
                
                // Right tower top
                PixelRect(x: 10, y: 5, width: 4, height: 1, pixelSize: pixelSize, color: castleColor)
                
                // Center tower top
                PixelRect(x: 6, y: 3, width: 4, height: 1, pixelSize: pixelSize, color: castleColor)
                
                // Flag
                PixelRect(x: 7, y: 1, width: 1, height: 2, pixelSize: pixelSize, color: castleColor)
                PixelRect(x: 8, y: 1, width: 2, height: 1, pixelSize: pixelSize, color: castleColor)
                
                // Door
                PixelRect(x: 7, y: 12, width: 2, height: 4, pixelSize: pixelSize, color: shadowPurple)
                
                // Windows
                PixelRect(x: 4, y: 8, width: 1, height: 1, pixelSize: pixelSize, color: shadowPurple)
                PixelRect(x: 11, y: 8, width: 1, height: 1, pixelSize: pixelSize, color: shadowPurple)
                PixelRect(x: 5, y: 12, width: 1, height: 1, pixelSize: pixelSize, color: shadowPurple)
                PixelRect(x: 10, y: 12, width: 1, height: 1, pixelSize: pixelSize, color: shadowPurple)
                
                // Battlements (top of walls)
                ForEach(0..<5) { i in
                    PixelRect(x: 3 + (i*2), y: 9, width: 1, height: 1, pixelSize: pixelSize, color: castleColor)
                }
                
                // Tower battlements
                PixelRect(x: 3, y: 5, width: 1, height: 1, pixelSize: pixelSize, color: castleColor)
                PixelRect(x: 12, y: 5, width: 1, height: 1, pixelSize: pixelSize, color: castleColor)
                PixelRect(x: 7, y: 3, width: 1, height: 1, pixelSize: pixelSize, color: castleColor)
            }
        }
    }
}

/// A rectangle made of pixels for the pixel art
struct PixelRect: View {
    let x: Int
    let y: Int
    let width: Int
    let height: Int
    let pixelSize: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: pixelSize * CGFloat(width), height: pixelSize * CGFloat(height))
            .position(
                x: pixelSize * CGFloat(x) + (pixelSize * CGFloat(width) / 2),
                y: pixelSize * CGFloat(y) + (pixelSize * CGFloat(height) / 2)
            )
    }
}

/// A preview of the app icon at different sizes
struct AppIconSizesPreview: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("App Icon Preview")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            AppIconPreview()
                .frame(width: 180, height: 180)
            
            Text("Small Size Preview")
                .font(.headline)
            
            HStack(spacing: 20) {
                AppIconPreview()
                    .frame(width: 60, height: 60)
                
                AppIconPreview()
                    .frame(width: 40, height: 40)
                
                AppIconPreview()
                    .frame(width: 29, height: 29)
                
                AppIconPreview()
                    .frame(width: 20, height: 20)
            }
            
            Text("This is a reference design only.\nActual pixel art may need adjustments for each size.")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.top)
        }
        .padding()
    }
}

struct AppIconPreview_Previews: PreviewProvider {
    static var previews: some View {
        AppIconSizesPreview()
    }
} 