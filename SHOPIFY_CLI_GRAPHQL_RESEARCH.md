# Shopify CLI GraphQL Research & Page Creation Guide

## Overview
This document provides comprehensive research on using Shopify CLI's GraphQL capabilities and alternative methods for creating pages in 2025.

## Key Findings

### GraphQL vs REST API in 2025
- **REST API Status**: Being deprecated - marked as legacy effective April 1, 2025
- **New App Requirement**: All new apps submitted to Shopify App Store after April 1, 2025 must use GraphQL
- **Existing Apps**: Can continue using REST Admin API (no changes required)
- **Future Direction**: GraphQL is now the primary API, offering a true superset of REST functionality

### Shopify CLI GraphQL Integration

#### Accessing GraphiQL
- **Launch Method**: While running `shopify app dev`, press `g` key to launch GraphiQL
- **Requirements**: Shopify CLI version 3.74.0 or higher
- **Built-in Explorer**: Direct access to GraphQL explorer within development environment

#### GraphiQL Features
- **Query Builder**: Use checkboxes and fields to build GraphQL queries
- **Documentation Explorer**: Searchable schema descriptions and supported fields
- **Real-time Testing**: Write, validate, and test GraphQL queries in-browser
- **Error Handling**: Built-in validation and error reporting

### 2025 API Endpoints
- **GraphQL**: `https://{store_name}.myshopify.com/admin/api/2025-07/graphql.json`
- **REST**: `https://{store_name}.myshopify.com/admin/api/2025-07/{resource}.json`

## Page Creation - Current Limitations

### GraphQL Limitations for Pages
**IMPORTANT**: The Shopify GraphQL Admin API currently does NOT support:
- Creating pages
- Modifying pages
- Creating assets
- Creating themes

**Reason**: These operations still require the REST Admin API

### Alternative Approaches

#### 1. REST API for Page Creation
Since GraphQL doesn't support page creation, use REST API:

```bash
curl -X POST \
  https://{store_name}.myshopify.com/admin/api/2025-07/pages.json \
  -H 'Content-Type: application/json' \
  -H 'X-Shopify-Access-Token: {access_token}' \
  -d '{
    "page": {
      "title": "Your Page Title",
      "body_html": "<p>Your page content</p>",
      "template_suffix": "custom-template",
      "handle": "custom-page-handle"
    }
  }'
```

#### 2. Shopify CLI Commands
Check if Shopify CLI has built-in page creation commands:
```bash
shopify app --help
shopify theme --help
```

## Implementation Strategy for Our Project

### Current Challenge
We have created page templates but need to:
1. Create actual pages that use these templates
2. Assign proper URLs and handles
3. Configure metaobjects if needed

### Recommended Approach

#### Step 1: Use REST API for Page Creation
Create pages programmatically using REST API:

```javascript
// Example: Create category pages using REST API
const pages = [
  {
    title: "Sarees Category",
    body_html: "<p>Explore our saree collection</p>",
    template_suffix: "categories-sarees",
    handle: "categories-sarees"
  },
  {
    title: "Lehengas Category", 
    body_html: "<p>Discover our lehenga collection</p>",
    template_suffix: "categories-lehengas",
    handle: "categories-lehengas"
  }
  // ... other category pages
];

// Use fetch or curl to create each page
```

#### Step 2: Template Assignment
- Use `template_suffix` field to assign our custom templates
- Templates: `page.categories-sarees.json`, `page.categories-lehengas.json`, etc.

#### Step 3: URL Structure
Pages will be accessible at:
- `/pages/categories-sarees`
- `/pages/categories-lehengas`
- `/pages/categories-dresses`
- etc.

### Page Creation Script Structure

```bash
#!/bin/bash
# Create category pages using REST API

STORE_NAME="xvtt3i-0e"
ACCESS_TOKEN="your_access_token"
API_VERSION="2025-07"
BASE_URL="https://${STORE_NAME}.myshopify.com/admin/api/${API_VERSION}/pages.json"

# Category pages data
declare -A PAGES=(
  ["sarees"]="Designer Saree Collection Shop Now"
  ["lehengas"]="Exclusive Lehenga Collection Shop Now"
  ["dresses"]="Premium Dress Collection Shop Now"
  ["suits"]="Fancy Suits Collection Shop Now"
  ["accessories"]="Clothing Accessories"
  ["mens"]="Mens Collection"
  ["mens-accessories"]="Mens Accessories"
)

for handle in "${!PAGES[@]}"; do
  curl -X POST \
    "$BASE_URL" \
    -H "Content-Type: application/json" \
    -H "X-Shopify-Access-Token: $ACCESS_TOKEN" \
    -d "{
      \"page\": {
        \"title\": \"${PAGES[$handle]}\",
        \"body_html\": \"<p>Explore our ${handle} collection</p>\",
        \"template_suffix\": \"categories-${handle}\",
        \"handle\": \"categories-${handle}\"
      }
    }"
done
```

## Best Practices

### GraphQL Best Practices
1. **Test with GraphiQL**: Always test queries before implementation
2. **Handle Errors**: Check for `userErrors` in mutation responses
3. **Optimize Queries**: Fetch only required fields
4. **Use Fragments**: Reuse common field sets

### REST API Best Practices
1. **Authentication**: Use proper access tokens
2. **Rate Limiting**: Respect Shopify's API limits
3. **Error Handling**: Check HTTP status codes and response body
4. **Versioning**: Use latest API version (2025-07)

### CLI Integration
1. **Version Control**: Keep CLI updated (3.74.0+)
2. **Environment Management**: Use proper store configurations
3. **Development Workflow**: Leverage built-in GraphiQL for testing

## Next Steps

1. **Get Access Token**: Generate private app access token with pages write permissions
2. **Test API Calls**: Use curl or GraphiQL to test page creation
3. **Batch Creation**: Create all category pages programmatically
4. **Verify Templates**: Ensure templates are properly assigned and working
5. **Test Navigation**: Verify all page links work correctly

## Resources

- [GraphQL Admin API Reference](https://shopify.dev/docs/api/admin-graphql)
- [REST Admin API Reference](https://shopify.dev/docs/api/admin-rest)
- [GraphiQL for Admin API](https://shopify.dev/docs/api/usage/api-exploration/admin-graphiql-explorer)
- [Shopify CLI Documentation](https://shopify.dev/themes/tools/cli)

## Important Notes

- **Migration Timeline**: Plan GraphQL migration before April 2025 for new apps
- **API Limitations**: Pages, assets, themes still require REST API
- **Template Suffix**: Must match exactly with template file names
- **Handle Uniqueness**: Page handles must be unique across the store
- **Permissions**: Ensure access token has proper page management permissions

---

*Research compiled: August 2025*
*Last updated: Current development session*