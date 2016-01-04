objects = []

class window.BaseObject
  constructor: () ->
    @points = []
    @triangles = []
    @settings = new BaseSettings()

class window.Point
  constructor: (@x, @y, @z) ->

  is_same: (point) ->
    point.x == @x and point.y == @y and point.z == @z

class window.Triangle
  constructor: (@p1, @p2, @p3) ->

  is_same: (triangle) ->
    triangle.p1 == @p1 and triangle.p2 == @p2 and triangle.p3 == @p3