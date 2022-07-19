proxy_set_header Authorization $calibrationapi_jwt;
proxy_cache_bypass      $http_upgrade;
