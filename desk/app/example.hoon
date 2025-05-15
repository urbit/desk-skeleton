:: Example agent: a one-file server-side rendered counter app
::
/+  default-agent, dbug, srv=server
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  [%0 count=@ud]
+$  card  card:agent:gall
--
::
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %.n) bowl)
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /bind %arvo %e %connect `/'example' %example]~
::
++  on-save  !>(state)
++  on-load
  |=  old=vase
  ^-  (quip card _this)
  `this(state !<(state-0 old))
::
++  on-poke
  |=  [=mark =vase]
  |^  ^-  (quip card _this)
  ?.  ?=(%handle-http-request mark)
    (on-poke:def mark vase)
  =+  !<([rid=@ta inbound-request:eyre] vase)
  ?.  =(our.bowl src.bowl)
    :_  this
    (simple rid (login request))
  =/  =pork:eyre
    %+  rash  url.request
    ;~(sfix apat:de-purl:html yquy:de-purl:html)
  ?+  pork
    :_  this
    (simple rid index)
  ::
      [[~ %css] %example %style ~]
    ?.  =(%'GET' method.request)
      :_  this
      (simple rid (bad-method 'GET'))
    :_  this
    (simple rid (response style))
  ::
      [~ %example ~]
    ?+  method.request
      :_  this
      (simple rid (bad-method 'GET, POST'))
    ::
        %'GET'
      :_  this
      (simple rid (response page))
    ::
        %'POST'
      ?~  body.request
        :_  this
        (simple rid (response page))
      =/  query  (rush q.u.body.request yquy:de-purl:html)
      ?+  query
        :_  this
        (simple rid index)
      ::
          [~ [%action %inc] ~]
        =.  count  +(count)
        :_  this
        (simple rid index)
      ::
          [~ [%action %dec] ~]
        =?  count  !=(0 count)
          (dec count)
        :_  this
        (simple rid index)
      ==
    ==
  ==
  ::'GET, POST'
  ++  simple       give-simple-payload:app:srv
  ++  css-resonse  css-response:gen:srv
  ++  response     html-response:gen:srv
  ++  login        login-redirect:gen:srv
  ++  index
    ^-  simple-payload:http
    [[302 ['Location' '/example']~] ~]
  ::
  ++  bad-method
    |=  allowed=@t
    ^-  simple-payload:http
    :-  [405 ['Allow' allowed]~]
    %-  some
    %-  as-octs:mimes:html
    '<h1>405 Method Not Allowed</h1>'
  ::
  ++  page
    %-  as-octs:mimes:html
    %-  crip
    %-  en-xml:html
    ;html
      ;head
        ;title: Example
        ;meta(charset "utf-8");
        ;link(rel "stylesheet", type "text/css", href "/example/style.css");
      ==
      ;body
        ;main
          ;h2: Counter
          ;form(method "post")
            ;button(type "submit", name "action", value "dec"): -
            ;span: {(a-co:co count)}
            ;button(type "submit", name "action", value "inc"): +
          ==
        ==
      ==
    ==
  ::
  ++  style
    ^~
    %-  as-octs:mimes:html
    '''
    body {
      font-family: system-ui, sans-serif;
      background-color: #f4f4f9;
      margin: 0;
      padding: 0;
      display: flex;
      height: 100vh;
      align-items: center;
      justify-content: center;
    }

    main {
      background: white;
      padding: 2rem 3rem;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      text-align: center;
      min-width: 240px;
    }

    h2 {
      margin: 0 0 1.5rem 0;
      font-size: 1.75rem;
      color: #333;
    }

    form {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 1rem;
    }

    button {
      background-color: #007acc;
      border: none;
      color: white;
      font-size: 1.5rem;
      padding: 0.5rem 1rem;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    button:hover {
      background-color: #005f99;
    }

    span {
      font-size: 2rem;
      font-weight: bold;
      min-width: 2ch;
    }
    '''
  --
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?.  &(=(our.bowl src.bowl) ?=([%http-response *] path)) 
    (on-watch:def path)
  `this
::
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?.  ?&  ?=([%bind ~] wire)
          ?=([%eyre %bound *] sign-arvo)
      ==
    (on-arvo:def [wire sign-arvo])
  ~?  !accepted.sign-arvo
    %eyre-rejected-binding
  `this
::
++  on-agent  on-agent:def
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
--
