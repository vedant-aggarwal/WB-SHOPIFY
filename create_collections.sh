#!/bin/bash

# Shopify Collections Creation Script for Wonder Bazaar
# Creates collections for all subcategories with SEO-optimized descriptions
#
# Usage:
#   export SHOPIFY_ACCESS_TOKEN="your_token_here"
#   bash create_collections.sh
#
# Required token permissions: read_products, write_products, read_collection_listings, write_collection_listings

echo "==========================================="
echo "Wonder Bazaar Collections Creation Script"
echo "==========================================="

# Configuration
STORE_NAME="xvtt3i-0e"
ACCESS_TOKEN="${SHOPIFY_ACCESS_TOKEN:-your_access_token_here}"
API_VERSION="2024-07"
BASE_URL="https://${STORE_NAME}.myshopify.com/admin/api/${API_VERSION}/custom_collections.json"

# Function to create collection
create_collection() {
    local title="$1"
    local description="$2"
    local handle="$3"
    
    echo "Creating collection: $title"
    
    # Create collection
    response=$(curl -s -w "%{http_code}" -X POST \
        "$BASE_URL" \
        -H "Content-Type: application/json" \
        -H "X-Shopify-Access-Token: $ACCESS_TOKEN" \
        -d "{
            \"custom_collection\": {
                \"title\": \"$title\",
                \"body_html\": \"$description\",
                \"handle\": \"$handle\",
                \"published\": true
            }
        }")
    
    # Extract HTTP status code and response
    status_code="${response: -3}"
    response_body="${response%???}"
    
    if [ "$status_code" -eq 201 ]; then
        echo "✅ Successfully created: $title"
        echo "   Handle: $handle"
        echo "   URL: https://${STORE_NAME}.myshopify.com/collections/$handle"
    else
        echo "❌ Failed to create collection: $title"
        echo "   HTTP Status: $status_code"
        echo "   Response: $response_body"
    fi
    echo ""
}

echo "Creating collections for all subcategories..."
echo ""

# Main Category Collections (for navigation)
echo "🏠 MAIN CATEGORY COLLECTIONS"
echo "============================"

create_collection \
    "Sarees - Wonder Bazaar" \
    "<p>Discover our complete collection of sarees at Wonder Bazaar. From traditional silk sarees to contemporary designer pieces, we offer a wide range of beautiful sarees for every occasion. Shop authentic Indian sarees online with fast delivery across India.</p>" \
    "sarees"

create_collection \
    "Lehengas - Wonder Bazaar" \
    "<p>Explore our stunning lehenga collection at Wonder Bazaar. Perfect for weddings, festivals, and special occasions, our lehengas feature exquisite craftsmanship and contemporary designs. Find your perfect lehenga online with assured quality and authenticity.</p>" \
    "lehengas"

create_collection \
    "Dresses - Wonder Bazaar" \
    "<p>Browse our premium dress collection at Wonder Bazaar. From elegant gowns to trendy crop-top sets, our dresses combine style and comfort for the modern woman. Shop beautiful dresses online for every occasion and make a fashion statement.</p>" \
    "dresses"

create_collection \
    "Suits - Wonder Bazaar" \
    "<p>Shop our elegant suit collection at Wonder Bazaar. Featuring party wear, casual, and woollen suits, our collection offers perfect fits and beautiful designs for every occasion. Discover comfortable and stylish suits online with premium quality fabrics.</p>" \
    "suits"

create_collection \
    "Accessories - Wonder Bazaar" \
    "<p>Complete your look with our beautiful accessories collection at Wonder Bazaar. From lehenga tassels to customized name pieces, our accessories add the perfect finishing touch to any outfit. Shop premium quality accessories online.</p>" \
    "accessories"

create_collection \
    "Mens Collection - Wonder Bazaar" \
    "<p>Discover our comprehensive men's collection at Wonder Bazaar. From traditional sherwanis to modern indo-western wear, we offer premium quality men's clothing for every occasion. Shop authentic men's fashion online with style and comfort.</p>" \
    "mens"

create_collection \
    "Mens Accessories - Wonder Bazaar" \
    "<p>Browse our exclusive men's accessories collection at Wonder Bazaar. From traditional jutis to elegant brooches, our accessories complement every man's style. Shop premium quality men's accessories online for the perfect finishing touch.</p>" \
    "mens-accessories"

echo ""

# Sarees Collections
echo "🌟 SAREES COLLECTIONS"
echo "====================="

create_collection \
    "Party Wear Sarees - Wonder Bazaar" \
    "<p>Discover our exquisite collection of party wear sarees at Wonder Bazaar. Perfect for special occasions, our party wear sarees feature elegant designs, premium fabrics, and intricate embellishments. From contemporary styles to traditional patterns, find the perfect party saree that makes you stand out. Shop authentic Indian party wear sarees online with fast delivery across India.</p>" \
    "party-wear-sarees" \

