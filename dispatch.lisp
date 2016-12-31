(dispatch '(("/index" index-handler)
    ("/static" serve-static-dir)
    ("/api/v1/items" upload-article)
    ("/" my-handler)))
