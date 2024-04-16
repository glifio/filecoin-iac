return kong.response.exit(301, 'Page moved, redirecting...', { ['Location'] = 'https://${domain_name}/' })
