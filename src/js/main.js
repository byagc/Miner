var loginRequired;

function onLoad()
{
  loginRequired = <#loginRequired>;
  setConnection('<#host>', '<#port>', '<#urlpath>');
  if (loginRequired)
  {
    showLogin(true);
  }
  else
  {
    if (setCredentials('', ''))
      createClassTree();
    else
      alert('Connection error');
  }
}
