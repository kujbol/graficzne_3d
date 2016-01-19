object_count = 0

class window.Sphere extends BaseObject
  constructor: (points = null) ->
    super("Shpere_#{object_count}")
    object_count++

    @settings = new SphereSettings(@)
    @settings.load_settings()

    if points is null
      @points = @create_points()
    else
      @points = points

    @create_triangles()

  create_points: () ->
    t = (1.0+math.sqrt(5.0))/2.0;
    l = math.sqrt(1 + t*t)
    t /= l
    l = 1/l

    if @points.length > 0
      p = @points
    else
      p = ({color:null} for i in [0 .. 12])

    points = [
      new Point(-l,  t,  0, p[0].color),
      new Point( l,  t,  0, p[1].color),
      new Point(-l, -t,  0, p[2].color),
      new Point( l, -t,  0, p[3].color),
      new Point( 0, -l,  t, p[4].color),
      new Point( 0,  l,  t, p[5].color),
      new Point( 0, -l, -t, p[6].color),
      new Point( 0,  l, -t, p[7].color),
      new Point( t,  0, -l, p[8].color),
      new Point( t,  0,  l, p[9].color),
      new Point(-t,  0, -l, p[10].color),
      new Point(-t,  0,  l, p[11].color),
    ]

  create_triangles: (new_points = null) ->
    if new_points
      @points = new_points
      is_in_middle = false
    else
      is_in_middle = true
    p = @points

    @triangles = [
      # 5 faces around point 0
      new Triangle(p[0], p[11], p[5]),
      new Triangle(p[0], p[5], p[1]),
      new Triangle(p[0], p[1], p[7]),
      new Triangle(p[0], p[7], p[10]),
      new Triangle(p[0], p[10], p[11]),

      # 5 adjacent faces
      new Triangle(p[1], p[5], p[9]),
      new Triangle(p[5], p[11], p[4]),
      new Triangle(p[11], p[10], p[2]),
      new Triangle(p[10], p[7], p[6]),
      new Triangle(p[7], p[1], p[8]),

      # 5 faces around point 3
      new Triangle(p[3], p[9], p[4]),
      new Triangle(p[3], p[4], p[2]),
      new Triangle(p[3], p[2], p[6]),
      new Triangle(p[3], p[6], p[8]),
      new Triangle(p[3], p[8], p[9]),

      # 5 adjacent faces
      new Triangle(p[4], p[9], p[5]),
      new Triangle(p[2], p[4], p[11]),
      new Triangle(p[6], p[2], p[10]),
      new Triangle(p[8], p[6], p[7]),
      new Triangle(p[9], p[8], p[1]),
    ]

    for i in [0 .. @settings.recursive.value]
      triangles2 = []
      for triangle in @triangles
        a = @middle_point(triangle.p1, triangle.p2, is_in_middle)
        b = @middle_point(triangle.p2, triangle.p3, is_in_middle)
        c = @middle_point(triangle.p3, triangle.p1, is_in_middle)

        triangles2.push(new Triangle(triangle.p1, a, c))
        triangles2.push(new Triangle(triangle.p2, b, a))
        triangles2.push(new Triangle(triangle.p3, c, b))
        triangles2.push(new Triangle(a, b, c))

      @triangles = triangles2

  middle_point: (p1, p2, is_in_middle=true) ->
    middle = new Point(
      (p1.x+p2.x)/2,
      (p1.y+p2.y)/2,
      (p1.z+p2.z)/2
    )
    if is_in_middle
      length = math.sqrt(middle.x*middle.x+middle.y*middle.y+middle.z*middle.z)
    else
      length = math.sqrt(middle.x*middle.x+middle.y*middle.y+middle.z*middle.z)
    middle.x /= length
    middle.y /= length
    middle.z /= length

    for point in @points
      if point.is_same(middle)
        return point

    @points.push(middle)
    return middle