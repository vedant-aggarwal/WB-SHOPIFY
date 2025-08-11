# Theme Design Guide

## Color Palette

### Primary Colors
- **Brown/Saddle Brown**: `#8B4513` - Used for primary text, icons, and buttons
- **Beige/Ivory**: `#F5F5DC` - Used for backgrounds and light elements
- **Sandy Brown**: `#A0522D` - Used for hover states and secondary elements

### Usage Guidelines
- Use brown (`#8B4513`) for all primary text, navigation links, and interactive elements
- Use beige (`#F5F5DC`) for header backgrounds and light sections
- Use sandy brown (`#A0522D`) for hover states and subtle highlights

## Typography

### Font Styling
- **Logo/Brand Name**: Uppercase, wide letter spacing (0.3em), centered
- **Navigation**: Uppercase, medium letter spacing (0.1em), medium font weight
- **Body Text**: Regular weight, readable line height

### Hierarchy
- Use appropriate font sizes to create clear visual hierarchy
- Maintain consistent letter spacing for brand elements
- Keep text readable with good contrast against backgrounds

## Layout & Spacing

### Header
- Height: 4rem (64px)
- Centered logo on mobile, left-aligned on desktop
- Hamburger menu on mobile, full navigation on desktop
- Clean spacing with adequate padding

### Announcement Bar
- Prominent brown background with light text
- Centered content with responsive padding
- Clear, concise messaging

## Component Patterns

### Buttons & Links
- No underlines by default
- Hover states with color transitions
- Consistent padding and spacing
- Brown color scheme throughout

### Icons
- Size: 1.5rem (24px) for header icons
- Consistent stroke width and style
- Color matches text color (#8B4513)

### Cart Badge
- Circular badge with brown background
- White/light text for contrast
- Positioned top-right of cart icon

## Responsive Design

### Mobile-First Approach
- Hamburger menu for mobile navigation
- Centered logo on mobile
- Stacked elements for better mobile experience

### Desktop Enhancements
- Full navigation menu visible
- Logo positioned left with navigation
- Improved spacing and layout

## Brand Guidelines

### Logo Treatment
- Always uppercase
- Maintain wide letter spacing
- Use consistent brown color
- Center on mobile, left-align on desktop

### Voice & Tone
- Clean and minimal
- Professional yet approachable
- Consistent messaging across all elements

## Implementation Notes

### CSS Variables
- Use existing theme variables where possible
- Maintain consistency with theme structure
- Follow BEM methodology for class naming

### Accessibility
- Ensure proper color contrast ratios
- Maintain keyboard navigation
- Use semantic HTML structure
- Provide alt text for images and icons

### Performance
- Use inline SVGs for icons when possible
- Optimize images and assets
- Minimize CSS and JavaScript where applicable