React = require 'react'
Data = require '/client/data.coffee'

Icon = React.createClass
  propTypes:
    icon: React.PropTypes.object.isRequired

  render: ->
    <a className={"btn btn-icon btn-" + @props.icon.classname} href={@props.icon.url} onClick={@onClick}><i className={"fa fa-" + @props.icon.classname}></i><span>{@props.icon.name}</span></a>

  onClick: (e) -> analytics.track "Clicked Social", { service: @props.icon.name }

Social = React.createClass
  getIcons: ->
    Data.site.links.social

  renderIcons: ->
    @getIcons().map((icon) =>
      <Icon key={icon._id} icon={icon} />
    )

  render: ->
    <div id="links">
      {@renderIcons()}
    </div>

Template.footer.helpers
  Social: -> Social
