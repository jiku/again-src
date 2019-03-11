# BrowserPolicy.framing.disallow()
# BrowserPolicy.content.disallowInlineScripts()
# BrowserPolicy.content.disallowEval()
# BrowserPolicy.content.allowConnectOrigin(__meteor_runtime_config__.ROOT_URL)
BrowserPolicy.content.allowDataUrlForAll()
BrowserPolicy.content.allowScriptDataUrl()
BrowserPolicy.content.allowInlineStyles()
BrowserPolicy.content.allowFontDataUrl()
BrowserPolicy.content.allowEval()
BrowserPolicy.content.allowInlineScripts()
BrowserPolicy.framing.allowAll() # For GoDaddy masking
trusted = [
  '*.gstatic.com'
  '*.googleapis.com'
  '*.google-analytics.com'
  '*.doubleclick.net'
  '*.astronomer.io'
  '*.soundcloud.com'
  '*.sndcdn.com'
  '*.cloudflare.com'
  '*.bootstrapcdn.com'
  '*.cloudfront.net'
  'localhost:*'
  'dev.jiku'
  'jiku.ca'
  '*.jiku.ca'
  'cdn.jiku.ca'
  # 'jikudev.ca'
  # '*.jikudev.ca'
  # 'cdn.jikudev.ca'
  # 'amazonaws.com'
  # '*.amazonaws.com'
  'ec2-52-28-71-128.eu-central-1.compute.amazonaws.com',
  '*.local'
]
_.each trusted, (origin) ->
  BrowserPolicy.content.allowOriginForAll "http://#{origin}"
  BrowserPolicy.content.allowOriginForAll "https://#{origin}"

# _.each trusted, (origin) ->
#   origin = 'http://' + origin
#   BrowserPolicy.content.allowOriginForAll origin
#   origin = 'https://' + origin
#   BrowserPolicy.content.allowOriginForAll origin

# BrowserPolicy.content.disallowInlineScripts()
# BrowserPolicy.content.disallowEval()
# BrowserPolicy.content.allowInlineStyles()
# BrowserPolicy.content.allowFontDataUrl()
