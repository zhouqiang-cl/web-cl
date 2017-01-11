function post_article(title, content, mdeinstance) {
    data = {};
    data["title"] = title;
    data["content"] = content;
    $.ajax({
        url:"/api/v1/blog/articles",
        type:"POST",
        dataType:"json",
        async:"false",
        data:data,
        success: function (data) {
            item_id = data["id"];
            url =  data["url"];
            window.location.href = url;
            mdeinstance.clearAutosavedValue();
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function update_article(title, content, item_id, mdeinstance) {
    data = {};
    data["title"] = title;
    data["content"] = content;
    url = "/api/v1/blog/articles/update/" + item_id
    $.ajax({
        url:url,
        type:"POST",
        dataType:"json",
        async:"false",
        data:data,
        success: function (data) {
            item_id = data["id"];
            url =  data["url"];
            window.location.href = url;
            mdeinstance.clearAutosavedValue();
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function get_article(item_id, contentid) {
    url = "/api/v1/blog/articles/" + item_id
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            title = data["title"];
            content = data["content"];
            views = data["views"]
            update_at = convert_timestamp_to_daytime(data["update-at"])
            marked.setOptions({
              breaks: true,
            });
            content = "<h2>" + title + "</h2><hr>" + content;
            content += "<br/><br/><hr><br/><br/>";
            content += "<span id='update-at'>Update At: " + update_at + "</span>";
            content += "<span id='view-time'>views:  " + views + "</span>";
            console.log(content)
            contentid.html(marked(content))
        },
        error: function (jqXHR, status, errorThrown) {
            var data = jqXHR.responseJSON;
            if(jqXHR.status == 404) {
                    redirect_url = data["redirect-url"];
                    window.location.href = redirect_url;
            }
        }
    });
}

function get_article_for_edit(item_id, simplemde) {
    url = "/api/v1/blog/articles/" + item_id
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            title = data["title"];
            content = data["content"];
            $("#title").val(title)
            simplemde.value(content)
            // $("#title").val(title)            
        },
        error: function (jqXHR, status, errorThrown) {
            var data = jqXHR.responseJSON;
            if(jqXHR.status == 404) {
                    redirect_url = data["redirect-url"];
                    window.location.href = redirect_url;
            }
        }
    });
}

function get_articles(contentid) {
    url = "/api/v1/blog/articles"
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            content = '<table class="table article-table">'
            for (item in data) {
                content = content + construct_item(data[item])
            } 
            content += "</table>"
            contentid.html(content)
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function get_edit_articles(contentid) {
    url = "/api/v1/blog/articles"
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            content = '<table class="table article-table">'
            for (item in data) {
                content = content + construct_edit_item(data[item])
            } 
            content += "</table>"
            contentid.html(content)
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function construct_item(item) {
    var item_html = "<tr><td><a href=" + item["url"] + ">" + item["title"] + "</a></td></tr>"
    return item_html
}

function construct_edit_item(item) {
    var item_html = "<tr><td><a href=" + item["url"] + "/edit>" + item["title"] + "</a></td></tr>"
    return item_html
}
