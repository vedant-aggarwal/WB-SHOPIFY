# Banner Carousel - Assets Folder

This folder contains all banner images and videos for the homepage carousel.

## File Naming Convention

### Images
- **Desktop Images (16:9 aspect ratio - 1920x1080px recommended)**
  - `banner-homepage-1-desktop.jpg`
  - `banner-homepage-2-desktop.jpg`
  - `banner-homepage-3-desktop.jpg`
  - etc.

- **Mobile Images (3:4 aspect ratio - 768x1024px recommended)**
  - `banner-homepage-1-mobile.jpg`
  - `banner-homepage-2-mobile.jpg`
  - `banner-homepage-3-mobile.jpg`
  - etc.

### Videos (NEW!)
- **Desktop Videos (16:9 aspect ratio - MP4 format)**
  - `banner-homepage-1-desktop.mp4`
  - `banner-homepage-2-desktop.mp4`
  - `banner-homepage-3-desktop.mp4`
  - etc.

- **Mobile Videos (3:4 aspect ratio - MP4 format)**
  - `banner-homepage-1-mobile.mp4`
  - `banner-homepage-2-mobile.mp4`
  - `banner-homepage-3-mobile.mp4`
  - etc.

## How It Works

### Automatic Detection
- The system automatically scans for banners numbered 1-20
- If you have banner-homepage-6-desktop.jpg, it will show 6 banners total
- Videos take priority over images (if both exist, video will be used)
- At least one version (desktop/mobile, image/video) must exist for each banner number

### Flexible Banner Count
- Add as many banners as you need (up to 20)
- Navigation dots automatically adjust to the number of banners
- If only 1 banner exists, navigation dots are hidden

### Click Redirects
- Configure redirect URLs in the Shopify theme editor
- External URLs (http/https) open in new tab
- Internal URLs navigate within the site
- If no URL is set, banner is not clickable

### Video Features
- Auto-play, muted, looping
- Responsive video sources for desktop/mobile
- Videos maintain aspect ratio just like images

## Technical Specifications

### Image Requirements
- **File Format:** JPG (recommended for photos)
- **Desktop:** 16:9 aspect ratio (1920x1080px ideal)
- **Mobile:** 3:4 aspect ratio (768x1024px ideal)
- **File Size:** Under 500KB each for optimal loading

### Video Requirements
- **File Format:** MP4 (H.264 codec recommended)
- **Desktop:** 16:9 aspect ratio
- **Mobile:** 3:4 aspect ratio
- **File Size:** Under 2MB each for optimal loading
- **Duration:** 10-30 seconds recommended

### Performance Tips
- Optimize images using tools like TinyPNG
- Compress videos while maintaining quality
- Use progressive JPEG for images
- Test loading times on mobile networks

## Banner Behavior
- **Auto-advance:** Every 7 seconds
- **Touch/Drag:** Real-time finger tracking
- **Navigation:** Pill-shaped dots (overlaid on banner)
- **Responsive:** Maintains aspect ratios across all devices
- **Accessibility:** Keyboard navigation support

## Current Banner Files
The following banner files are currently in the assets folder:
- banner-homepage-1-desktop.jpg
- banner-homepage-1-mobile.jpg  
- banner-homepage-2-desktop.jpg
- banner-homepage-2-mobile.jpg
- banner-homepage-3-desktop.jpg
- banner-homepage-3-mobile.jpg
- banner-homepage-4-desktop.jpg
- banner-homepage-4-mobile.jpg
- banner-homepage-5-desktop.jpg
- banner-homepage-5-mobile.jpg

Replace these placeholder files with your actual banner images maintaining the same naming convention.