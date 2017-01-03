function login(username, password) {
    data = {}
    data["username"] = username;
    data["password"] = password;
    $.ajax({
        url:"/login",
        type:"POST",
        dataType:"json",
        async:"false",
        data:data,
        success: function (data) {
            redirect_url = data["redirect-url"];
            status = data["status"]
            window.location.href = redirect_url;
        },
        error: function (jqXHR, status, errorThrown) {
            window.alert(jqXHR.message);
        }

    })
}