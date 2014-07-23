# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.add-to-playlist').on 'ajax:error', (event, xhr, status, foo) ->
    if status  is 'error'
      error = """
        <div class="alert alert-danger alert-dismissible" role="alert">
          <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
          You must <a href='/users/sign_in' class="alert-link">Log in</a> to add stuff to a playlist
        </div>
       """
    $('.alerts').append(error);