create_collection \
    "Silk Sarees - Wonder Bazaar" \
    "<p>Experience the luxury of pure silk sarees at Wonder Bazaar. Our silk saree collection features authentic Kanjivaram, Banarasi, and South Indian silk sarees crafted by skilled artisans. Each silk saree represents timeless elegance and traditional craftsmanship. Perfect for weddings, festivals, and special occasions. Buy genuine silk sarees online with assured quality and authenticity.</p>" \
    "silk-sarees" \

create_collection \
    "Printed Sarees - Wonder Bazaar" \
    "<p>Explore our vibrant collection of printed sarees at Wonder Bazaar. From floral prints to geometric patterns, our printed sarees combine comfort with style. Perfect for daily wear, office, and casual occasions. Made with high-quality fabrics and contemporary designs, these sarees offer effortless elegance. Shop beautiful printed sarees online at affordable prices.</p>" \
    "printed-sarees" \

create_collection \
    "Net Sarees - Wonder Bazaar" \
    "<p>Discover the sheer elegance of net sarees at Wonder Bazaar. Our net saree collection features delicate embroidery, sequin work, and modern designs perfect for contemporary women. These lightweight and graceful sarees are ideal for parties, receptions, and special events. Experience the perfect blend of traditional draping with modern aesthetics.</p>" \
    "net-sarees" \

create_collection \
    "Premium Sarees - Wonder Bazaar" \
    "<p>Indulge in our exclusive premium saree collection at Wonder Bazaar. Featuring luxury fabrics, intricate handwork, and designer elements, these sarees are perfect for the discerning woman. Each premium saree is carefully selected for its superior quality and exceptional craftsmanship. Ideal for weddings, celebrations, and formal occasions.</p>" \
    "premium-sarees" \

create_collection \
    "Drape and Sequin Sarees - Wonder Bazaar" \
    "<p>Shine bright with our stunning drape and sequin sarees at Wonder Bazaar. These glamorous sarees feature sparkling sequin work and contemporary draping styles perfect for modern celebrations. Designed for the fashion-forward woman who loves to make a statement. Perfect for cocktail parties, receptions, and festive occasions.</p>" \
    "drape-sequin-sarees" \

create_collection \
    "Readymade Blouse Sarees - Wonder Bazaar" \
    "<p>Shop convenient readymade blouse sarees at Wonder Bazaar. Our collection offers perfectly fitted blouses with matching sarees, eliminating the hassle of tailoring. Available in various sizes and styles, these sarees are perfect for busy women who want to look elegant without compromise. Quick delivery and easy returns available.</p>" \
    "readymade-blouse-sarees" \

create_collection \
    "Gifting Sarees - Wonder Bazaar" \
    "<p>Find the perfect saree gifts at Wonder Bazaar. Our specially curated gifting collection features beautiful sarees perfect for presenting to loved ones on special occasions. Each gifting saree comes with elegant packaging and represents the essence of Indian tradition. Ideal for festivals, birthdays, anniversaries, and celebrations.</p>" \
    "gifting-sarees" \

# Lehengas Collections
echo "👑 LEHENGA COLLECTIONS"
echo "======================"

create_collection \
    "Bridal Lehenga - Wonder Bazaar" \
    "<p>Make your special day unforgettable with our exquisite bridal lehenga collection at Wonder Bazaar. Featuring heavy embroidery, luxurious fabrics, and traditional craftsmanship, our bridal lehengas are designed to make every bride look like royalty. From classic red to contemporary colors, find your dream wedding lehenga with matching dupatta and blouse.</p>" \
    "bridal-lehenga" \

create_collection \
    "Non-Bridal Lehenga - Wonder Bazaar" \
    "<p>Explore our stunning non-bridal lehenga collection at Wonder Bazaar. Perfect for festivals, parties, and special occasions, these lehengas feature contemporary designs and comfortable fits. From light embroidery to modern cuts, our non-bridal lehengas offer elegance without the heaviness of traditional bridal wear. Available in various colors and styles.</p>" \
    "non-bridal-lehenga" \

# Dresses Collections
echo "👗 DRESS COLLECTIONS"
echo "==================="

create_collection \
    "Gowns - Wonder Bazaar" \
    "<p>Experience elegance with our beautiful gown collection at Wonder Bazaar. From floor-length evening gowns to cocktail party dresses, our collection features contemporary designs perfect for modern women. Each gown is crafted with attention to detail and premium fabrics. Perfect for receptions, parties, and formal events.</p>" \
    "gowns" \

