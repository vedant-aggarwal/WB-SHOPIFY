# WB-SHOPIFY Page Creation Guide

## Overview
This guide explains how to create pages for our custom templates and make them fully functional in your Shopify store.

## Current Status
✅ **Completed:**
- Custom page templates created and customizable
- Category navigation templates with editable settings
- Template files pushed to Shopify

❌ **Still Needed:**
- Create actual pages that use these templates
- Assign URLs and handles to pages
- Configure page content through admin

## Step-by-Step Instructions

### Method 1: Using the Automated Script (Recommended)

1. **Get Shopify Access Token:**
   - Go to your Shopify admin: https://xvtt3i-0e.myshopify.com/admin
   - Navigate to **Settings > Apps and sales channels**
   - Click **"Develop apps"** (bottom of page)
   - Click **"Create an app"**
   - Name it "Page Creator" or similar
   - Go to **"Configuration" tab**
   - Under **Admin API access scopes**, search for and enable:
     - `write_content` (to create pages)
     - `read_content` (to read page data)
   - Click **"Save"**
   - Go to **API credentials** tab and **"Install app"**
   - Copy the **Admin API access token**

2. **Run the Script:**
   ```bash
   # Navigate to project directory
   cd /mnt/c/Users/Administrator/Desktop/WB-SHOPIFY/WB-SHOPIFY

   # Set your access token
   export SHOPIFY_ACCESS_TOKEN='your_token_here'

   # Run the script
   ./create_pages.sh
   ```

3. **Verify Pages Created:**
   - Check your Shopify admin: **Online Store > Pages**
   - You should see new pages created with correct templates

### Method 2: Manual Creation through Shopify Admin

If you prefer to create pages manually:

1. **Go to Shopify Admin:**
   - Navigate to **Online Store > Pages**
   - Click **"Add page"**

2. **Create Each Category Page:**
   
   **For Sarees Category:**
   - Title: `Designer Saree Collection Shop Now`
   - Handle: `categories-sarees`
   - Template: `page.categories-sarees`
   - Content: Basic description (will be overridden by template)

   **Repeat for other categories:**
   - Lehengas: `categories-lehengas` → `page.categories-lehengas`
   - Dresses: `categories-dresses` → `page.categories-dresses`
   - Suits: `categories-suits` → `page.categories-suits`
   - Accessories: `categories-accessories` → `page.categories-accessories`
   - Mens: `categories-mens` → `page.categories-mens`
   - Mens Accessories: `categories-mens-accessories` → `page.categories-mens-accessories`

3. **Create Policy Pages:**
   - About Us: `about-us` → `page.about-us`
   - Privacy Policy: `privacy-policy` → `page.privacy-policy`
   - Shipping Policy: `shipping-policy` → `page.shipping-policy`
   - Refund Policy: `refund-and-exchange-policy` → `page.refund-and-exchange-policy`
   - Terms: `terms-and-conditions` → `page.terms-and-conditions`

## Template Customization

### After Pages Are Created:

1. **Navigate to Theme Customizer:**
   - **Online Store > Themes > Customize**
   - Browse to any of your new pages

2. **Edit Page Content:**
   - Each template has customizable settings:
     - **Page Title**: Change the main heading
     - **Page Description**: Update subtitle/description
     - **Page Content**: Full HTML content (for policy pages)
     - **Subcategories List**: Comma-separated items (for category pages)

3. **Category Page Settings Example:**
   ```
   Page Title: "Premium Saree Collection"
   Page Description: "Discover our handpicked saree designs"
   Subcategories: "Silk Sarees,Cotton Sarees,Designer Sarees,Wedding Sarees"
   ```

## URL Structure

After creation, your pages will be accessible at:

**Category Pages:**
- https://xvtt3i-0e.myshopify.com/pages/categories-sarees
- https://xvtt3i-0e.myshopify.com/pages/categories-lehengas
- https://xvtt3i-0e.myshopify.com/pages/categories-dresses
- https://xvtt3i-0e.myshopify.com/pages/categories-suits
- https://xvtt3i-0e.myshopify.com/pages/categories-accessories
- https://xvtt3i-0e.myshopify.com/pages/categories-mens
- https://xvtt3i-0e.myshopify.com/pages/categories-mens-accessories

**Policy Pages:**
- https://xvtt3i-0e.myshopify.com/pages/about-us
- https://xvtt3i-0e.myshopify.com/pages/privacy-policy
- https://xvtt3i-0e.myshopify.com/pages/shipping-policy
- https://xvtt3i-0e.myshopify.com/pages/refund-and-exchange-policy
- https://xvtt3i-0e.myshopify.com/pages/terms-and-conditions

## Updating Navigation

### Update Main Menu:
1. **Go to Navigation:**
   - **Online Store > Navigation > Main menu**
   
2. **Add Category Links:**
   - Add menu items linking to your category pages
   - Use meaningful names like "Shop Sarees", "Lehengas", etc.

3. **Add Footer Links:**
   - **Footer menu**: Add policy page links
   - Include About Us, Privacy Policy, Terms, etc.

## Testing the Integration

### Test Category Navigation:
1. **Visit Homepage**: Verify category thumbnails link correctly
2. **Click Category**: Should show subcategory grid
3. **Click Subcategory**: Should show search results
4. **Check Mobile**: Ensure responsive design works

### Test Policy Pages:
1. **Visit Each Page**: Verify templates load correctly
2. **Check Customization**: Test admin editing works
3. **Verify Styling**: Ensure consistent theme appearance

## Troubleshooting

### Common Issues:

**"Template not found" error:**
- Verify template files exist in theme
- Check template assignment in page settings
- Ensure template names match exactly

**Pages not showing custom content:**
- Check theme customizer settings
- Verify template uses settings correctly
- Ensure page is published

**404 errors:**
- Verify page handles are correct
- Check page is published and visible
- Confirm URL structure matches handle

### Debug Steps:
1. Check theme file structure matches template references
2. Verify all templates are properly uploaded to Shopify
3. Test template customizer settings
4. Check page publish status and visibility

## Next Steps After Page Creation

1. **Content Population:**
   - Add actual product content to subcategories
   - Upload category images/banners
   - Write detailed policy content

2. **SEO Optimization:**
   - Add meta descriptions to pages
   - Configure page titles for SEO
   - Set up proper heading structure

3. **Analytics Setup:**
   - Track page visits and user flow
   - Monitor category page performance
   - Set up conversion tracking

4. **Testing:**
   - Test all page links and navigation
   - Verify mobile responsiveness
   - Check page load speeds

## Files Reference

- **Script**: `create_pages.sh` - Automated page creation
- **Research**: `SHOPIFY_CLI_GRAPHQL_RESEARCH.md` - Technical details
- **Templates**: `/theme/templates/page.*.json` - Page template assignments
- **Sections**: `/theme/sections/*-page.liquid` - Customizable page sections
- **Categories**: `/theme/sections/*-cat.liquid` - Category page sections

---

**Important Notes:**
- Pages must be created manually or via API (not through GraphQL yet)
- Templates are already customizable through admin interface
- All styling and responsive design is pre-configured
- Content can be edited without touching code

**Need Help?**
- Check `SHOPIFY_CLI_GRAPHQL_RESEARCH.md` for technical details
- Review Shopify's REST API documentation for advanced customization
- Test with staging store first before making live changes