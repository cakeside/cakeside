class CakeSide.Models.Tutorial extends Backbone.Model
  paramRoot: 'tutorial'

  defaults:
    id: null

class CakeSide.Collections.TutorialsCollection extends Backbone.Collection
  model: CakeSide.Models.Tutorial
  url: '/api/v1/tutorials'
