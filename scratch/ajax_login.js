//sign in:
username = "foo1@bar.com";
password = "foobarbaz";
$.ajax({
  'url': '/users/sign_in',
  'type': 'POST',
  'otherSettings': 'othervalues',
  'beforeSend': function(xhr) {
    xhr.setRequestHeader("Authorization", "Basic " + btoa(username + ":" + password))
  },
  sucess: function(result) {
            alert('done');
          }
});

//sign out
$.ajax({
  'url': '/users/sign_out',
  'type': 'DELETE',
  'otherSettings': 'othervalues',
  sucess: function(result) {
    alert('done');
  }
});
