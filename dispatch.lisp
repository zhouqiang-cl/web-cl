(dispatch '(("/index" index-handler)
    ("/static" serve-static-dir)
    ("/" my-handler)))