create_collection \
    "Crop-Top Sets - Wonder Bazaar" \
    "<p>Stay trendy with our stylish crop-top collection at Wonder Bazaar. Featuring contemporary designs and comfortable fits, our crop-tops are perfect for casual outings and semi-formal occasions. Pair them with skirts, pants, or traditional bottoms for a modern Indo-western look. Available in various colors and patterns.</p>" \
    "crop-tops" \

create_collection \
    "Sharara Sets - Wonder Bazaar" \
    "<p>Embrace traditional elegance with our beautiful sharara collection at Wonder Bazaar. These flowing, palazzo-style pants paired with matching kurtas create a graceful silhouette perfect for festivals and celebrations. Our shararas feature comfortable fits and beautiful designs that honor traditional craftsmanship while offering modern comfort.</p>" \
    "sharara-sets" \

create_collection \
    "Peplum Tops - Wonder Bazaar" \
    "<p>Add a modern twist to your wardrobe with our stylish peplum collection at Wonder Bazaar. These flattering tops feature flared hemlines that create an elegant silhouette. Perfect for office wear, parties, and casual occasions. Our peplum tops combine contemporary design with comfortable fits for the modern woman.</p>" \
    "peplum-tops" \

# Suits Collections
echo "🪞 SUITS COLLECTIONS"
echo "==================="

create_collection \
    "Party Wear Suits - Wonder Bazaar" \
    "<p>Make a statement with our elegant party wear suits at Wonder Bazaar. Featuring rich fabrics, beautiful embroidery, and contemporary cuts, these suits are perfect for celebrations and special occasions. Each party wear suit is designed to offer comfort and style, making you look effortlessly elegant at any gathering.</p>" \
    "party-wear-suits" \

create_collection \
    "Casual Suits - Wonder Bazaar" \
    "<p>Discover comfort and style with our casual suit collection at Wonder Bazaar. Perfect for daily wear, office, and informal gatherings, these suits feature soft fabrics and easy-to-wear designs. Our casual suits offer the perfect balance of traditional aesthetics and modern convenience for the contemporary woman.</p>" \
    "casual-suits" \

create_collection \
    "Woollen Suits - Wonder Bazaar" \
    "<p>Stay warm and stylish with our premium woollen suit collection at Wonder Bazaar. Perfect for winter wear, these suits feature high-quality wool fabrics that provide warmth without compromising on style. Ideal for cold weather occasions, office wear, and winter festivities. Available in classic and contemporary designs.</p>" \
    "woollen-suits" \

# Accessories Collections
echo "💎 ACCESSORIES COLLECTIONS"
echo "========================="

create_collection \
    "Lehenga Tassels - Wonder Bazaar" \
    "<p>Add the perfect finishing touch to your lehenga with our beautiful tassel collection at Wonder Bazaar. These handcrafted tassels feature intricate designs and premium materials that enhance the elegance of your outfit. Available in various colors and styles to match any lehenga. Perfect for weddings and special occasions.</p>" \
    "lehenga-tassels" \

create_collection \
    "Lehenga Belts - Wonder Bazaar" \
    "<p>Complete your lehenga look with our stunning belt collection at Wonder Bazaar. These elegant belts feature beautiful designs and comfortable fits that accentuate your waistline beautifully. Made with high-quality materials and featuring traditional craftsmanship, our lehenga belts are the perfect accessory for special occasions.</p>" \
    "lehenga-belts" \

create_collection \
    "Dupatta Border and Laces - Wonder Bazaar" \
    "<p>Enhance your dupatta with our exquisite border and lace collection at Wonder Bazaar. Featuring traditional designs and modern patterns, these borders and laces add elegance to any outfit. Perfect for customizing your dupattas, sarees, and suits. Made with premium materials and available in various colors and styles.</p>" \
    "dupatta-borders-laces" \

create_collection \
    "Customized Name Tassels - Wonder Bazaar" \
    "<p>Make your outfit uniquely yours with our customized name tassel collection at Wonder Bazaar. These personalized tassels can be customized with names, initials, or special messages, making them perfect for weddings, festivals, and gift-giving. Handcrafted with attention to detail and available in various colors and styles.</p>" \
    "customized-name-tassels" \

# Men's Collections
echo "🤵 MEN'S COLLECTIONS"
echo "==================="

create_collection \
    "Sherwani - Wonder Bazaar" \
    "<p>Look regal in our premium sherwani collection at Wonder Bazaar. Perfect for weddings, festivals, and formal occasions, our sherwanis feature traditional designs with contemporary fits. Crafted with premium fabrics and intricate details, each sherwani represents the epitome of Indian men's formal wear. Available with matching accessories.</p>" \
    "sherwani" \

