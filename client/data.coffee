data = {}
data.site = {}
data.site.features = {}
data.site.features.webgl_enable = true

data.site.layouts = [
  name: 'normal'
  templates: [
    {
      name: 'sections'
      sections: [
        'header'
        'about'
        'player'
        'contribute'
        'footer'
      ]
    }
    { name: 'menu' }
  ]
]

visual = [{ name: 'pane' }, { name: 'particles' }]

if (data.site.features.webgl_enable)
  _.each visual, (template) ->
    data.site.layouts[0].templates.push(template)

data.site.sections = [
  'header'
  'about'
  'player'
  'contribute'
  'footer'
]
# if (Meteor.settings.env is 'dev') then data.site.sections.splice(2, 0, 'crappycrap')

data.paths = {}
data.paths.root = Meteor.settings.public.paths.root
data.paths.site = Meteor.settings.public.paths.site + data.paths.root
data.paths.cdn = Meteor.settings.public.paths.cdn + data.paths.root

data.site.externalDirect = false
data.site.lastPath = ''

data.site.links = {
  "social": [
    { "_id": 1, "name": "Facebook", "classname": "facebook", "url": "http://www.facebook.com/jiku115" },
    { "_id": 2, "name": "Twitter", "classname": "twitter", "url": "http://www.twitter.com/jiku_" },
    { "_id": 3, "name": "SoundCloud", "classname": "soundcloud", "url": "http://www.soundcloud.com/jiku" },
    { "_id": 4, "name": "Bandcamp", "classname": "bandcamp", "url": "http://jiku.bandcamp.com" },
    { "_id": 5, "name": "YouTube", "classname": "youtube", "url": "http://www.youtube.com/prism9" },
    { "_id": 6, "name": "Google", "classname": "google-plus", "url": "http://www.google.com/+jikuCA" }
  ]
}

module.exports = data
