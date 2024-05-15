return kong.response.exit(301, 'Page moved, redirecting...', { ['Location'] = '${location}' })
