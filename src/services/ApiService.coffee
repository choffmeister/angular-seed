define ["angular"], (angular) ->
  class ApiService
    @$inject = ["$http", "$q", "events"]

    constructor: (@http, @q, @events) ->
      @baseUri = "/api/"

    get: (uri, emitErrors) =>
      @request("GET", uri, null, emitErrors)
    post: (uri, data, emitErrors) =>
      @request("POST", uri, data, emitErrors)
    put: (uri, data, emitErrors) =>
      @request("PUT", uri, data, emitErrors)
    delete: (uri, emitErrors) =>
      @request("DELETE", uri, null, emitErrors)

    request: (method, uri, data, emitErrors) =>
      deferred = @q.defer();

      @http({ method: method, url: @baseUri + uri, data: data })
        .success (response, status, headers, config) =>
          deferred.resolve(response)
        .error (response, status, headers, config) =>
          message = switch status
            when 400 then "Bad request"
            when 401 then "Authorization required"
            when 404 then "Not found"
            when 500 then "Internal server error"
            when 503 then "Service is temporarily unavailable"
            else "An unknwon error occured"
          type = switch status
            when 400 then "error"
            when 401 then "warning"
            when 404 then "warning"
            when 500 then "error"
            when 503 then "error"
            else "error"

          # at least log error to console
          console.log message, response, status, headers, config

          # emit an error message, if told so
          if not emitErrors? or emitErrors == true
            data =
              text: message
              type: type
            @events.emit "message", type, data

          deferred.reject {
            response: response
            status: status
            headers: headers
            config: config
          }

      deferred.promise

    errorResponseToMessage: (response) ->
      if response?.responseStatus?.message?
        response.responseStatus.message
      else
        response
