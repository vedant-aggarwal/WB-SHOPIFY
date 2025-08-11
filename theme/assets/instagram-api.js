/**
 * Instagram Graph API Integration for Shopify (2025)
 * Handles fetching reels from Instagram using the modern Graph API
 * Note: Instagram Basic Display API was deprecated in December 2024
 */

class InstagramAPI {
  constructor() {
    this.baseURL = 'https://graph.instagram.com';
    this.apiVersion = 'v18.0'; // Latest stable version as of 2025
    this.username = 'wonder.bazaar';
    this.accessToken = null; // Set this in theme settings
    this.cachedData = null;
    this.cacheExpiry = null;
    this.cacheMinutes = 30; // Cache for 30 minutes
    this.rateLimitCount = 0;
    this.rateLimitReset = 0;
  }

  /**
   * Initialize with access token from theme settings
   */
  init(accessToken) {
    this.accessToken = accessToken;
  }

  /**
   * Check rate limits and handle gracefully
   */
  checkRateLimit() {
    const now = Date.now();
    if (this.rateLimitReset > now) {
      const waitTime = Math.ceil((this.rateLimitReset - now) / 1000);
      console.warn(`Instagram API rate limit reached. Wait ${waitTime} seconds.`);
      return false;
    }
    return true;
  }

  /**
   * Make authenticated request with rate limiting and error handling
   */
  async makeRequest(endpoint, fields = '') {
    if (!this.checkRateLimit()) {
      throw new Error('Rate limit exceeded');
    }

    const url = `${this.baseURL}/${this.apiVersion}/${endpoint}?fields=${fields}&access_token=${this.accessToken}`;
    
    const response = await fetch(url, {
      method: 'GET',
      headers: {
        'Accept': 'application/json',
      }
    });

    // Handle rate limiting
    const remaining = response.headers.get('X-App-Usage');
    if (remaining) {
      try {
        const usage = JSON.parse(remaining);
        if (usage.call_count >= 95) { // Near limit
          this.rateLimitReset = Date.now() + (60 * 60 * 1000); // 1 hour
        }
      } catch (e) {
        console.warn('Could not parse rate limit headers');
      }
    }

    if (!response.ok) {
      const errorData = await response.json().catch(() => null);
      throw new Error(`API Error: ${response.status} ${errorData?.error?.message || response.statusText}`);
    }

    return response.json();
  }

  /**
   * Fetch user media (reels/videos) using Instagram Graph API v18.0+
   */
  async fetchUserMedia() {
    // Check cache first
    if (this.cachedData && this.cacheExpiry && Date.now() < this.cacheExpiry) {
      return this.cachedData;
    }

    try {
      if (!this.accessToken) {
        console.warn('Instagram Graph API access token not configured. Using mock data.');
        return this.getMockData();
      }

      // Fetch user info first (Graph API 2025 requirement)
      const userData = await this.makeRequest('me', 'id,username,account_type');
      
      // Verify this is a business account (required for Graph API media access)
      if (userData.account_type !== 'BUSINESS') {
        console.warn('Instagram account must be a Business account for Graph API access');
        return this.getMockData();
      }
      
      // Fetch user media with enhanced fields for 2025
      const mediaFields = [
        'id',
        'media_type',
        'media_url',
        'thumbnail_url',
        'caption',
        'like_count',
        'comments_count',
        'permalink',
        'timestamp',
        'insights.metric(impressions,reach,video_views)'
      ].join(',');
      
      const mediaData = await this.makeRequest(`${userData.id}/media`, mediaFields);
      
      // Filter for reels and videos (2025 update: prioritize reels)
      const videos = mediaData.data.filter(item => {
        // Prioritize Instagram Reels over regular videos
        return item.media_type === 'VIDEO' || 
               item.media_type === 'REELS' || 
               item.media_type === 'CAROUSEL_ALBUM';
      });
      
      // Transform data for our component with enhanced 2025 features
      const transformedData = await Promise.all(videos.map(async (video) => {
        const productData = await this.getProductsForVideo(video.id);
        const insights = video.insights?.data || [];
        
        return {
          id: video.id,
          thumbnail: video.thumbnail_url || video.media_url,
          video_url: video.media_url,
          caption: video.caption || '',
          likes: video.like_count || 0,
          comments: video.comments_count || 0,
          permalink: video.permalink,
          timestamp: video.timestamp,
          views: this.getInsightValue(insights, 'video_views') || 0,
          impressions: this.getInsightValue(insights, 'impressions') || 0,
          reach: this.getInsightValue(insights, 'reach') || 0,
          products: productData,
          isPinned: await this.isPinnedVideo(video.id),
          hasProducts: productData.length > 0,
          createdAt: video.timestamp ? new Date(video.timestamp).toISOString().split('T')[0] : new Date().toISOString().split('T')[0]
        };
      }));
      
      // Sort by custom algorithm: pinned first, then by engagement
      const sortedData = transformedData.sort((a, b) => {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        if (a.hasProducts && !b.hasProducts) return -1;
        if (!a.hasProducts && b.hasProducts) return 1;
        
        // Sort by engagement score (likes + comments + views/10)
        const engagementA = a.likes + a.comments + (a.views / 10);
        const engagementB = b.likes + b.comments + (b.views / 10);
        return engagementB - engagementA;
      });
      
      // Cache the data
      this.cachedData = sortedData;
      this.cacheExpiry = Date.now() + (this.cacheMinutes * 60 * 1000);
      
      return sortedData;
      
    } catch (error) {
      console.error('Instagram Graph API Error:', error);
      return this.getMockData();
    }
  }

