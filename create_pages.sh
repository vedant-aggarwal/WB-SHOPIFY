#!/bin/bash

# Shopify Page Creation Script
# This script creates pages for category templates using Shopify REST API

echo "==========================================="
echo "Shopify Category Pages Creation Script"
echo "==========================================="

# Configuration
STORE_NAME="xvtt3i-0e"
API_VERSION="2025-07"
BASE_URL="https://${STORE_NAME}.myshopify.com/admin/api/${API_VERSION}/pages.json"

# Check if access token is provided
if [ -z "$SHOPIFY_ACCESS_TOKEN" ]; then
    echo "❌ Error: SHOPIFY_ACCESS_TOKEN environment variable is not set"
    echo ""
    echo "To get an access token:"
    echo "1. Go to your Shopify admin: https://${STORE_NAME}.myshopify.com/admin"
    echo "2. Navigate to Settings > Apps and sales channels"
    echo "3. Click 'Develop apps' > 'Create an app'"
    echo "4. Configure API scopes (need 'write_content' permission for pages)"
    echo "5. Install the app and copy the access token"
    echo ""
    echo "Then run: export SHOPIFY_ACCESS_TOKEN='your_token_here'"
    echo "And run this script again"
    exit 1
fi

# Category pages configuration
declare -A PAGES=(
    ["sarees"]="Designer Saree Collection Shop Now|Explore our premium saree collection with various styles and designs."
    ["lehengas"]="Exclusive Lehenga Collection Shop Now|Discover our exquisite lehenga collection for special occasions."
    ["dresses"]="Premium Dress Collection Shop Now|Browse our elegant dress collection for every occasion."
    ["suits"]="Fancy Suits Collection Shop Now|Shop our stylish suits collection with contemporary designs."
    ["accessories"]="Clothing Accessories|Find the perfect accessories to complement your outfits."
    ["mens"]="Mens Collection|Explore our comprehensive mens fashion collection."
    ["mens-accessories"]="Mens Accessories|Complete your look with our mens accessories range."
)

echo "Creating category pages..."
echo ""

# Function to create a page
create_page() {
    local handle=$1
    local title=$2
    local description=$3
    
    echo "Creating page: $title"
    
    response=$(curl -s -w "%{http_code}" -X POST \
        "$BASE_URL" \
        -H "Content-Type: application/json" \
        -H "X-Shopify-Access-Token: $SHOPIFY_ACCESS_TOKEN" \
        -d "{
            \"page\": {
                \"title\": \"$title\",
                \"body_html\": \"<p>$description</p>\",
                \"template_suffix\": \"categories-${handle}\",
                \"handle\": \"categories-${handle}\",
                \"published\": true
            }
        }")
    
    # Extract HTTP status code (last 3 characters)
    status_code="${response: -3}"
    # Extract response body (all but last 3 characters)  
    response_body="${response%???}"
    
    if [ "$status_code" -eq 201 ]; then
        echo "✅ Successfully created: /pages/categories-${handle}"
    else
        echo "❌ Failed to create page for $handle"
        echo "   HTTP Status: $status_code"
        echo "   Response: $response_body"
    fi
    echo ""
}

# Create policy pages as well
declare -A POLICY_PAGES=(
    ["about-us"]="About Us|Learn more about our company and values."
    ["privacy-policy"]="Privacy Policy|Read our privacy policy and data handling practices."
    ["shipping-policy"]="Shipping Policy|Information about our shipping methods and policies."
    ["refund-and-exchange-policy"]="Refund and Exchange Policy|Details about our return and exchange procedures."
    ["terms-and-conditions"]="Terms and Conditions|Read our terms of service and conditions."
)

# Create category pages
echo "1. Creating Category Pages:"
echo "=========================="
for handle in "${!PAGES[@]}"; do
    IFS='|' read -r title description <<< "${PAGES[$handle]}"
    create_page "$handle" "$title" "$description"
done

# Create policy pages
echo "2. Creating Policy Pages:"
echo "========================"
for handle in "${!POLICY_PAGES[@]}"; do
    IFS='|' read -r title description <<< "${POLICY_PAGES[$handle]}"
    create_page "$handle" "$title" "$description"
done

echo "==========================================="
echo "Page Creation Complete!"
echo "==========================================="
echo ""
echo "Created Pages:"
echo "Category Pages:"
for handle in "${!PAGES[@]}"; do
    echo "  📄 https://${STORE_NAME}.myshopify.com/pages/categories-${handle}"
done

echo ""
echo "Policy Pages:"
for handle in "${!POLICY_PAGES[@]}"; do
    echo "  📄 https://${STORE_NAME}.myshopify.com/pages/${handle}"
done

echo ""
echo "Next Steps:"
echo "1. Visit your Shopify admin to verify pages were created"
echo "2. Check that templates are properly assigned"
echo "3. Customize page content through the admin interface"
echo "4. Update navigation menus to include new pages"

echo ""
echo "Note: Pages are created with basic content and assigned to custom templates."
echo "You can edit the content through Shopify admin > Online Store > Pages"