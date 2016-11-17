$ ->
  Dropzone.options.productPictureDropzone =
    paramName: "picture[image]",
    success: (response) ->
      eval(response.xhr.response)