  /**
   * Extract insight value from Instagram insights data
   */
  getInsightValue(insights, metric) {
    const insight = insights.find(i => i.name === metric);
    return insight?.values?.[0]?.value || 0;
  }

  /**
   * Get products associated with a specific video (async for 2025 compatibility)
   * This would typically query Shopify metafields or a custom database
   */
  async getProductsForVideo(videoId) {
    try {
      // First check localStorage (for admin interface)
      const productAssociations = this.getStoredProductAssociations();
      
      // In a real implementation, you would also check Shopify metafields:
      // const response = await fetch('/apps/instagram-integration/api/video-products/' + videoId);
      // const serverAssociations = await response.json();
      
      return productAssociations[videoId] || [];
    } catch (error) {
      console.error('Error fetching products for video:', error);
      return [];
    }
  }

  /**
   * Check if a video is pinned by admin (async for 2025 compatibility)
   */
  async isPinnedVideo(videoId) {
    try {
      const pinnedVideos = this.getStoredPinnedVideos();
      
      // In a real implementation, you would also check Shopify metafields:
      // const response = await fetch('/apps/instagram-integration/api/pinned-videos');
      // const serverPinned = await response.json();
      
      return pinnedVideos.includes(videoId);
    } catch (error) {
      console.error('Error checking pinned status:', error);
      return false;
    }
  }

  /**
   * Get stored product associations from Shopify metafields or localStorage
   */
  getStoredProductAssociations() {
    try {
      const stored = localStorage.getItem('instagram_product_associations');
      return stored ? JSON.parse(stored) : {};
    } catch (error) {
      console.error('Error reading product associations:', error);
      return {};
    }
  }

  /**
   * Get stored pinned videos from Shopify metafields or localStorage
   */
  getStoredPinnedVideos() {
    try {
      const stored = localStorage.getItem('instagram_pinned_videos');
      return stored ? JSON.parse(stored) : [];
    } catch (error) {
      console.error('Error reading pinned videos:', error);
      return [];
    }
  }

  /**
   * Store product associations (admin function)
   */
  storeProductAssociation(videoId, products) {
    try {
      const associations = this.getStoredProductAssociations();
      associations[videoId] = products;
      localStorage.setItem('instagram_product_associations', JSON.stringify(associations));
      
      // Also clear cache to force refresh
      this.cachedData = null;
      this.cacheExpiry = null;
      
      return true;
    } catch (error) {
      console.error('Error storing product association:', error);
      return false;
    }
  }

  /**
   * Pin/unpin a video (admin function)
   */
  togglePinnedVideo(videoId) {
    try {
      const pinnedVideos = this.getStoredPinnedVideos();
      const index = pinnedVideos.indexOf(videoId);
      
      if (index > -1) {
        pinnedVideos.splice(index, 1); // Remove if already pinned
      } else {
        pinnedVideos.push(videoId); // Add if not pinned
      }
      
      localStorage.setItem('instagram_pinned_videos', JSON.stringify(pinnedVideos));
      
      // Clear cache to force refresh
      this.cachedData = null;
      this.cacheExpiry = null;
      
      return pinnedVideos.includes(videoId);
    } catch (error) {
      console.error('Error toggling pinned video:', error);
      return false;
    }
  }

