//
//  AppIconInstructions.swift
//  LandLord
//
//  Created for bunkeboyLandLord2
//  Medieval 8-bit themed real estate app
//

/*
 APP ICON DESIGN INSTRUCTIONS
 
 The LandLord app icon features a medieval castle in pixel art style with a purple and gold color scheme.
 
 Design Specifications:
 
 1. Base Design:
    - Background: Royal purple (#4A2A67)
    - Castle: Pixel art style in gold (#E5C46D)
    - Border: Thin gold pixel border around the icon
    - Optional: Small flag on top of the castle in gold
 
 2. Pixel Art Style:
    - Use a grid-based approach with clear pixels
    - Keep details minimal for recognizability at small sizes
    - Use straight lines and 90-degree angles for the true pixel art look
    - Limit to 2-3 colors maximum (purple background, gold castle, optional darker purple for shadows)
 
 3. Required Icon Sizes:
    The AppIcon.appiconset/Contents.json file lists all required sizes:
    
    iPhone:
    - 20pt@2x: 40×40 pixels
    - 20pt@3x: 60×60 pixels
    - 29pt@2x: 58×58 pixels
    - 29pt@3x: 87×87 pixels
    - 40pt@2x: 80×80 pixels
    - 40pt@3x: 120×120 pixels
    - 60pt@2x: 120×120 pixels
    - 60pt@3x: 180×180 pixels
    
    iPad:
    - 20pt@1x: 20×20 pixels
    - 20pt@2x: 40×40 pixels
    - 29pt@1x: 29×29 pixels
    - 29pt@2x: 58×58 pixels
    - 40pt@1x: 40×40 pixels
    - 40pt@2x: 80×80 pixels
    - 76pt@1x: 76×76 pixels
    - 76pt@2x: 152×152 pixels
    - 83.5pt@2x: 167×167 pixels
    
    App Store:
    - 1024×1024 pixels (no alpha channel)
 
 4. Design Tips:
    - Start with the largest size (1024×1024) and scale down
    - For the smallest sizes, simplify the design further to maintain clarity
    - Ensure the icon is recognizable even at the smallest size (20×20)
    - Keep the castle centered in the frame
    - Add a subtle shadow under the castle for depth
    - Make sure the icon looks good on both light and dark backgrounds
 
 5. Alternative Approach Using SF Symbols:
    If creating pixel art is challenging, you can use SF Symbols as a base:
    - Use "house.fill" or "building.columns.fill" as a starting point
    - Add pixel-style modifications and castle elements
    - Apply the purple background and gold foreground colors
    - Add pixel-style details to give it the medieval castle look
 
 6. File Naming:
    Save each icon with the exact filename specified in the Contents.json file:
    - AppIcon-20.png
    - AppIcon-20@2x.png
    - AppIcon-20@3x.png
    - etc.
 
 7. Color Codes:
    - Royal Purple: #4A2A67 (RGB: 74, 42, 103)
    - Medieval Gold: #E5C46D (RGB: 229, 196, 109)
    - Optional Shadow Purple: #3A1F57 (RGB: 58, 31, 87)
 
 Once all icon files are created, place them in the AppIcon.appiconset folder.
 */

// This file contains no actual code, it's just a guide for creating the app icon 