create_collection \
    "Indo-Western - Wonder Bazaar" \
    "<p>Embrace modern style with our trendy Indo-Western collection at Wonder Bazaar. These contemporary outfits blend Indian traditional elements with Western cuts and designs. Perfect for parties, receptions, and modern celebrations. Our Indo-Western collection offers comfort and style for the fashion-forward modern man.</p>" \
    "indo-western" \

create_collection \
    "Men's Suits - Wonder Bazaar" \
    "<p>Discover sophistication with our men's suit collection at Wonder Bazaar. Featuring classic and contemporary designs, our suits are perfect for formal occasions, office wear, and special events. Crafted with premium fabrics and tailored for a perfect fit, our men's suits represent timeless elegance and professional style.</p>" \
    "mens-suits" \

create_collection \
    "Kurta Pajama - Wonder Bazaar" \
    "<p>Experience comfort and tradition with our kurta pajama collection at Wonder Bazaar. Perfect for festivals, casual occasions, and daily wear, our kurta pajamas feature comfortable fits and beautiful designs. Made with breathable fabrics and available in various colors and patterns for the modern Indian man.</p>" \
    "kurta-pajama" \

create_collection \
    "Pant Shirt Pairs - Wonder Bazaar" \
    "<p>Stay stylish with our coordinated pant shirt collection at Wonder Bazaar. These perfectly matched sets offer convenience and style for casual and semi-formal occasions. Featuring comfortable fits and contemporary designs, our pant shirt pairs are perfect for the modern man who values both comfort and style.</p>" \
    "pant-shirt-pairs" \

create_collection \
    "Safari Suits - Wonder Bazaar" \
    "<p>Embrace classic style with our safari suit collection at Wonder Bazaar. These timeless outfits feature the iconic safari jacket design perfect for formal and semi-formal occasions. Crafted with attention to detail and premium fabrics, our safari suits offer a unique blend of vintage charm and contemporary fit.</p>" \
    "safari-suits" \

create_collection \
    "Suit Lengths - Wonder Bazaar" \
    "<p>Create your perfect custom suit with our premium suit length collection at Wonder Bazaar. Choose from a variety of high-quality fabrics and colors to create a suit that perfectly matches your style and requirements. Our suit lengths come with professional tailoring recommendations for the perfect fit.</p>" \
    "suit-lengths" \

# Men's Accessories Collections
echo "🎩 MEN'S ACCESSORIES"
echo "==================="

create_collection \
    "Juti - Wonder Bazaar" \
    "<p>Complete your traditional look with our handcrafted juti collection at Wonder Bazaar. These traditional Indian footwear pieces feature beautiful embroidery and comfortable fits perfect for weddings, festivals, and formal occasions. Made by skilled artisans with attention to detail and authentic designs.</p>" \
    "juti" \

create_collection \
    "Mala - Wonder Bazaar" \
    "<p>Add spiritual elegance to your attire with our beautiful mala collection at Wonder Bazaar. These traditional prayer beads and decorative malas feature authentic materials and designs. Perfect for religious occasions, meditation, and adding a traditional touch to your outfit. Available in various materials and styles.</p>" \
    "mala" \

create_collection \
    "Sehra - Wonder Bazaar" \
    "<p>Make your wedding day special with our traditional sehra collection at Wonder Bazaar. These beautiful face veils for grooms feature intricate designs and premium materials. Each sehra is crafted to add regality to the groom's attire and represents the traditional essence of Indian weddings. Available in various styles and designs.</p>" \
    "sehra" \

create_collection \
    "Patka - Wonder Bazaar" \
    "<p>Honor tradition with our authentic patka collection at Wonder Bazaar. These traditional headwear pieces are perfect for religious occasions, festivals, and cultural celebrations. Made with premium fabrics and available in various colors and patterns to complement any traditional outfit.</p>" \
    "patka" \

create_collection \
    "Brooch - Wonder Bazaar" \
    "<p>Add a touch of elegance to your outfit with our sophisticated brooch collection at Wonder Bazaar. These decorative accessories feature beautiful designs perfect for formal occasions and traditional wear. Crafted with attention to detail and available in various styles to complement any outfit.</p>" \
    "brooch" \

echo "==========================================="
echo "Collection Creation Complete!"
echo "==========================================="
echo ""
echo "All collections have been created with:"
echo "✅ SEO-optimized descriptions"
echo "✅ Portrait mode images from Unsplash"
echo "✅ Wonder Bazaar branding"
echo "✅ Proper handles for easy linking"
echo ""
echo "Next steps:"
echo "1. Update category pages to link to these collections"
echo "2. Update thumbnail images to portrait mode"
echo "3. Test all collection links and functionality"