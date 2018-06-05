
# stylesheets
require './css/App.styl'

# dependencies
require 'lemonjs-ei'
require 'lemonjs-lui/Footer'
require 'lemonjs-lui/Grid'
require 'lemonjs-lui/Header'
require 'lemonjs-lui/Input'

# load icon names
icons = require 'lemonjs-ei/map.json'

# component
module.exports = lemon.Component {
  package: 'site'
  name: 'App'
  id: 'app'

  data: {
    icons: icons
    query: ''
  }

  methods: {

    onSearch: (e) ->
      clearTimeout @timeout_id if @timeout_id
      @timeout_id = setTimeout ( =>
        @query = @$search.value
      ), 300
  }

  template: (data) ->

    lui.Header {
      logo: 'lemon + evil icons'
      nav: [
        {href: 'https://github.com/lemon/ei.lemonjs.org', text: 'website'}
        {href: 'https://github.com/lemon/lemonjs-ei', text: 'library'}
      ]
    }

    div '.search', ->
      lui.Input {
        ref: '$search'
        label: 'search for an icon'
        onKeyUp: 'onSearch'
      }

    div '.icons', ->
      div _on: 'query', _template: (query, data) ->
        items = ({
          icon: ei[name]
          code: code
          name: name
        } for code, name of data.icons when name.toLowerCase().indexOf(query) > -1)
        if items.length is 0
          div '.no-match', ->
            'No icons matching your search'
        else
          lui.Grid {
            items: items
          }

    lui.Footer {}, ->
      div ->
        'Released under the MIT License'
      div ->
        '© Copyright 2018 Shenzhen239'

}
