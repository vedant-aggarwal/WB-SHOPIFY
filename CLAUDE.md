# Claude AI Assistant Guide for WB-SHOPIFY Project

## Project Overview
This is a Shopify theme project located in the `theme/` directory. The project contains frontend code for a fashion e-commerce website with a brown/beige color scheme.

## Current Project Structure
- **theme/**: Main Shopify theme directory containing all frontend code
- **assets/**: Images, CSS, JavaScript files, and banner media
- **sections/**: Liquid section files (banner-carousel.liquid, product-categories.liquid, etc.)
- **templates/**: Page templates
- **config/**: Theme configuration and settings
- **snippets/**: Reusable code snippets
- **layout/**: Theme layout files
- **locales/**: Translation files

## Current Theme Design System

### Color Palette
- **Primary Brown**: `#8B4513` - Used for text, icons, buttons
- **Beige/Ivory**: `#F5F5DC` - Used for backgrounds and light elements  
- **Sandy Brown**: `#A0522D` - Used for hover states and secondary elements

### Typography
- Logo/Brand: Uppercase, wide letter spacing (0.3em)
- Navigation: Uppercase, medium letter spacing (0.1em)
- Body text: Regular weight, readable line height

### Main Categories (from categories.json)
The 7 main categories to display:
1. **Designer Saree Collection Shop Now** - Sarees
2. **Exclusive Lehenga Collection Shop Now** - Lehengas  
3. **Premium Dress Collection Shop Now** - Dresses
4. **Fancy Suits Collection Shop Now** - Suits
5. **Clothing Accessories** - Accessories
6. **Mens Collection** - Mens Wear
7. **Mens Accessories** - Mens Accessories

Each main category contains multiple subcategories as defined in categories.json.

## Current Implementation Details

### Banner System
- Currently uses custom carousel with drag/swipe functionality
- Supports both desktop (16:9) and mobile (3:4) aspect ratios
- Auto-play with 7-second intervals
- Mouse and touch drag support
- Dot navigation

### Category Display
- Currently shows circular thumbnails (80px on desktop, 65px on mobile)
- Has hover animations with transform and color changes
- Horizontal scrolling with drag functionality
- Uses placeholder letters when no image is provided

## Development Preferences & Rules

### Remember Section
- **No hover animations**: User prefers to remove hover animations from thumbnails and elements
- **Portrait thumbnails**: Category thumbnails should be rectangular with portrait ratio, not circular
- **Bigger thumbnails**: Category thumbnails should be double the current width of circular ones
- **Seven categories only**: Shop by category should display only 7 main categories
- **Swiper.js preference**: Use Swiper.js for carousel implementations
- **Full-width banners**: Banners should be full viewport width and mobile-friendly
- **Auto-swipable**: Carousels should be automatically swipable

### Code Conventions
- Follow existing brown/beige color scheme (`#8B4513`, `#F5F5DC`, `#A0522D`)
- Use Liquid templating syntax for Shopify
- Maintain responsive design (mobile-first approach)
- Use BEM methodology for CSS class naming
- Preserve existing theme structure and patterns

## Tasks & Future Development

### Current Tasks (from todo.md)
- Fix added to cart notification permanent
- Add to cart from search dropdown not working  
- Auto scroll for the categories

### Future Features (from todo.md)
- Product Analytics & Rating System
- Star Ratings System (1-5 stars with metafields)
- Sales Tracking System ("pieces sold" counter)
- Product Views Analytics (view counts)
- Technical requirements using Shopify Metafields API

## Files to Work With
- **Banner**: `/theme/sections/banner-carousel.liquid` (to be replaced with Swiper.js)
- **Categories**: `/theme/sections/product-categories.liquid` (needs major updates)
- **Theme Colors**: Referenced in theme.md and css-variables.liquid
- **Assets**: Banner images and other media in `/theme/assets/`

## Category Routing System ✅ WORKING

### Main Category Collections
The system uses Shopify's built-in `/collections/` URLs that work immediately without any setup:

- **Sarees**: `/collections/sarees` → 8 subcategories
- **Lehengas**: `/collections/lehengas` → 2 subcategories  
- **Dresses**: `/collections/dresses` → 4 subcategories
- **Suits**: `/collections/suits` → 3 subcategories
- **Accessories**: `/collections/accessories` → 4 subcategories
- **Mens Wear**: `/collections/mens` → 7 subcategories
- **Mens Accessories**: `/collections/mens-accessories` → 5 subcategories

### Implementation
- **Template**: Uses existing `collection.json` template
- **Section**: Enhanced `collection.liquid` with smart category detection
- **Data Source**: Hardcoded mapping from categories.json structure in Liquid
- **Collection Links**: Subcategories link to `/collections/{handleized-name}`
- **Smart Detection**: Automatically detects main categories vs product collections

### How It Works
1. **Main Categories**: When accessing `/collections/sarees` etc., shows subcategory grid
2. **Product Collections**: When accessing actual product collections, shows products
3. **Empty Collections**: Shows "Coming Soon" message with back link
4. **No Setup Required**: Uses Shopify's built-in collection routing system

### URL Examples
```
/collections/sarees           → Shows 8 saree subcategories
/collections/silk-sarees      → Shows silk saree products (or "coming soon")
/collections/party-wear-sarees → Shows products (or "coming soon")
```

**✅ Works immediately without any Shopify admin configuration!**

## Development Notes
- Theme uses full viewport width sections with `margin-left: calc(-50vw + 50%)`
- Responsive breakpoint at 768px for mobile/desktop
- All interactive elements should be touch-friendly
- Maintain accessibility with proper alt text and semantic HTML
- **Background Commands**: Always use tmux for running background commands like Shopify theme dev server
- **Development Server Workflow**: 
  1. After making any changes to theme files, ALWAYS start the dev server to test
  2. Use tmux session in the theme directory
  3. Command: `shopify theme dev --store xvtt3i-0e.myshopify.com`
  4. When starting to edit files, stop the dev server first
  5. After editing is complete, restart the server to check for errors
  6. Fix any validation errors that appear before considering the task complete