class csx.Proxy
  @create: do ->
    parse = (object, path) ->
      return unless csx.Proxy.typeOf(object) == 'object' and path?
      return [object, path] if path.indexOf('.') == -1
      path = path.split('.')
      tail = path.pop()
      for property in path
        return unless object.hasOwnProperty(property)
        object = object[property]
      [object, tail]

    read = (object, path) ->
      parts = parse(object, path)
      return parts[0][parts[1]] if parts

    write = (object, path, value) ->
      parts = parse(object, path)
      if parts
        parts[0][parts[1]] = value
        value

    (object, path, value) ->
      return read(object, path) if arguments.length == 2
      return write(object, path, value) if arguments.length == 3
      console.error '[csx.Proxy.create] incorrect number of arguments'

  @typeOf: (object) ->
    return 'array' if _.isArray(object)
    return 'regexp' if _.isRegExp(object)
    typeof(object)
