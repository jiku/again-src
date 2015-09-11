Meteor.startup ->
  React.render(<Social />, document.getElementById("social"))

Social = React.createClass
  getIcons: ->
    staticData.social_links

  renderIcons: ->
    @getIcons().map((icon) =>
      <Icon key={icon._id} icon={icon} />
    )

  render: ->
    <div id="links">
      {@renderIcons()}
    </div>

Icon = React.createClass
  propTypes:
    icon: React.PropTypes.object.isRequired
  render: ->
    <a className={"btn btn-icon btn-" + @props.icon.classname} href={@props.icon.url}><i className={"fa fa-" + @props.icon.classname}></i><span>{@props.icon.name}</span></a>