  /**
   * Mock data for development/fallback
   */
  getMockData() {
    return [
      {
        id: 'mock_1',
        thumbnail: 'https://via.placeholder.com/300x533/8B4513/FFFFFF?text=Saree+Collection',
        video_url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        caption: 'Beautiful traditional saree collection for festive occasions 🎉 #SareeCollection #TraditionalWear',
        likes: 1250,
        permalink: 'https://instagram.com/p/mock1',
        products: [
          { 
            id: 'saree_1', 
            title: 'Red Silk Saree', 
            price: '₹12,999', 
            image: 'https://via.placeholder.com/60x60/FF0000/FFFFFF?text=Saree',
            url: '/products/red-silk-saree'
          },
          { 
            id: 'blouse_1', 
            title: 'Golden Blouse', 
            price: '₹2,499', 
            image: 'https://via.placeholder.com/60x60/FFD700/000000?text=Blouse',
            url: '/products/golden-blouse'
          }
        ],
        isPinned: true
      },
      {
        id: 'mock_2',
        thumbnail: 'https://via.placeholder.com/300x533/A0522D/FFFFFF?text=Kurta+Style',
        video_url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        caption: 'Trendy kurta styling tips for modern women ✨ #KurtaStyle #Fashion',
        likes: 890,
        permalink: 'https://instagram.com/p/mock2',
        products: [
          { 
            id: 'kurta_1', 
            title: 'Cotton Kurta Set', 
            price: '₹1,899', 
            image: 'https://via.placeholder.com/60x60/00FF00/000000?text=Kurta',
            url: '/products/cotton-kurta-set'
          }
        ],
        isPinned: false
      },
      {
        id: 'mock_3',
        thumbnail: 'https://via.placeholder.com/300x533/8B4513/FFFFFF?text=Lehenga+Look',
        video_url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        caption: 'Stunning lehenga for wedding season 💃 #LehengaLook #WeddingWear',
        likes: 2100,
        permalink: 'https://instagram.com/p/mock3',
        products: [
          { 
            id: 'lehenga_1', 
            title: 'Designer Lehenga', 
            price: '₹24,999', 
            image: 'https://via.placeholder.com/60x60/FF69B4/FFFFFF?text=Lehenga',
            url: '/products/designer-lehenga'
          }
        ],
        isPinned: true
      },
      {
        id: 'mock_4',
        thumbnail: 'https://via.placeholder.com/300x533/A0522D/FFFFFF?text=Gown+Style',
        video_url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        caption: 'Elegant gown collection for special events 🌟 #EveningGown #SpecialOccasion',
        likes: 1680,
        permalink: 'https://instagram.com/p/mock4',
        products: [],
        isPinned: false
      },
      {
        id: 'mock_5',
        thumbnail: 'https://via.placeholder.com/300x533/8B4513/FFFFFF?text=Ethnic+Wear',
        video_url: 'https://www.w3schools.com/html/mov_bbb.mp4',
        caption: 'Mix and match ethnic wear ideas 🎨 #EthnicWear #StyleTips',
        likes: 1420,
        permalink: 'https://instagram.com/p/mock5',
        products: [
          { 
            id: 'dupatta_1', 
            title: 'Silk Dupatta', 
            price: '₹899', 
            image: 'https://via.placeholder.com/60x60/9370DB/FFFFFF?text=Dupatta',
            url: '/products/silk-dupatta'
          },
          { 
            id: 'jewelry_1', 
            title: 'Traditional Earrings', 
            price: '₹1,299', 
            image: 'https://via.placeholder.com/60x60/FFD700/000000?text=Jewelry',
            url: '/products/traditional-earrings'
          }
        ],
        isPinned: false
      }
    ];
  }

  /**
   * Clear cache (admin function)
   */
  clearCache() {
    this.cachedData = null;
    this.cacheExpiry = null;
  }
}

// Initialize global Instagram API instance
window.InstagramAPI = new InstagramAPI();

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
  module.exports = InstagramAPI;
}