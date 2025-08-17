# Collection Setup Guide for Wonder Bazaar

## Token Permission Issue Resolution

The provided access token doesn't have the required permissions for creating collections. Here's how to fix this:

### Step 1: Update Access Token Permissions

1. **Go to Shopify Admin**: https://xvtt3i-0e.myshopify.com/admin
2. **Navigate to**: Settings > Apps and sales channels > Develop apps
3. **Find your app** or **Create a new app** with these permissions:
   - `read_products` - Required to read collections
   - `write_products` - Required to create collections
   - `read_content` - Required to read pages
   - `write_content` - Required to create pages

4. **Install the app** and copy the new access token

### Step 2: Run Collection Creation Script

Once you have the correct token:

```bash
# Update the token in the script
export NEW_ACCESS_TOKEN="your_new_token_here"

# Edit the script to use new token
sed -i 's/your_access_token_here/'"$NEW_ACCESS_TOKEN"'/g' create_collections.sh

# Run the script
./create_collections.sh
```

## Manual Collection Creation (Alternative)

If you prefer to create collections manually through Shopify admin:

### Sarees Collections

1. **Party Wear Sarees**
   - Title: `Party Wear Sarees - Wonder Bazaar`
   - Handle: `party-wear-sarees`
   - Description: SEO-optimized content (see script)
   - Image: Portrait mode image from Unsplash

2. **Silk Sarees**
   - Title: `Silk Sarees - Wonder Bazaar`
   - Handle: `silk-sarees`
   - Description: SEO-optimized content
   - Image: Portrait mode silk saree image

[Continue for all 33 collections as defined in the script]

## Collection URLs After Creation

Once created, collections will be accessible at:

**Sarees:**
- `/collections/party-wear-sarees`
- `/collections/silk-sarees`
- `/collections/printed-sarees`
- `/collections/net-sarees`
- `/collections/premium-sarees`
- `/collections/drape-sequin-sarees`
- `/collections/readymade-blouse-sarees`
- `/collections/gifting-sarees`

**Lehengas:**
- `/collections/bridal-lehenga`
- `/collections/non-bridal-lehenga`

**Dresses:**
- `/collections/gowns`
- `/collections/crop-tops`
- `/collections/sharara-sets`
- `/collections/peplum-tops`

**Suits:**
- `/collections/party-wear-suits`
- `/collections/casual-suits`
- `/collections/woollen-suits`

**Accessories:**
- `/collections/lehenga-tassels`
- `/collections/lehenga-belts`
- `/collections/dupatta-borders-laces`
- `/collections/customized-name-tassels`

**Men's Collection:**
- `/collections/sherwani`
- `/collections/indo-western`
- `/collections/mens-suits`
- `/collections/kurta-pajama`
- `/collections/pant-shirt-pairs`
- `/collections/safari-suits`
- `/collections/suit-lengths`

**Men's Accessories:**
- `/collections/juti`
- `/collections/mala`
- `/collections/sehra`
- `/collections/patka`
- `/collections/brooch`

## Image Requirements

All collection images should be:
- **Portrait mode**: 400x600 pixels (2:3 aspect ratio)
- **High quality**: Clear, professional product photos
- **Consistent style**: Similar lighting and background
- **SEO optimized**: Proper alt text with collection name

## SEO Benefits

Each collection description includes:
- **Brand name**: Wonder Bazaar prominently featured
- **Keywords**: Relevant search terms for Google ranking
- **Benefits**: Customer-focused benefits and features
- **Location**: New Delhi mentioned for local SEO
- **Call-to-action**: Purchase encouragement phrases

## Next Steps After Collection Creation

1. **Update Category Pages**: Modify category pages to link to collections instead of search
2. **Add Products**: Populate collections with actual products
3. **Test Navigation**: Verify all links work correctly
4. **SEO Optimization**: Add meta descriptions and optimize titles
5. **Image Optimization**: Ensure all images are properly sized and optimized

## Integration with Category Pages

The category pages will be updated to:
- Display portrait thumbnails (400x600)
- Link directly to collection URLs
- Show collection images as thumbnails
- Maintain responsive design

## Error Resolution

**If you get 406 errors:**
- Check token permissions include `write_products`
- Verify API endpoint is correct
- Ensure store URL format is correct

**If collections don't appear:**
- Check they are published
- Verify handles are unique
- Ensure images uploaded correctly

**If thumbnails don't show:**
- Verify image URLs are accessible
- Check image format (JPEG/PNG)
- Ensure proper aspect ratio (2:3 portrait)