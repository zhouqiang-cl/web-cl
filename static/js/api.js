function post_article(title, content) {
    data = {};
    data["title"] = title;
    data["content"] = content;
    $.ajax({
        url:"/api/v1/items",
        type:"POST",
        dataType:"json",
        async:"false",
        data:data,
        success: function (data) {
            item_id = data["id"];
            url =  data["url"];
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function update_article(title, content, item_id) {
    data = {};
    data["title"] = title;
    data["content"] = content;
    url = "/api/v1/items/" + item_id
    $.ajax({
        url:url,
        type:"PUT",
        dataType:"json",
        async:"false",
        data:data,
        success: function (data) {
            item_id = data["id"];
            url =  data["url"];
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function get_article(item_id) {
    url = "/api/v1/items/" + item_id
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            data = data;
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}

function get_articles() {
    url = "/api/v1/items"
    $.ajax({
        url:url,
        type:"GET",
        dataType:"json",
        async:"false",
        success: function (data) {
            data = data;
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }
    });
}